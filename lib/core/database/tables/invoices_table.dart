import 'package:drift/drift.dart';

import 'users_table.dart';

/// Header of a fiscal sale / invoice.
///
/// The invoice is created locally with status [InvoiceStatus.pendingSync]
/// and eventually synchronized to the revenue authority backend.
/// Device-local invoice numbers are sequential and unique.
class Invoices extends Table {
  /// Auto-generated primary key used for local references.
  IntColumn get id => integer().autoIncrement()();

  /// Device-local sequential invoice number (1, 2, 3…).
  IntColumn get invoiceNumber => integer().unique()();

  /// Cashier / operator who performed the sale.
  TextColumn get cashierId => text().references(Users, #id)();

  /// Optional buyer TIN (10 digits).
  TextColumn get buyerTin => text().withLength(min: 10, max: 10).nullable()();

  /// Tax-exclusive total.
  RealColumn get netTotal => real()();

  /// Total VAT amount.
  RealColumn get vatTotal => real()();

  /// Tax-inclusive grand total.
  RealColumn get grossTotal => real()();

  /// Lifecycle status: PENDING_SYNC, SYNCED, CANCELLED.
  TextColumn get status => text()
      .withLength(min: 1, max: 20)
      .withDefault(const Constant('PENDING_SYNC'))();

  /// Deterministic JSON payload used for hash chain verification.
  TextColumn get payload => text()();

  /// Hash of the previous audit entry (empty for the first invoice).
  TextColumn get previousHash => text()();

  /// Hash of this invoice’s payload chained to the previous hash.
  TextColumn get currentHash => text()();

  /// When the invoice was created.
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// When the invoice was last updated.
  DateTimeColumn get updatedAt => dateTime().nullable()();
}
