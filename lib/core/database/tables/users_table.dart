import 'package:drift/drift.dart';

/// User accounts: managers and cashiers on this POS device.
///
/// Users log in with a username and password. Their full name is used
/// on receipts and e-invoices. Managers have elevated permissions
/// (refunds, cancellations, Z-reports, staff management) and can
/// create cashier accounts.
class Users extends Table {
  /// UUID primary key.
  TextColumn get id => text()();

  /// Unique login username.
  TextColumn get username => text().withLength(min: 3, max: 50)();

  /// Display name for receipts and e-invoices (e.g. "Abebe Bikila").
  TextColumn get fullName => text().withLength(min: 1, max: 100)();

  /// Role: 'MANAGER' or 'CASHIER'.
  TextColumn get role => text().withLength(min: 1, max: 20)();

  /// SHA-256 hashed password.
  TextColumn get passwordHash => text()();

  /// Whether this user account is active.
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  /// When this user was created.
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// When this user was last updated (e.g. password change, deactivation).
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE (username)'];
}
