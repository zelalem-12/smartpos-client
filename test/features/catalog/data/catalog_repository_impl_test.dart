import 'package:flutter_test/flutter_test.dart';
import 'package:smartpos_client/core/database/app_database.dart';
import 'package:smartpos_client/features/catalog/data/datasources/catalog_local_source.dart';
import 'package:smartpos_client/features/catalog/data/repositories/catalog_repository_impl.dart';
import 'package:smartpos_client/features/catalog/domain/entities/product_entity.dart';

void main() {
  late AppDatabase db;
  late CatalogRepositoryImpl repository;

  setUp(() {
    db = AppDatabase.forTesting();
    repository = CatalogRepositoryImpl(CatalogLocalSource(db));
  });

  tearDown(() async {
    await db.close();
  });

  group('CatalogRepositoryImpl', () {
    test('getCategories seeds default categories on empty database', () async {
      final categories = await repository.getCategories();

      expect(categories.length, 5);
      expect(categories.map((c) => c.id).toSet(), {
        'cat-beverages',
        'cat-pastries',
        'cat-pharma-otc',
        'cat-pharma-care',
        'cat-groceries',
      });
    });

    test('getProducts seeds default products on empty database', () async {
      final products = await repository.getProducts();

      expect(products.length, 36);
    });

    test('seed is idempotent across multiple calls', () async {
      await repository.getCategories();
      await repository.getProducts();

      final productsSecond = await repository.getProducts();

      expect(productsSecond.length, 36);
    });

    test('addProduct persists and returns product', () async {
      await repository.getCategories();

      final now = DateTime.now();
      final product = await repository.addProduct(
        ProductEntity(
          id: 'prod-new',
          categoryId: 'cat-beverages',
          name: 'Espresso',
          barcode: 'ESP-001',
          price: 45.0,
          unit: 'cup',
          stockQuantity: 10.0,
          vatRate: 0.0,
          isActive: true,
          createdAt: now,
        ),
      );

      expect(product.name, 'Espresso');
      expect(product.barcode, 'ESP-001');

      final retrieved = await repository.getProducts();
      expect(retrieved.where((p) => p.barcode == 'ESP-001').length, 1);
    });

    test('updateProduct modifies existing product', () async {
      await repository.getCategories();
      final products = await repository.getProducts();
      final first = products.first;

      final updated = await repository.updateProduct(
        first.copyWith(name: 'Updated Name', price: 99.0),
      );

      expect(updated.name, 'Updated Name');
      expect(updated.price, 99.0);
    });

    test('toggleProductActive flips active flag', () async {
      await repository.getCategories();
      final products = await repository.getProducts();
      final first = products.first;
      final original = first.isActive;

      final toggled = await repository.toggleProductActive(first.id);

      expect(toggled.isActive, !original);
    });

    test('searchProducts filters by query', () async {
      await repository.getProducts();

      final results = await repository.searchProducts('coffee');

      expect(results.isNotEmpty, isTrue);
      expect(
        results.every(
          (p) =>
              p.name.toLowerCase().contains('coffee') ||
              p.barcode.toLowerCase().contains('coffee'),
        ),
        isTrue,
      );
    });

    test('getProductsByCategory returns only matching products', () async {
      await repository.getProducts();

      final results = await repository.getProductsByCategory('cat-beverages');

      expect(results.isNotEmpty, isTrue);
      expect(results.every((p) => p.categoryId == 'cat-beverages'), isTrue);
    });
  });
}
