import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/invoices_table.dart';
import '../tables/invoice_items_table.dart';
import '../tables/payments_table.dart';

part 'invoices_dao.g.dart';

/// Data access for invoices, invoice items, and payments.
///
/// Read-only queries only. The atomic creation of an invoice with its
/// items, payment, sync queue entry, and audit log lives in
/// [TransactionDao] because it needs cross-table access.
@DriftAccessor(tables: [Invoices, InvoiceItems, Payments])
class InvoicesDao extends DatabaseAccessor<AppDatabase>
    with _$InvoicesDaoMixin {
  InvoicesDao(super.db);

  Future<Invoice?> getInvoiceById(int invoiceId) {
    return (select(
      invoices,
    )..where((i) => i.id.equals(invoiceId))).getSingleOrNull();
  }

  Future<Invoice?> getInvoiceByNumber(int number) {
    return (select(
      invoices,
    )..where((i) => i.invoiceNumber.equals(number))).getSingleOrNull();
  }

  Future<List<InvoiceItem>> getInvoiceItemsByInvoiceId(int invoiceId) {
    return (select(invoiceItems)
          ..where((i) => i.invoiceId.equals(invoiceId))
          ..orderBy([(i) => OrderingTerm(expression: i.id)]))
        .get();
  }

  Future<Payment?> getPaymentByInvoiceId(int invoiceId) {
    return (select(payments)
          ..where((p) => p.invoiceId.equals(invoiceId))
          ..limit(1))
        .getSingleOrNull();
  }
}
