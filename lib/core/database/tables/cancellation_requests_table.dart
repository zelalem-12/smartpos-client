import 'package:drift/drift.dart';

import 'invoices_table.dart';
import 'users_table.dart';

class CancellationRequests extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get invoiceId => integer().unique().references(Invoices, #id)();
  TextColumn get managerId => text().references(Users, #id)();
  TextColumn get reason => text()();
  TextColumn get status => text().withDefault(const Constant('PENDING'))();
  TextColumn get payload => text()();
  TextColumn get previousHash => text()();
  TextColumn get currentHash => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}
