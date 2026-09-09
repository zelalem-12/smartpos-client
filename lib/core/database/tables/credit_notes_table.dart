import 'package:drift/drift.dart';

import 'invoice_items_table.dart';
import 'invoices_table.dart';
import 'users_table.dart';

class CreditNotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get creditNoteNumber => integer().unique()();
  IntColumn get invoiceId => integer().references(Invoices, #id)();
  TextColumn get managerId => text().references(Users, #id)();
  TextColumn get reason => text()();
  TextColumn get status => text().withDefault(const Constant('PENDING_SYNC'))();
  RealColumn get netTotal => real()();
  RealColumn get vatTotal => real()();
  RealColumn get grossTotal => real()();
  TextColumn get payload => text()();
  TextColumn get previousHash => text()();
  TextColumn get currentHash => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}

class CreditNoteItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get creditNoteId => integer().references(CreditNotes, #id)();
  IntColumn get invoiceItemId => integer().references(InvoiceItems, #id)();
  RealColumn get quantity => real()();
  RealColumn get netAmount => real()();
  RealColumn get vatAmount => real()();
  RealColumn get grossAmount => real()();
}
