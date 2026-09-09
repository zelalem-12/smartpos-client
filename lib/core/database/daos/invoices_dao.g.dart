// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoices_dao.dart';

// ignore_for_file: type=lint
mixin _$InvoicesDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
  $InvoicesTable get invoices => attachedDatabase.invoices;
  $InvoiceItemsTable get invoiceItems => attachedDatabase.invoiceItems;
  $PaymentsTable get payments => attachedDatabase.payments;
  InvoicesDaoManager get managers => InvoicesDaoManager(this);
}

class InvoicesDaoManager {
  final _$InvoicesDaoMixin _db;
  InvoicesDaoManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db.attachedDatabase, _db.users);
  $$InvoicesTableTableManager get invoices =>
      $$InvoicesTableTableManager(_db.attachedDatabase, _db.invoices);
  $$InvoiceItemsTableTableManager get invoiceItems =>
      $$InvoiceItemsTableTableManager(_db.attachedDatabase, _db.invoiceItems);
  $$PaymentsTableTableManager get payments =>
      $$PaymentsTableTableManager(_db.attachedDatabase, _db.payments);
}
