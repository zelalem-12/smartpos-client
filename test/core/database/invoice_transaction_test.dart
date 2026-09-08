import 'package:flutter_test/flutter_test.dart';
import 'package:smartpos_client/core/database/app_database.dart';
import 'package:smartpos_client/core/database/create_invoice_request.dart';
import 'package:smartpos_client/core/utils/hash_chain.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting();
  });

  tearDown(() async {
    await db.close();
  });

  Future<void> seedCashier() async {
    await db.insertUser(
      UsersCompanion.insert(
        id: 'csh-001',
        username: 'selam_t',
        fullName: 'Selam Teshale',
        role: 'CASHIER',
        passwordHash: 'hash',
      ),
    );
  }

  CreateInvoiceDbRequest cashRequest({
    double gross = 115.0,
    String cashierId = 'csh-001',
  }) {
    final net = gross / 1.15;
    final vat = gross - net;
    return CreateInvoiceDbRequest(
      cashierId: cashierId,
      netTotal: net,
      vatTotal: vat,
      grossTotal: gross,
      status: 'PENDING_SYNC',
      items: [
        CreateInvoiceItemDbRequest(
          productId: 'p1',
          productName: 'Coffee',
          unitPrice: 115.0,
          quantity: 1,
          vatRate: 0.15,
          netAmount: net,
          vatAmount: vat,
          grossAmount: gross,
        ),
      ],
      paymentMethod: 'cash',
      paymentAmount: gross,
      cashTendered: 200.0,
      payloadBuilder: (invoiceNumber) {
        return AppDatabase.toDeterministicJson({
          'invoiceNumber': invoiceNumber,
          'cashierId': cashierId,
          'total': gross,
        });
      },
      syncOperation: 'CREATE_INVOICE',
      auditAction: 'INVOICE_CREATED',
      auditUserId: cashierId,
    );
  }

  group('createInvoiceTransaction', () {
    test(
      'creates invoice, items, payment, sync and audit rows atomically',
      () async {
        await seedCashier();
        final request = cashRequest();

        final invoice = await db.createInvoiceTransaction(request);

        expect(invoice.invoiceNumber, 1);
        expect(invoice.status, 'PENDING_SYNC');

        final items = await db.getInvoiceItemsByInvoiceId(invoice.id);
        expect(items.length, 1);
        expect(items.first.productName, 'Coffee');
        expect(items.first.grossAmount, 115.0);

        final payment = await db.getPaymentByInvoiceId(invoice.id);
        expect(payment, isNotNull);
        expect(payment!.method, 'cash');
        expect(payment.amount, 115.0);
        expect(payment.cashTendered, 200.0);

        final syncEntry = await db.getSyncQueueEntryByInvoiceId(invoice.id);
        expect(syncEntry, isNotNull);
        expect(syncEntry!.status, 'PENDING');
        expect(syncEntry.operation, 'CREATE_INVOICE');

        final auditLogs = await db.getAuditLogsByInvoiceId(invoice.id);
        expect(auditLogs.length, 1);
        expect(auditLogs.first.action, 'INVOICE_CREATED');
        expect(auditLogs.first.currentHash, invoice.currentHash);
        expect(auditLogs.first.previousHash, invoice.previousHash);
      },
    );

    test('sequence increments for consecutive invoices', () async {
      await seedCashier();

      final first = await db.createInvoiceTransaction(
        cashRequest(gross: 115.0),
      );
      final second = await db.createInvoiceTransaction(
        cashRequest(gross: 230.0),
      );

      expect(first.invoiceNumber, 1);
      expect(second.invoiceNumber, 2);
    });

    test('hash chain links current invoice to previous audit hash', () async {
      await seedCashier();

      final first = await db.createInvoiceTransaction(
        cashRequest(gross: 100.0),
      );
      final second = await db.createInvoiceTransaction(
        cashRequest(gross: 200.0),
      );

      expect(first.previousHash, '');
      expect(second.previousHash, first.currentHash);
      expect(
        HashChain.verifyHash(
          second.currentHash,
          second.previousHash,
          second.payload,
        ),
        isTrue,
      );
    });

    test('rolls back all rows when the transaction fails', () async {
      await seedCashier();
      final request = cashRequest(cashierId: 'non-existent-cashier');

      await expectLater(
        () => db.createInvoiceTransaction(request),
        throwsA(isA<Exception>()),
      );

      final allInvoices = await db.select(db.invoices).get();
      final allItems = await db.select(db.invoiceItems).get();
      final allPayments = await db.select(db.payments).get();
      final allSync = await db.select(db.syncQueue).get();
      final allAudit = await db.select(db.auditLogs).get();

      expect(allInvoices, isEmpty);
      expect(allItems, isEmpty);
      expect(allPayments, isEmpty);
      expect(allSync, isEmpty);
      expect(allAudit, isEmpty);
    });
  });
}
