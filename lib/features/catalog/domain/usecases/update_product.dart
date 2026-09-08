import '../../../../core/error/failures.dart';
import '../entities/product_entity.dart';
import '../repositories/catalog_repository.dart';

/// Updates an existing product in the catalog.
///
/// Enforces product validation and duplicate barcode checks
/// (excluding the product being edited).
class UpdateProduct {
  final CatalogRepository _repository;

  const UpdateProduct(this._repository);

  Future<ProductEntity> call(ProductEntity product) async {
    final trimmedName = product.name.trim();
    final trimmedBarcode = product.barcode.trim();
    final trimmedUnit = product.unit.trim();

    if (trimmedName.isEmpty) {
      throw const ValidationFailure('Product name is required');
    }

    if (trimmedBarcode.isEmpty) {
      throw const ValidationFailure('Barcode is required');
    }

    if (trimmedUnit.isEmpty) {
      throw const ValidationFailure('Unit of measure is required');
    }

    if (product.price <= 0) {
      throw const ValidationFailure('Price must be greater than zero');
    }

    if (product.cost != null && product.cost! < 0) {
      throw const ValidationFailure('Cost cannot be negative');
    }

    if (product.stockQuantity < 0) {
      throw const ValidationFailure('Stock quantity cannot be negative');
    }

    if (product.vatRate < 0) {
      throw const ValidationFailure('VAT rate cannot be negative');
    }

    final category = await _repository.getCategoryById(product.categoryId);
    if (category == null) {
      throw const NotFoundFailure('Category not found');
    }

    final existingByBarcode = await _repository.searchProducts(trimmedBarcode);
    final duplicate = existingByBarcode
        .where((p) => p.id != product.id && p.barcode == trimmedBarcode)
        .isNotEmpty;
    if (duplicate) {
      throw ConflictFailure(
        'Another product with barcode "$trimmedBarcode" already exists',
      );
    }

    final updated = product.copyWith(
      name: trimmedName,
      barcode: trimmedBarcode,
      unit: trimmedUnit,
      description: product.description?.trim(),
      updatedAt: DateTime.now(),
    );

    return _repository.updateProduct(updated);
  }
}
