import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'create_invoice_request.dart';
import 'tables/audit_log_table.dart';
import 'tables/categories_table.dart';
import 'tables/invoice_items_table.dart';
import 'tables/invoices_table.dart';
import 'tables/payments_table.dart';
import 'tables/products_table.dart';
import 'tables/store_config_table.dart';
import 'tables/sync_queue_table.dart';
import 'tables/users_table.dart';
import '../utils/hash_chain.dart';

part 'app_database.g.dart';

/// The single Drift database instance for the entire POS application.
///
/// In production, this uses an encrypted SQLite file via sqlite3mc.
/// In tests, this uses NativeDatabase.memory() for instant in-memory testing.
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
  ],
)
class AppDatabase extends _$AppDatabase {
  /// Production constructor — call with a real QueryExecutor.
  AppDatabase(super.e);

  /// Test constructor — uses an in-memory database.
  AppDatabase.forTesting() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 3;

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
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON;');
    },
  );

  // ─── Store Config DAO ───────────────────────────────────────────────

  /// Get the stored configuration (returns null if device not activated).
  Future<StoreConfig?> getStoreConfig() async {
    return (select(storeConfigs)..limit(1)).getSingleOrNull();
  }

  /// Save store configuration during activation.
  Future<int> saveStoreConfig(StoreConfigsCompanion config) {
    return into(storeConfigs).insert(config);
  }

  /// Check if the device has been activated.
  Future<bool> isDeviceActivated() async {
    final config = await getStoreConfig();
    return config != null;
  }

  // ─── Users DAO ──────────────────────────────────────────────────────

  /// Get all active users.
  Future<List<User>> getActiveUsers() {
    return (select(users)..where((u) => u.isActive.equals(true))).get();
  }

  /// Get a user by ID.
  Future<User?> getUserById(String id) {
    return (select(users)..where((u) => u.id.equals(id))).getSingleOrNull();
  }

  /// Insert a new user (manager or cashier).
  Future<int> insertUser(UsersCompanion user) {
    return into(users).insert(user);
  }

  /// Update a user (e.g. PIN change, deactivation).
  Future<bool> updateUser(UsersCompanion user) {
    return (update(users)..where((u) => u.id.equals(user.id.value)))
        .write(user)
        .then((rows) => rows > 0);
  }

  /// Check if any manager exists.
  Future<bool> hasManager() async {
    final managers = await (select(
      users,
    )..where((u) => u.role.equals('MANAGER') & u.isActive.equals(true))).get();
    return managers.isNotEmpty;
  }

  /// Find an active user by username.
  Future<User?> findUserByUsername(String username) {
    return (select(users)
          ..where((u) => u.username.equals(username) & u.isActive.equals(true)))
        .getSingleOrNull();
  }

  // ─── Categories DAO ─────────────────────────────────────────────────

  /// Get all categories ordered by name.
  Future<List<Category>> getAllCategories() {
    return (select(
      categories,
    )..orderBy([(c) => OrderingTerm(expression: c.name)])).get();
  }

  /// Get a category by ID.
  Future<Category?> getCategoryById(String id) {
    return (select(
      categories,
    )..where((c) => c.id.equals(id))).getSingleOrNull();
  }

  /// Insert or replace a category.
  Future<int> upsertCategory(CategoriesCompanion category) {
    return into(categories).insertOnConflictUpdate(category);
  }

  // ─── Products DAO ───────────────────────────────────────────────────

  /// Get all products with optional active-only filter.
  Future<List<Product>> getAllProducts({bool activeOnly = false}) {
    final query = select(products)
      ..orderBy([(p) => OrderingTerm(expression: p.name)]);
    if (activeOnly) {
      query.where((p) => p.isActive.equals(true));
    }
    return query.get();
  }

  /// Get products by category.
  Future<List<Product>> getProductsByCategory(String categoryId) {
    return (select(products)
          ..where((p) => p.categoryId.equals(categoryId))
          ..orderBy([(p) => OrderingTerm(expression: p.name)]))
        .get();
  }

  /// Search products by name or barcode (case-insensitive).
  Future<List<Product>> searchProducts(String query) {
    final likeQuery = '%${query.toLowerCase()}%';
    return (select(products)
          ..where(
            (p) =>
                p.name.lower().like(likeQuery) |
                p.barcode.lower().like(likeQuery),
          )
          ..orderBy([(p) => OrderingTerm(expression: p.name)]))
        .get();
  }

  /// Get a product by ID.
  Future<Product?> getProductById(String id) {
    return (select(products)..where((p) => p.id.equals(id))).getSingleOrNull();
  }

  /// Find a product by barcode.
  Future<Product?> findProductByBarcode(String barcode) {
    return (select(
      products,
    )..where((p) => p.barcode.equals(barcode))).getSingleOrNull();
  }

  /// Insert a product.
  Future<int> insertProduct(ProductsCompanion product) {
    return into(products).insert(product);
  }

  /// Update a product.
  Future<bool> updateProduct(ProductsCompanion product) {
    return (update(products)..where((p) => p.id.equals(product.id.value)))
        .write(product)
        .then((rows) => rows > 0);
  }

  /// Count existing products (useful for seeding checks).
  Future<int> countProducts() async {
    final result = await (selectOnly(
      products,
    )..addColumns([products.id.count()])).getSingle();
    return result.read(products.id.count()) ?? 0;
  }

  // ─── Invoices / Checkout DAO ────────────────────────────────────────

  /// Atomically creates an invoice, its line items, payment record, a pending
  /// sync entry, and an audit-log entry with a chained SHA-256 hash.
  ///
  /// The whole operation runs inside a single Drift transaction so that either
  /// all rows are persisted or none are. The device-local invoice number is
  /// derived as max(existing) + 1 inside the transaction.
  Future<Invoice> createInvoiceTransaction(CreateInvoiceDbRequest request) {
    return transaction(() async {
      // 1. Compute the next device-local invoice number.
      final maxExpr = invoices.invoiceNumber.max();
      final maxRow = await (selectOnly(
        invoices,
      )..addColumns([maxExpr])).getSingle();
      final nextNumber = (maxRow.read(maxExpr) ?? 0) + 1;

      // 2. Hash-chain anchor from the most recent audit entry.
      final lastAudit =
          await (select(auditLogs)
                ..orderBy([(a) => OrderingTerm.desc(a.id)])
                ..limit(1))
              .getSingleOrNull();
      final previousHash = lastAudit?.currentHash ?? '';

      // 3. Deterministic payload is supplied by the caller; the invoice number
      //    is injected here so the caller cannot accidentally use a stale value.
      final payload = request.payloadBuilder(nextNumber);
      final currentHash = HashChain.computeHash(previousHash, payload);

      // 4. Insert invoice header.
      final invoiceId = await into(invoices).insert(
        InvoicesCompanion.insert(
          invoiceNumber: nextNumber,
          cashierId: request.cashierId,
          buyerTin: request.buyerTin == null
              ? const Value.absent()
              : Value(request.buyerTin!),
          netTotal: request.netTotal,
          vatTotal: request.vatTotal,
          grossTotal: request.grossTotal,
          status: Value(request.status),
          payload: payload,
          previousHash: previousHash,
          currentHash: currentHash,
        ),
      );

      // 5. Insert line items.
      for (final item in request.items) {
        await into(invoiceItems).insert(
          InvoiceItemsCompanion.insert(
            invoiceId: invoiceId,
            productId: item.productId,
            productName: item.productName,
            unitPrice: item.unitPrice,
            quantity: Value(item.quantity),
            vatRate: Value(item.vatRate),
            netAmount: item.netAmount,
            vatAmount: item.vatAmount,
            grossAmount: item.grossAmount,
          ),
        );
      }

      // 6. Insert payment record.
      await into(payments).insert(
        PaymentsCompanion.insert(
          invoiceId: invoiceId,
          method: request.paymentMethod,
          amount: request.paymentAmount,
          cashTendered: request.cashTendered == null
              ? const Value.absent()
              : Value(request.cashTendered!),
          referenceCode: request.paymentReference == null
              ? const Value.absent()
              : Value(request.paymentReference!),
        ),
      );

      // 7. Queue the invoice for backend sync.
      await into(syncQueue).insert(
        SyncQueueCompanion.insert(
          invoiceId: invoiceId,
          operation: request.syncOperation,
          payload: payload,
        ),
      );

      // 8. Append the tamper-evident audit entry.
      await into(auditLogs).insert(
        AuditLogsCompanion.insert(
          action: request.auditAction,
          invoiceId: Value(invoiceId),
          userId: request.auditUserId,
          details: 'Invoice #$nextNumber created by ${request.cashierId}',
          previousHash: previousHash,
          currentHash: currentHash,
        ),
      );

      // 9. Return the fully persisted invoice header.
      return (select(
        invoices,
      )..where((i) => i.id.equals(invoiceId))).getSingle();
    });
  }

  /// Get the line items for a given invoice ID.
  Future<List<InvoiceItem>> getInvoiceItemsByInvoiceId(int invoiceId) {
    return (select(invoiceItems)
          ..where((i) => i.invoiceId.equals(invoiceId))
          ..orderBy([(i) => OrderingTerm(expression: i.id)]))
        .get();
  }

  /// Get the payment record for a given invoice ID.
  Future<Payment?> getPaymentByInvoiceId(int invoiceId) {
    return (select(payments)
          ..where((p) => p.invoiceId.equals(invoiceId))
          ..limit(1))
        .getSingleOrNull();
  }

  /// Get the pending sync queue entry for a given invoice ID.
  Future<SyncQueueData?> getSyncQueueEntryByInvoiceId(int invoiceId) {
    return (select(syncQueue)
          ..where((s) => s.invoiceId.equals(invoiceId))
          ..limit(1))
        .getSingleOrNull();
  }

  /// Get the audit entries for a given invoice ID.
  Future<List<AuditLog>> getAuditLogsByInvoiceId(int invoiceId) {
    return (select(auditLogs)
          ..where((a) => a.invoiceId.equals(invoiceId))
          ..orderBy([(a) => OrderingTerm.desc(a.id)]))
        .get();
  }

  /// Serialises a map with sorted keys into deterministic JSON.
  static String toDeterministicJson(Map<String, dynamic> map) {
    final sorted = _sortMap(map);
    return const JsonCodec().encode(sorted);
  }

  static Map<String, dynamic> _sortMap(Map<String, dynamic> map) {
    final sorted = <String, dynamic>{};
    for (final key in map.keys.toList()..sort()) {
      final value = map[key];
      if (value is Map<String, dynamic>) {
        sorted[key] = _sortMap(value);
      } else if (value is List) {
        sorted[key] = value.map((e) {
          if (e is Map<String, dynamic>) return _sortMap(e);
          return e;
        }).toList();
      } else {
        sorted[key] = value;
      }
    }
    return sorted;
  }
}
