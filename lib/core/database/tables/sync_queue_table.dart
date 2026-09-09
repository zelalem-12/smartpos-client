import 'package:drift/drift.dart';

import 'invoices_table.dart';

/// Pending synchronisation jobs for the backend.
///
/// Status lifecycle: PENDING -> PROCESSING -> SYNCED | FAILED.
/// Failed jobs can be retried and transition back to PENDING/PROCESSING.
class SyncQueue extends Table {
  /// Auto-generated local primary key.
  IntColumn get id => integer().autoIncrement()();

  /// Linked invoice (anchor for invoice-related sync operations).
  IntColumn get invoiceId => integer().references(Invoices, #id)();

  /// Operation type, e.g. CREATE_INVOICE, CREATE_CREDIT_NOTE,
  /// CANCEL_INVOICE, CLOSE_Z_REPORT.
  TextColumn get operation => text().withLength(min: 1, max: 40)();

  /// Job status: PENDING, PROCESSING, FAILED, SYNCED.
  TextColumn get status => text()
      .withLength(min: 1, max: 20)
      .withDefault(const Constant('PENDING'))();

  /// JSON payload sent to the backend.
  TextColumn get payload => text()();

  /// Retry counter for failed jobs.
  IntColumn get retryCount => integer().withDefault(const Constant(0))();

  /// Last error message for failed jobs.
  TextColumn get lastError => text().nullable()();

  /// When the job was created.
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// When the job row was last updated.
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  /// When the job last transitioned to PROCESSING.
  DateTimeColumn get lastAttemptAt => dateTime().nullable()();

  /// When the job was successfully synced.
  DateTimeColumn get syncedAt => dateTime().nullable()();
}
