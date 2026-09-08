import 'package:uuid/uuid.dart';

import '../../../../core/error/failures.dart';
import '../entities/product_entity.dart';
import '../repositories/catalog_repository.dart';

/// Adds a new product to the catalog.
///
/// Enforces product validation and duplicate barcode checks.
class AddProduct {
  final CatalogRepository _repository;

  const AddProduct(this._repository);

  Future<ProductEntity> call({
    required String categoryId,
    required String name,
    String? description,
    required String barcode,
    required double price,
    double? cost,
    double stockQuantity = 0.0,
    required String unit,
    double vatRate = 0.15,
  }) async {
    final trimmedName = name.trim();
    final trimmedBarcode = barcode.trim();
    final trimmedUnit = unit.trim();

    if (trimmedName.isEmpty) {
      throw const ValidationFailure('Product name is required');
    }

    if (trimmedBarcode.isEmpty) {
      throw const ValidationFailure('Barcode is required');
    }

    if (trimmedUnit.isEmpty) {
      throw const ValidationFailure('Unit of measure is required');
    }

    if (price <= 0) {
      throw const ValidationFailure('Price must be greater than zero');
    }

    if (cost != null && cost < 0) {
      throw const ValidationFailure('Cost cannot be negative');
    }

    if (stockQuantity < 0) {
      throw const ValidationFailure('Stock quantity cannot be negative');
    }

    if (vatRate < 0) {
      throw const ValidationFailure('VAT rate cannot be negative');
    }

    final category = await _repository.getCategoryById(categoryId);
    if (category == null) {
      throw const NotFoundFailure('Category not found');
    }

    final existingByBarcode = await _repository.searchProducts(trimmedBarcode);
    if (existingByBarcode.isNotEmpty) {
      throw ConflictFailure(
        'A product with barcode "$trimmedBarcode" already exists',
      );
    }

    final product = ProductEntity(
      id: const Uuid().v4(),
      categoryId: categoryId,
      name: trimmedName,
      description: description?.trim(),
      barcode: trimmedBarcode,
      price: price,
      cost: cost,
      stockQuantity: stockQuantity,
      unit: trimmedUnit,
      vatRate: vatRate,
      isActive: true,
      createdAt: DateTime.now(),
    );

    return _repository.addProduct(product);
  }
}
