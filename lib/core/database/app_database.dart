import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'create_invoice_request.dart';
import 'daos/audit_dao.dart';
import 'daos/categories_dao.dart';
import 'daos/invoices_dao.dart';
import 'daos/products_dao.dart';
import 'daos/store_config_dao.dart';
import 'daos/sync_queue_dao.dart';
import 'daos/transaction_dao.dart';
import 'daos/users_dao.dart';
import 'phase9_requests.dart';
import 'tables/audit_log_table.dart';
import 'tables/cancellation_requests_table.dart';
import 'tables/credit_notes_table.dart';
import 'tables/daily_reports_table.dart';
import 'tables/categories_table.dart';
import 'tables/invoice_items_table.dart';
import 'tables/invoices_table.dart';
import 'tables/payments_table.dart';
import 'tables/products_table.dart';
import 'tables/store_config_table.dart';
import 'tables/sync_queue_table.dart';
import 'tables/users_table.dart';

part 'app_database.g.dart';

/// The single Drift database instance for the entire POS application.
///
/// Storage is a plain SQLite file via `drift_flutter`'s `NativeDatabase`.
/// Encryption (sqlite3mc / SQLCipher) is not yet wired up — see the deferred
/// security work item in the project README. Until then, the database file
/// must be treated as sensitive: protect device file-system access and do
/// not log or export raw fiscal payloads to untrusted locations.
///
/// In tests, [AppDatabase.forTesting] uses `NativeDatabase.memory()` for
/// instant in-memory testing.
@DriftDatabase(
  tables: [
    StoreConfigs,
    Users,
    Categories,
    Products,
    Invoices,
    InvoiceItems,
    Payments,
    SyncQueue,
    AuditLogs,
    CreditNotes,
    CreditNoteItems,
    CancellationRequests,
    DailyReports,
  ],
  daos: [
    StoreConfigDao,
    UsersDao,
    CategoriesDao,
    ProductsDao,
    InvoicesDao,
    SyncQueueDao,
    AuditDao,
    TransactionDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  /// Production constructor — call with a real QueryExecutor.
  AppDatabase(super.e);

  /// Test constructor — uses an in-memory database.
  AppDatabase.forTesting() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        await m.createTable(categories);
        await m.createTable(products);
      }
      if (from < 3) {
        await m.createTable(invoices);
        await m.createTable(invoiceItems);
        await m.createTable(payments);
        await m.createTable(syncQueue);
        await m.createTable(auditLogs);
      }
      if (from < 4) {
        await m.createTable(creditNotes);
        await m.createTable(creditNoteItems);
        await m.createTable(cancellationRequests);
        await m.createTable(dailyReports);
      }
      if (from < 5) {
        // Extend sync_queue with status lifecycle fields.
        // Extend audit_logs with the deterministic payload used for hashing.
        await _ensurePhase10Columns();
      }
      if (from < 6) {
        // Add per-user salt and PBKDF2 iteration count. Both columns are
        // nullable so existing unsalted SHA-256 rows continue to work and are
        // transparently re-hashed on the next successful login.
        await _ensurePasswordColumns();
      }
    },
    beforeOpen: (details) async {
      await _ensurePhase10Columns();
      await _ensurePasswordColumns();
      await customStatement('PRAGMA foreign_keys = ON;');
    },
  );

  Future<void> _ensurePhase10Columns() async {
    // Wrap the repair in a transaction so that a partially migrated schema
    // cannot be left behind if any single ALTER fails during startup.
    return transaction(() async {
      final tables = await customSelect(
        "SELECT name FROM sqlite_master WHERE type = 'table' AND name IN ('sync_queue', 'audit_logs')",
      ).get();
      final tableNames = tables.map((row) => row.read<String>('name')).toSet();

      if (tableNames.contains('sync_queue')) {
        final columns = await customSelect("PRAGMA table_info('sync_queue')")
            .get();
        final names = columns.map((row) => row.read<String>('name')).toSet();
        if (!names.contains('last_error')) {
          await customStatement(
            'ALTER TABLE sync_queue ADD COLUMN last_error TEXT NULL',
          );
        }
        if (!names.contains('updated_at')) {
          await customStatement(
            'ALTER TABLE sync_queue ADD COLUMN updated_at INTEGER NOT NULL DEFAULT 0',
          );
          await customStatement(
            'UPDATE sync_queue SET updated_at = created_at WHERE updated_at = 0',
          );
        }
        if (!names.contains('last_attempt_at')) {
          await customStatement(
            'ALTER TABLE sync_queue ADD COLUMN last_attempt_at INTEGER NULL',
          );
        }
        if (!names.contains('synced_at')) {
          await customStatement(
            'ALTER TABLE sync_queue ADD COLUMN synced_at INTEGER NULL',
          );
        }
      }

      if (tableNames.contains('audit_logs')) {
        final columns = await customSelect("PRAGMA table_info('audit_logs')")
            .get();
        final names = columns.map((row) => row.read<String>('name')).toSet();
        if (!names.contains('payload')) {
          await customStatement(
            'ALTER TABLE audit_logs ADD COLUMN payload TEXT NULL',
          );
        }
      }
    });
  }

  /// Adds the v6 password salt/iteration columns if a partially migrated
  /// database is missing them. Idempotent and safe on fresh installs.
  Future<void> _ensurePasswordColumns() async {
    return transaction(() async {
      final tables = await customSelect(
        "SELECT name FROM sqlite_master WHERE type = 'table' AND name = 'users'",
      ).get();
      if (tables.isEmpty) return;

      final columns = await customSelect("PRAGMA table_info('users')").get();
      final names = columns.map((row) => row.read<String>('name')).toSet();
      if (!names.contains('password_salt')) {
        await customStatement(
          'ALTER TABLE users ADD COLUMN password_salt TEXT NULL',
        );
      }
      if (!names.contains('password_iterations')) {
        await customStatement(
          'ALTER TABLE users ADD COLUMN password_iterations INTEGER NULL',
        );
      }
    });
  }

  // ─── Delegating accessors ───────────────────────────────────────────
  //
  // Thin forwarders to the extracted DAOs. Existing callers (repositories,
  // data sources, tests) continue to use `db.<method>()`; new code should
  // depend on the DAOs directly via DI for cleaner boundaries.

  // Store config
  Future<StoreConfig?> getStoreConfig() => storeConfigDao.getStoreConfig();
  Future<int> saveStoreConfig(StoreConfigsCompanion config) =>
      storeConfigDao.saveStoreConfig(config);
  Future<bool> isDeviceActivated() => storeConfigDao.isDeviceActivated();

  // Users
  Future<List<User>> getActiveUsers() => usersDao.getActiveUsers();
  Future<List<User>> getAllUsers() => usersDao.getAllUsers();
  Future<User?> getUserById(String id) => usersDao.getUserById(id);
  Future<int> insertUser(UsersCompanion user) => usersDao.insertUser(user);
  Future<bool> updateUser(UsersCompanion user) => usersDao.updateUser(user);
  Future<bool> hasManager() => usersDao.hasManager();
  Future<User?> findUserByUsername(String username) =>
      usersDao.findUserByUsername(username);

  // Categories
  Future<List<Category>> getAllCategories() => categoriesDao.getAllCategories();
  Future<Category?> getCategoryById(String id) =>
      categoriesDao.getCategoryById(id);
  Future<int> upsertCategory(CategoriesCompanion category) =>
      categoriesDao.upsertCategory(category);

  // Products
  Future<List<Product>> getAllProducts({bool activeOnly = false}) =>
      productsDao.getAllProducts(activeOnly: activeOnly);
  Future<List<Product>> getProductsByCategory(String categoryId) =>
      productsDao.getProductsByCategory(categoryId);
  Future<List<Product>> searchProducts(String query) =>
      productsDao.searchProducts(query);
  Future<Product?> getProductById(String id) => productsDao.getProductById(id);
  Future<Product?> findProductByBarcode(String barcode) =>
      productsDao.findProductByBarcode(barcode);
  Future<int> insertProduct(ProductsCompanion product) =>
      productsDao.insertProduct(product);
  Future<bool> updateProduct(ProductsCompanion product) =>
      productsDao.updateProduct(product);
  Future<int> countProducts() => productsDao.countProducts();

  // Invoices / checkout
  Future<Invoice> createInvoiceTransaction(CreateInvoiceDbRequest request) =>
      transactionDao.createInvoiceTransaction(request);
  Future<Invoice?> getInvoiceById(int invoiceId) =>
      invoicesDao.getInvoiceById(invoiceId);
  Future<Invoice?> getInvoiceByNumber(int number) =>
      invoicesDao.getInvoiceByNumber(number);
  Future<List<InvoiceItem>> getInvoiceItemsByInvoiceId(int invoiceId) =>
      invoicesDao.getInvoiceItemsByInvoiceId(invoiceId);
  Future<Payment?> getPaymentByInvoiceId(int invoiceId) =>
      invoicesDao.getPaymentByInvoiceId(invoiceId);
  Future<SyncQueueData?> getSyncQueueEntryByInvoiceId(int invoiceId) =>
      syncQueueDao.getSyncQueueById(invoiceId);
  Future<List<AuditLog>> getAuditLogsByInvoiceId(int invoiceId) =>
      auditDao.getAuditLogsByInvoiceId(invoiceId);

  // Sync queue
  Future<List<SyncQueueData>> getAllSyncQueue({bool newestFirst = true}) =>
      syncQueueDao.getAllSyncQueue(newestFirst: newestFirst);
  Future<List<SyncQueueData>> getActionableSyncQueue() =>
      syncQueueDao.getActionableSyncQueue();
  Future<SyncQueueData?> getSyncQueueById(int id) =>
      syncQueueDao.getSyncQueueById(id);
  Future<SyncQueueData?> getOldestUnsynced() =>
      syncQueueDao.getOldestUnsynced();
  Future<int> updateSyncQueueById(int id, SyncQueueCompanion companion) =>
      syncQueueDao.updateSyncQueueById(id, companion);
  Future<int> countSyncQueueByStatus(String status) =>
      syncQueueDao.countSyncQueueByStatus(status);

  // Audit
  Future<List<AuditLog>> getAllAuditLogs({bool newestFirst = true}) =>
      auditDao.getAllAuditLogs(newestFirst: newestFirst);

  // Credit notes / cancellations / reports
  Future<double> getReturnedQuantity(int invoiceItemId) =>
      transactionDao.getReturnedQuantity(invoiceItemId);
  Future<CreditNote> createCreditNoteTransaction(
    CreateCreditNoteRequest request,
  ) => transactionDao.createCreditNoteTransaction(request);
  Future<CancellationRequest> createCancellationTransaction(
    CreateCancellationRequest request,
  ) => transactionDao.createCancellationTransaction(request);
  Future<ReportTotals> generateXReport(DateTime date) =>
      transactionDao.generateXReport(date);
  Future<DailyReport> closeZReportTransaction({
    required DateTime date,
    required String managerId,
    required double cashCount,
  }) => transactionDao.closeZReportTransaction(
    date: date,
    managerId: managerId,
    cashCount: cashCount,
  );

  /// Serialises a map with sorted keys into deterministic JSON.
  ///
  /// Kept on [AppDatabase] for backward compatibility with callers that
  /// reference `AppDatabase.toDeterministicJson`. The canonical
  /// implementation now lives in [TransactionDao].
  static String toDeterministicJson(Map<String, dynamic> map) =>
      TransactionDao.toDeterministicJson(map);
}
