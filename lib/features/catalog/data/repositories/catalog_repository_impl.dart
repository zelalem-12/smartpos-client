import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/catalog_repository.dart';
import '../datasources/catalog_local_source.dart';

/// Concrete implementation of [CatalogRepository] backed by the local DB.
class CatalogRepositoryImpl implements CatalogRepository {
  final CatalogLocalSource _localSource;

  const CatalogRepositoryImpl(this._localSource);

  static CategoryEntity _mapCategory(Category c) => CategoryEntity(
    id: c.id,
    name: c.name,
    description: c.description,
    isActive: c.isActive,
    createdAt: c.createdAt,
    updatedAt: c.updatedAt,
  );

  static ProductEntity _mapProduct(Product p) => ProductEntity(
    id: p.id,
    categoryId: p.categoryId,
    name: p.name,
    description: p.description,
    barcode: p.barcode,
    price: p.price,
    cost: p.cost,
    stockQuantity: p.stockQuantity,
    unit: p.unit,
    vatRate: p.vatRate,
    isActive: p.isActive,
    createdAt: p.createdAt,
    updatedAt: p.updatedAt,
  );

  @override
  Future<List<CategoryEntity>> getCategories() async {
    await _localSource.seedCatalogIfEmpty();
    final rows = await _localSource.getAllCategories();
    return rows.map(_mapCategory).toList();
  }

  @override
  Future<CategoryEntity?> getCategoryById(String id) async {
    final row = await _localSource.getCategoryById(id);
    return row == null ? null : _mapCategory(row);
  }

  @override
  Future<List<ProductEntity>> getProducts() async {
    await _localSource.seedCatalogIfEmpty();
    final rows = await _localSource.getAllProducts();
    return rows.map(_mapProduct).toList();
  }

  @override
  Future<List<ProductEntity>> getProductsByCategory(String categoryId) async {
    await _localSource.seedCatalogIfEmpty();
    final rows = await _localSource.getProductsByCategory(categoryId);
    return rows.map(_mapProduct).toList();
  }

  @override
  Future<List<ProductEntity>> searchProducts(String query) async {
    if (query.trim().isEmpty) {
      return getProducts();
    }
    await _localSource.seedCatalogIfEmpty();
    final rows = await _localSource.searchProducts(query.trim());
    return rows.map(_mapProduct).toList();
  }

  @override
  Future<ProductEntity> addProduct(ProductEntity product) async {
    await _localSource.insertProduct(_toCompanion(product));
    final inserted = await _localSource.getProductById(product.id);
    return _mapProduct(inserted!);
  }

  @override
  Future<ProductEntity> updateProduct(ProductEntity product) async {
    await _localSource.updateProduct(_toCompanion(product));
    final updated = await _localSource.getProductById(product.id);
    return _mapProduct(updated!);
  }

  @override
  Future<ProductEntity> toggleProductActive(String id) async {
    final existing = await _localSource.getProductById(id);
    if (existing == null) {
      throw Exception('Product not found');
    }
    final updated = existing.copyWith(
      isActive: !existing.isActive,
      updatedAt: Value(DateTime.now()),
    );
    await _localSource.updateProduct(_dataClassToCompanion(updated));
    return _mapProduct(updated);
  }

  static ProductsCompanion _toCompanion(ProductEntity p) {
    return ProductsCompanion(
      id: Value(p.id),
      categoryId: Value(p.categoryId),
      name: Value(p.name),
      description: p.description == null
          ? const Value.absent()
          : Value(p.description!),
      barcode: Value(p.barcode),
      price: Value(p.price),
      cost: p.cost == null ? const Value.absent() : Value(p.cost!),
      stockQuantity: Value(p.stockQuantity),
      unit: Value(p.unit),
      vatRate: Value(p.vatRate),
      isActive: Value(p.isActive),
      createdAt: Value(p.createdAt),
      updatedAt: const Value.absent(),
    );
  }

  static ProductsCompanion _dataClassToCompanion(Product p) {
    return ProductsCompanion(
      id: Value(p.id),
      categoryId: Value(p.categoryId),
      name: Value(p.name),
      description: p.description == null
          ? const Value.absent()
          : Value(p.description!),
      barcode: Value(p.barcode),
      price: Value(p.price),
      cost: p.cost == null ? const Value.absent() : Value(p.cost!),
      stockQuantity: Value(p.stockQuantity),
      unit: Value(p.unit),
      vatRate: Value(p.vatRate),
      isActive: Value(p.isActive),
      createdAt: Value(p.createdAt),
      updatedAt: Value(DateTime.now()),
    );
  }
}
