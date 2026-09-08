import 'package:drift/drift.dart';

/// Product categories for the POS catalog.
///
/// Categories group items (e.g. Beverages, Pharmacy) and can be
/// activated or deactivated without deleting historical data.
class Categories extends Table {
  /// UUID primary key.
  TextColumn get id => text()();

  /// Display name (e.g. "Beverages").
  TextColumn get name => text().withLength(min: 1, max: 100)();

  /// Optional longer description for the category.
  TextColumn get description => text().nullable()();

  /// Whether the category is currently offered.
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  /// Creation timestamp.
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Last update timestamp.
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
