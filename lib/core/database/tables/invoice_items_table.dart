import 'package:drift/drift.dart';

import 'invoices_table.dart';

/// Line items belonging to an invoice.
class InvoiceItems extends Table {
  /// Auto-generated local primary key.
  IntColumn get id => integer().autoIncrement()();

  /// Parent invoice.
  IntColumn get invoiceId => integer().references(Invoices, #id)();

  /// Product identifier (catalog reference is informational here; catalog
  /// rows can be deactivated or removed without breaking historical data).
  TextColumn get productId => text()();

  /// Display name of the product at the time of sale.
  TextColumn get productName => text().withLength(min: 1, max: 200)();

  /// Tax-inclusive unit price.
  RealColumn get unitPrice => real()();

  /// Quantity sold (integer units for this app).
  IntColumn get quantity => integer().withDefault(const Constant(1))();

  /// VAT rate applied to this line (e.g. 0.15).
  RealColumn get vatRate => real().withDefault(const Constant(0.15))();

  /// Tax-exclusive line total.
  RealColumn get netAmount => real()();

  /// VAT amount for this line.
  RealColumn get vatAmount => real()();

  /// Tax-inclusive line total.
  RealColumn get grossAmount => real()();
}
