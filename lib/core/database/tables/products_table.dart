import 'package:drift/drift.dart';

/// Sellable products or services in the catalog.
///
/// Products belong to a category, carry pricing and stock metadata,
/// and can be toggled active/inactive for sale.
class Products extends Table {
  /// UUID primary key.
  TextColumn get id => text()();

  /// Foreign key to [Categories].
  TextColumn get categoryId => text()();

  /// Display name (e.g. "Ethiopian Coffee").
  TextColumn get name => text().withLength(min: 1, max: 200)();

  /// Optional description.
  TextColumn get description => text().nullable()();

  /// Unique barcode / SKU used at checkout.
  TextColumn get barcode => text().withLength(min: 1, max: 50)();

  /// Selling price per unit.
  RealColumn get price => real()();

  /// Optional cost price for margin reporting.
  RealColumn get cost => real().nullable()();

  /// Current stock quantity (supports fractional units such as kg).
  RealColumn get stockQuantity => real().withDefault(const Constant(0.0))();

  /// Unit of measure (e.g. "pc", "kg", "bottle").
  TextColumn get unit => text().withLength(min: 1, max: 20)();

  /// VAT rate applied to this product (0.0 if exempt).
  RealColumn get vatRate => real().withDefault(const Constant(0.15))();

  /// Whether the product is currently available for sale.
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  /// Creation timestamp.
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Last update timestamp.
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE (barcode)'];
}
