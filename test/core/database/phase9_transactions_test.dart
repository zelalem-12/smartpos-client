import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartpos_client/core/database/app_database.dart';
import 'package:smartpos_client/core/database/create_invoice_request.dart';
import 'package:smartpos_client/core/database/phase9_requests.dart';
import 'package:smartpos_client/core/utils/hash_chain.dart';

void main() {
  late AppDatabase db;
  setUp(() async {
    db = AppDatabase.forTesting();
    for (final user in [('cashier', 'CASHIER'), ('manager', 'MANAGER')]) {
      await db.insertUser(
        UsersCompanion.insert(
          id: user.$1,
          username: user.$1,
          fullName: user.$1,
          role: user.$2,
          passwordHash: 'hash',
        ),
      );
    }
  });
  tearDown(() => db.close());

  Future<Invoice> invoice({
    int quantity = 2,
    double gross = 230,
    String method = 'cash',
  }) {
    final net = gross / 1.15;
    return db.createInvoiceTransaction(
      CreateInvoiceDbRequest(
        cashierId: 'cashier',
        netTotal: net,
        vatTotal: gross - net,
        grossTotal: gross,
        status: 'PENDING_SYNC',
        items: [
          CreateInvoiceItemDbRequest(
            productId: 'p',
            productName: 'Product',
            unitPrice: gross / quantity,
            quantity: quantity,
            vatRate: .15,
            netAmount: net,
            vatAmount: gross - net,
            grossAmount: gross,
          ),
        ],
        paymentMethod: method,
        paymentAmount: gross,
        payloadBuilder: (n) => AppDatabase.toDeterministicJson({'number': n}),
        syncOperation: 'CREATE_INVOICE',
        auditAction: 'INVOICE_CREATED',
        auditUserId: 'cashier',
      ),
    );
  }

  Future<List<String>> tableColumns(String table) async {
    final rows = await db.customSelect('PRAGMA table_info($table)').get();
    return rows.map((r) => r.read<String>('name')).toList();
  }

  test('schema v6 exposes all fiscal tables and new columns', () async {
    expect(db.schemaVersion, 6);
    final names =
        (await db
                .customSelect(
                  "select name from sqlite_master where type='table'",
                )
                .get())
            .map((r) => r.read<String>('name'));
    expect(
      names,
      containsAll([
        'credit_notes',
        'credit_note_items',
        'cancellation_requests',
        'daily_reports',
      ]),
    );

    final syncColumns = await tableColumns('sync_queue');
    expect(syncColumns, contains('last_error'));
    expect(syncColumns, contains('updated_at'));
    expect(syncColumns, contains('last_attempt_at'));
    expect(syncColumns, contains('synced_at'));

    final auditColumns = await tableColumns('audit_logs');
    expect(auditColumns, contains('payload'));

    final userColumns = await tableColumns('users');
    expect(userColumns, contains('password_salt'));
    expect(userColumns, contains('password_iterations'));
  });

  test(
    'partial and full credits sequence, totals, hashes and queues',
    () async {
      final sale = await invoice();
      final item = (await db.getInvoiceItemsByInvoiceId(sale.id)).single;
      final first = await db.createCreditNoteTransaction(
        CreateCreditNoteRequest(
          invoiceId: sale.id,
          managerId: 'manager',
          reason: 'Return',
          items: [CreditNoteLineRequest(item.id, 1)],
        ),
      );
      final second = await db.createCreditNoteTransaction(
        CreateCreditNoteRequest(
          invoiceId: sale.id,
          managerId: 'manager',
          reason: 'Return rest',
          items: [CreditNoteLineRequest(item.id, 1)],
        ),
      );
      expect([first.creditNoteNumber, second.creditNoteNumber], [1, 2]);
      expect(first.grossTotal, closeTo(115, .001));
      expect(await db.getReturnedQuantity(item.id), 2);
      final audits = await db.getAuditLogsByInvoiceId(sale.id);
      expect(audits.first.previousHash, audits[1].currentHash);
      expect(
        audits.first.currentHash,
        HashChain.computeHash(audits.first.previousHash, second.payload),
      );
      final queues = await (db.select(
        db.syncQueue,
      )..where((q) => q.invoiceId.equals(sale.id))).get();
      expect(
        queues.where((q) => q.operation == 'CREATE_CREDIT_NOTE'),
        hasLength(2),
      );
      expect((await db.getInvoiceById(sale.id))!.grossTotal, 230);
    },
  );

  test(
    'over-return rolls back every business, queue and audit write',
    () async {
      final sale = await invoice();
      final item = (await db.getInvoiceItemsByInvoiceId(sale.id)).single;
      final auditBefore = (await db.getAuditLogsByInvoiceId(sale.id)).length;
      expect(
        () => db.createCreditNoteTransaction(
          CreateCreditNoteRequest(
            invoiceId: sale.id,
            managerId: 'manager',
            reason: 'Bad',
            items: [CreditNoteLineRequest(item.id, 3)],
          ),
        ),
        throwsStateError,
      );
      expect(await db.select(db.creditNotes).get(), isEmpty);
      expect((await db.getAuditLogsByInvoiceId(sale.id)).length, auditBefore);
    },
  );

  test(
    'cancellation validates reason, age, pending status and duplicates',
    () async {
      final sale = await invoice();
      expect(
        () => db.createCancellationTransaction(
          CreateCancellationRequest(
            invoiceId: sale.id,
            managerId: 'manager',
            reason: '',
            now: DateTime.now(),
          ),
        ),
        throwsArgumentError,
      );
      await db.createCancellationTransaction(
        CreateCancellationRequest(
          invoiceId: sale.id,
          managerId: 'manager',
          reason: 'Duplicate',
          now: DateTime.now(),
        ),
      );
      expect(
        (await db.getInvoiceById(sale.id))!.status,
        'PENDING_CANCELLATION',
      );
      expect(
        () => db.createCancellationTransaction(
          CreateCancellationRequest(
            invoiceId: sale.id,
            managerId: 'manager',
            reason: 'Duplicate',
            now: DateTime.now(),
          ),
        ),
        throwsStateError,
      );
      final old = await invoice();
      await (db.update(db.invoices)..where((i) => i.id.equals(old.id))).write(
        InvoicesCompanion(
          createdAt: Value(DateTime.now().subtract(const Duration(hours: 49))),
        ),
      );
      expect(
        () => db.createCancellationTransaction(
          CreateCancellationRequest(
            invoiceId: old.id,
            managerId: 'manager',
            reason: 'Wrong Product',
            now: DateTime.now(),
          ),
        ),
        throwsStateError,
      );
    },
  );

  test(
    'X is repeatable/read-only and Z is sequential and once per date',
    () async {
      await invoice(gross: 115, method: 'cash');
      await invoice(gross: 230, method: 'telebirr');
      final first = await db.generateXReport(DateTime.now());
      final second = await db.generateXReport(DateTime.now());
      expect(first.invoiceCount, 2);
      expect(first.grossTotal, closeTo(345, .001));
      expect(first.cashTotal, 115);
      expect(first.telebirrTotal, 230);
      expect(second.grossTotal, first.grossTotal);
      expect(await db.select(db.dailyReports).get(), isEmpty);
      final z = await db.closeZReportTransaction(
        date: DateTime.now(),
        managerId: 'manager',
        cashCount: 110,
      );
      expect(z.zNumber, 1);
      expect(z.cashCount, 110);
      expect(
        () => db.closeZReportTransaction(
          date: DateTime.now(),
          managerId: 'manager',
          cashCount: 110,
        ),
        throwsStateError,
      );
    },
  );
}
