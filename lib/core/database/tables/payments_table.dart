import 'package:drift/drift.dart';

import 'invoices_table.dart';

/// Payment record linked to an invoice.
class Payments extends Table {
  /// Auto-generated local primary key.
  IntColumn get id => integer().autoIncrement()();

  /// Parent invoice.
  IntColumn get invoiceId => integer().references(Invoices, #id)();

  /// Payment method: cash, telebirr, cbeBirr.
  TextColumn get method => text().withLength(min: 1, max: 20)();

  /// Paid amount (must equal invoice gross total at creation).
  RealColumn get amount => real()();

  /// Cash tendered by the buyer. Null for electronic methods.
  RealColumn get cashTendered => real().nullable()();

  /// Optional provider reference / transaction code for electronic payments.
  TextColumn get referenceCode => text().nullable()();

  /// When the payment was recorded.
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
