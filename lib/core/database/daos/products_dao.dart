import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/products_table.dart';

part 'products_dao.g.dart';

/// Data access for the products table.
@DriftAccessor(tables: [Products])
class ProductsDao extends DatabaseAccessor<AppDatabase>
    with _$ProductsDaoMixin {
  ProductsDao(super.db);

  Future<List<Product>> getAllProducts({bool activeOnly = false}) {
    final query = select(products);
    if (activeOnly) {
      query.where((p) => p.isActive.equals(true));
    }
    query.orderBy([(p) => OrderingTerm.asc(p.name)]);
    return query.get();
  }

  Future<List<Product>> getProductsByCategory(String categoryId) {
    return (select(products)
          ..where((p) => p.categoryId.equals(categoryId))
          ..orderBy([(p) => OrderingTerm.asc(p.name)]))
        .get();
  }

  Future<List<Product>> searchProducts(String query) {
    final likeQuery = '%${query.toLowerCase()}%';
    return (select(products)
          ..where(
            (p) =>
                p.name.lower().like(likeQuery) |
                p.barcode.lower().like(likeQuery),
          )
          ..orderBy([(p) => OrderingTerm.asc(p.name)]))
        .get();
  }

  Future<Product?> getProductById(String id) {
    return (select(products)..where((p) => p.id.equals(id))).getSingleOrNull();
  }

  Future<Product?> findProductByBarcode(String barcode) {
    return (select(
      products,
    )..where((p) => p.barcode.equals(barcode))).getSingleOrNull();
  }

  Future<int> insertProduct(ProductsCompanion product) {
    return into(products).insert(product);
  }

  Future<bool> updateProduct(ProductsCompanion product) =>
      (update(products)..where((p) => p.id.equals(product.id.value)))
          .write(product)
          .then((rows) => rows > 0);

  Future<int> countProducts() async {
    final count = products.id.count();
    final row = await (selectOnly(products)..addColumns([count])).getSingle();
    return row.read(count) ?? 0;
  }
}
