import 'package:drift/drift.dart';

import 'invoices_table.dart';

/// Tamper-evident audit trail for fiscal operations.
///
/// Each entry stores the hash chain of the previous and current hashes,
/// making offline tampering detectable. The [payload] field holds the
/// deterministic JSON that was hashed so the entry can be verified
/// independently of the invoice/credit-note table that produced it.
class AuditLogs extends Table {
  /// Auto-generated local primary key.
  IntColumn get id => integer().autoIncrement()();

  /// Action type, e.g. INVOICE_CREATED.
  TextColumn get action => text().withLength(min: 1, max: 50)();

  /// Related invoice (nullable for non-invoice actions).
  IntColumn get invoiceId => integer().nullable().references(Invoices, #id)();

  /// User who performed the action.
  TextColumn get userId => text()();

  /// Human-readable details.
  TextColumn get details => text()();

  /// Deterministic JSON payload that was used to compute [currentHash].
  /// Nullable to allow safe migration of pre-payload records; legacy rows
  /// with a missing payload are treated as unverifiable rather than valid.
  TextColumn get payload => text().nullable()();

  /// Hash of the previous audit entry (empty for the first entry).
  TextColumn get previousHash => text()();

  /// Hash of this entry (equals the invoice currentHash for invoice creation).
  TextColumn get currentHash => text()();

  /// When the action happened.
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
