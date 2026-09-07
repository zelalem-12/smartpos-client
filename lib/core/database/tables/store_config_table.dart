import 'package:drift/drift.dart';

/// Stores the merchant's tax identity and device binding.
///
/// Populated once during license activation (Phase 2) and locked
/// against cashier modification per MOR Directive Art. 4.3(a).
class StoreConfigs extends Table {
  /// Primary key — only one row expected per device.
  IntColumn get id => integer().autoIncrement()();

  /// License/activation key used to provision this device.
  TextColumn get licenseKey => text().withLength(min: 1, max: 20)();

  /// Legal business name registered with Ministry.
  TextColumn get businessName => text().withLength(min: 1, max: 200)();

  /// Trade name printed on receipts.
  TextColumn get tradeName => text().withLength(min: 1, max: 200)();

  /// Taxpayer Identification Number (10 digits).
  TextColumn get tin => text().withLength(min: 10, max: 10)();

  /// VAT Registration Number.
  TextColumn get vatRegNo => text().withLength(min: 1, max: 20)();

  /// Designated business sector from Annex 2.
  TextColumn get sector => text()();

  /// Physical store address.
  TextColumn get address => text()();

  /// Bound device serial number (hardware fingerprint).
  TextColumn get deviceSerial => text()();

  /// When this configuration was created.
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
