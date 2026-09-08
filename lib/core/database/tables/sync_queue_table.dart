import 'package:drift/drift.dart';

import 'invoices_table.dart';

/// Pending synchronisation jobs for the backend.
class SyncQueue extends Table {
  /// Auto-generated local primary key.
  IntColumn get id => integer().autoIncrement()();

  /// Linked invoice.
  IntColumn get invoiceId => integer().references(Invoices, #id)();

  /// Operation type, e.g. CREATE_INVOICE.
  TextColumn get operation => text().withLength(min: 1, max: 20)();

  /// Job status: PENDING, PROCESSING, FAILED, COMPLETED.
  TextColumn get status => text()
      .withLength(min: 1, max: 20)
      .withDefault(const Constant('PENDING'))();

  /// JSON payload sent to the backend.
  TextColumn get payload => text()();

  /// Retry counter for failed jobs.
  IntColumn get retryCount => integer().withDefault(const Constant(0))();

  /// When the job was created.
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
