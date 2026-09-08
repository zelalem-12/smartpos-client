import '../entities/category_entity.dart';
import '../entities/product_entity.dart';

/// Abstract repository for catalog (category/product) operations.
abstract class CatalogRepository {
  /// Get all categories.
  Future<List<CategoryEntity>> getCategories();

  /// Find a category by ID.
  Future<CategoryEntity?> getCategoryById(String id);

  /// Get all products.
  Future<List<ProductEntity>> getProducts();

  /// Get products filtered by category.
  Future<List<ProductEntity>> getProductsByCategory(String categoryId);

  /// Search products by name or barcode.
  Future<List<ProductEntity>> searchProducts(String query);

  /// Add a new product after validation.
  Future<ProductEntity> addProduct(ProductEntity product);

  /// Update an existing product after validation.
  Future<ProductEntity> updateProduct(ProductEntity product);

  /// Toggle the active flag of a product.
  Future<ProductEntity> toggleProductActive(String id);
}
