import '../entities/category_entity.dart';
import '../repositories/catalog_repository.dart';

/// Retrieves the full category catalog.
class GetCategories {
  final CatalogRepository _repository;

  const GetCategories(this._repository);

  Future<List<CategoryEntity>> call() => _repository.getCategories();
}
