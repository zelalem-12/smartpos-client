// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_dao.dart';

// ignore_for_file: type=lint
mixin _$TransactionDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
  $InvoicesTable get invoices => attachedDatabase.invoices;
  $InvoiceItemsTable get invoiceItems => attachedDatabase.invoiceItems;
  $PaymentsTable get payments => attachedDatabase.payments;
  $SyncQueueTable get syncQueue => attachedDatabase.syncQueue;
  $AuditLogsTable get auditLogs => attachedDatabase.auditLogs;
  $CreditNotesTable get creditNotes => attachedDatabase.creditNotes;
  $CreditNoteItemsTable get creditNoteItems => attachedDatabase.creditNoteItems;
  $CancellationRequestsTable get cancellationRequests =>
      attachedDatabase.cancellationRequests;
  $DailyReportsTable get dailyReports => attachedDatabase.dailyReports;
  TransactionDaoManager get managers => TransactionDaoManager(this);
}

class TransactionDaoManager {
  final _$TransactionDaoMixin _db;
  TransactionDaoManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db.attachedDatabase, _db.users);
  $$InvoicesTableTableManager get invoices =>
      $$InvoicesTableTableManager(_db.attachedDatabase, _db.invoices);
  $$InvoiceItemsTableTableManager get invoiceItems =>
      $$InvoiceItemsTableTableManager(_db.attachedDatabase, _db.invoiceItems);
  $$PaymentsTableTableManager get payments =>
      $$PaymentsTableTableManager(_db.attachedDatabase, _db.payments);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db.attachedDatabase, _db.syncQueue);
  $$AuditLogsTableTableManager get auditLogs =>
      $$AuditLogsTableTableManager(_db.attachedDatabase, _db.auditLogs);
  $$CreditNotesTableTableManager get creditNotes =>
      $$CreditNotesTableTableManager(_db.attachedDatabase, _db.creditNotes);
  $$CreditNoteItemsTableTableManager get creditNoteItems =>
      $$CreditNoteItemsTableTableManager(
        _db.attachedDatabase,
        _db.creditNoteItems,
      );
  $$CancellationRequestsTableTableManager get cancellationRequests =>
      $$CancellationRequestsTableTableManager(
        _db.attachedDatabase,
        _db.cancellationRequests,
      );
  $$DailyReportsTableTableManager get dailyReports =>
      $$DailyReportsTableTableManager(_db.attachedDatabase, _db.dailyReports);
}
