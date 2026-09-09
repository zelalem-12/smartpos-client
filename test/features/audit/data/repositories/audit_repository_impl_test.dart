import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:smartpos_client/core/database/app_database.dart';
import 'package:smartpos_client/core/database/create_invoice_request.dart';
import 'package:smartpos_client/core/utils/hash_chain.dart';
import 'package:smartpos_client/features/audit/data/repositories/audit_repository_impl.dart';
import 'package:smartpos_client/features/audit/domain/entities/audit_log_entry.dart';

void main() {
  late AppDatabase db;
  late AuditRepositoryImpl repository;

  setUp(() async {
    db = AppDatabase.forTesting();
    repository = AuditRepositoryImpl(db);

    await db.insertUser(
      UsersCompanion.insert(
        id: 'csh-001',
        username: 'cashier',
        fullName: 'Cashier',
        role: 'CASHIER',
        passwordHash: 'hash',
      ),
    );
  });

  tearDown(() => db.close());

  Future<Invoice> createInvoice(double gross) => db.createInvoiceTransaction(
    CreateInvoiceDbRequest(
      cashierId: 'csh-001',
      netTotal: gross / 1.15,
      vatTotal: gross - (gross / 1.15),
      grossTotal: gross,
      status: 'PENDING_SYNC',
      items: [
        CreateInvoiceItemDbRequest(
          productId: 'p1',
          productName: 'Item',
          unitPrice: gross,
          quantity: 1,
          vatRate: .15,
          netAmount: gross / 1.15,
          vatAmount: gross - (gross / 1.15),
          grossAmount: gross,
        ),
      ],
      paymentMethod: 'cash',
      paymentAmount: gross,
      payloadBuilder: (n) => AppDatabase.toDeterministicJson({'n': n}),
      syncOperation: 'CREATE_INVOICE',
      auditAction: 'INVOICE_CREATED',
      auditUserId: 'csh-001',
    ),
  );

  test('valid chain verifies every entry', () async {
    await createInvoice(115);
    await createInvoice(230);

    final result = await repository.verifyChain();
    expect(result.isChainValid, isTrue);
    expect(result.entries.length, 2);
    expect(result.entries.every((e) => e.isValid), isTrue);
  });

  test('tampered current hash marks entry tampered', () async {
    final first = await createInvoice(115);
    await createInvoice(230);

    await (db.update(db.auditLogs)..where((a) => a.id.equals(first.id))).write(
      const AuditLogsCompanion(currentHash: Value(' tampered ')),
    );

    final result = await repository.verifyChain();
    expect(result.isChainValid, isFalse);
    final broken = result.entries.firstWhere((e) => e.id == first.id);
    expect(broken.integrityStatus, AuditIntegrityStatus.tampered);
  });

  test('broken previous hash link marks second entry tampered', () async {
    await createInvoice(115);
    final second = await createInvoice(230);

    await (db.update(db.auditLogs)..where((a) => a.id.equals(second.id))).write(
      const AuditLogsCompanion(previousHash: Value('wrong')),
    );

    final result = await repository.verifyChain();
    expect(result.isChainValid, isFalse);
    final broken = result.entries.firstWhere((e) => e.id == second.id);
    expect(broken.integrityStatus, AuditIntegrityStatus.tampered);
  });

  test('legacy row without payload is unverifiable, not tampered', () async {
    final invoice = await createInvoice(115);
    final audit = (await db.getAuditLogsByInvoiceId(invoice.id)).single;

    await (db.update(db.auditLogs)..where((a) => a.id.equals(audit.id))).write(
      const AuditLogsCompanion(payload: Value(null)),
    );

    final result = await repository.verifyChain();
    expect(result.isChainValid, isFalse);
    final entry = result.entries.single;
    expect(entry.integrityStatus, AuditIntegrityStatus.unverifiable);
  });

  test('audit trail returns entries newest first', () async {
    await createInvoice(115);
    await createInvoice(230);

    final entries = await repository.getAuditTrail();
    expect(entries.first.id, greaterThan(entries.last.id));
  });

  test('hash is verified against stored payload independently', () async {
    final invoice = await createInvoice(115);
    final audit = (await db.getAuditLogsByInvoiceId(invoice.id)).single;

    expect(
      HashChain.verifyHash(
        audit.currentHash,
        audit.previousHash,
        audit.payload!,
      ),
      isTrue,
    );
  });
}
