import 'package:drift/drift.dart';

/// User accounts: managers and cashiers on this POS device.
///
/// Multiple cashiers can share one device. Each user has a 4-digit
/// PIN for quick authentication. Managers have elevated permissions
/// (refunds, cancellations, Z-reports, staff management).
class Users extends Table {
  /// UUID primary key.
  TextColumn get id => text()();

  /// Display name (e.g. "Abebe Bikila").
  TextColumn get name => text().withLength(min: 1, max: 100)();

  /// Role: 'MANAGER' or 'CASHIER'.
  TextColumn get role => text().withLength(min: 1, max: 20)();

  /// Hashed 4-digit PIN (SHA-256).
  TextColumn get pinHash => text()();

  /// Whether this user account is active.
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  /// When this user was created.
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// When this user was last updated (e.g. PIN change, deactivation).
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
