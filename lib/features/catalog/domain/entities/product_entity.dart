import 'package:equatable/equatable.dart';

/// Domain entity representing a sellable product.
class ProductEntity extends Equatable {
  final String id;
  final String categoryId;
  final String name;
  final String? description;
  final String barcode;
  final double price;
  final double? cost;
  final double stockQuantity;
  final String unit;
  final double vatRate;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const ProductEntity({
    required this.id,
    required this.categoryId,
    required this.name,
    this.description,
    required this.barcode,
    required this.price,
    this.cost,
    this.stockQuantity = 0.0,
    required this.unit,
    this.vatRate = 0.0,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
  });

  /// Convenience accessor for the display price formatted in ETB.
  String get priceLabel => price.toStringAsFixed(2);

  /// Returns a copy with updated fields.
  ProductEntity copyWith({
    String? id,
    String? categoryId,
    String? name,
    String? description,
    String? barcode,
    double? price,
    double? cost,
    double? stockQuantity,
    String? unit,
    double? vatRate,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      description: description ?? this.description,
      barcode: barcode ?? this.barcode,
      price: price ?? this.price,
      cost: cost ?? this.cost,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      unit: unit ?? this.unit,
      vatRate: vatRate ?? this.vatRate,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    categoryId,
    name,
    description,
    barcode,
    price,
    cost,
    stockQuantity,
    unit,
    vatRate,
    isActive,
    createdAt,
    updatedAt,
  ];
}
