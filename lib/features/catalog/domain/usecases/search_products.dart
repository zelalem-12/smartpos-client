import '../entities/product_entity.dart';
import '../repositories/catalog_repository.dart';

/// Searches products by name or barcode.
class SearchProducts {
  final CatalogRepository _repository;

  const SearchProducts(this._repository);

  Future<List<ProductEntity>> call(String query) =>
      _repository.searchProducts(query);
}
