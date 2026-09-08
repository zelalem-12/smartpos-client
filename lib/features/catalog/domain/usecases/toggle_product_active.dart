import '../entities/product_entity.dart';
import '../repositories/catalog_repository.dart';

/// Toggles the active status of a product.
class ToggleProductActive {
  final CatalogRepository _repository;

  const ToggleProductActive(this._repository);

  Future<ProductEntity> call(String productId) =>
      _repository.toggleProductActive(productId);
}
