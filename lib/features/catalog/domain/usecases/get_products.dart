import '../entities/product_entity.dart';
import '../repositories/catalog_repository.dart';

/// Retrieves products, optionally filtered by category.
class GetProducts {
  final CatalogRepository _repository;

  const GetProducts(this._repository);

  Future<List<ProductEntity>> call({String? categoryId}) {
    if (categoryId == null || categoryId.isEmpty) {
      return _repository.getProducts();
    }
    return _repository.getProductsByCategory(categoryId);
  }
}
