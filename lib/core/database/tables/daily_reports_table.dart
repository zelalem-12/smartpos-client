import 'package:drift/drift.dart';

import 'users_table.dart';

class DailyReports extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get zNumber => integer().unique()();
  TextColumn get reportDate => text().unique()();
  TextColumn get managerId => text().references(Users, #id)();
  IntColumn get invoiceCount => integer()();
  RealColumn get netTotal => real()();
  RealColumn get vatTotal => real()();
  RealColumn get grossTotal => real()();
  RealColumn get creditNetTotal => real()();
  RealColumn get creditVatTotal => real()();
  RealColumn get creditGrossTotal => real()();
  RealColumn get cashTotal => real()();
  RealColumn get telebirrTotal => real()();
  RealColumn get cbeBirrTotal => real()();
  RealColumn get cashCount => real()();
  TextColumn get status => text().withDefault(const Constant('PENDING_SYNC'))();
  TextColumn get payload => text()();
  TextColumn get previousHash => text()();
  TextColumn get currentHash => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
