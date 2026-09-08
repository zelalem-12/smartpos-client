import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';

/// Local data source for the catalog feature.
///
/// Wraps [AppDatabase] catalog DAOs and exposes an idempotent
/// seed method that populates the default Ethiopian demo catalog
/// (cafe/pharmacy products) when the database is empty.
class CatalogLocalSource {
  final AppDatabase _db;

  const CatalogLocalSource(this._db);

  /// Seed the default catalog if no products exist.
  Future<void> seedCatalogIfEmpty() async {
    final existingCount = await _db.countProducts();
    if (existingCount > 0) return;

    final categoryRows = _defaultCategories();
    final productRows = _defaultProducts();

    await _db.batch((batch) {
      batch.insertAll(
        _db.categories,
        categoryRows.map(
          (c) => CategoriesCompanion.insert(
            id: c['id'] as String,
            name: c['name'] as String,
            description: c['description'] != null
                ? Value(c['description'] as String)
                : const Value.absent(),
            isActive: const Value(true),
          ),
        ),
      );
      batch.insertAll(
        _db.products,
        productRows.map(
          (p) => ProductsCompanion.insert(
            id: p['id'] as String,
            categoryId: p['categoryId'] as String,
            name: p['name'] as String,
            description: p['description'] != null
                ? Value(p['description'] as String)
                : const Value.absent(),
            barcode: p['barcode'] as String,
            price: p['price'] as double,
            cost: p['cost'] != null
                ? Value(p['cost'] as double)
                : const Value.absent(),
            stockQuantity: Value(p['stockQuantity'] as double? ?? 0.0),
            unit: p['unit'] as String,
            vatRate: Value(p['vatRate'] as double? ?? 0.0),
            isActive: const Value(true),
          ),
        ),
      );
    });
  }

  Future<List<Category>> getAllCategories() => _db.getAllCategories();

  Future<Category?> getCategoryById(String id) => _db.getCategoryById(id);

  Future<List<Product>> getAllProducts({bool activeOnly = false}) =>
      _db.getAllProducts(activeOnly: activeOnly);

  Future<List<Product>> getProductsByCategory(String categoryId) =>
      _db.getProductsByCategory(categoryId);

  Future<List<Product>> searchProducts(String query) =>
      _db.searchProducts(query);

  Future<Product?> getProductById(String id) => _db.getProductById(id);

  Future<Product?> findProductByBarcode(String barcode) =>
      _db.findProductByBarcode(barcode);

  Future<int> insertProduct(ProductsCompanion product) =>
      _db.insertProduct(product);

  Future<bool> updateProduct(ProductsCompanion product) =>
      _db.updateProduct(product);

  static List<Map<String, Object?>> _defaultCategories() {
    return [
      {
        'id': 'cat-beverages',
        'name': 'Beverages',
        'description': 'Hot and cold drinks',
      },
      {
        'id': 'cat-pastries',
        'name': 'Pastries & Snacks',
        'description': 'Fresh pastries and quick bites',
      },
      {
        'id': 'cat-pharma-otc',
        'name': 'Pharmacy - OTC Medicines',
        'description': 'Over the counter medicines',
      },
      {
        'id': 'cat-pharma-care',
        'name': 'Pharmacy - Personal Care',
        'description': 'Personal hygiene and care products',
      },
      {
        'id': 'cat-groceries',
        'name': 'Essential Groceries',
        'description': 'Daily grocery staples',
      },
    ];
  }

  static List<Map<String, Object?>> _defaultProducts() {
    const vat = 0.15;
    return [
      // Beverages
      {
        'id': 'prod-bev-001',
        'categoryId': 'cat-beverages',
        'name': 'Ethiopian Coffee (Buna)',
        'description': 'Traditional Ethiopian coffee',
        'barcode': 'ETH-COFFEE-001',
        'price': 35.0,
        'cost': 15.0,
        'stockQuantity': 100.0,
        'unit': 'cup',
        'vatRate': vat,
      },
      {
        'id': 'prod-bev-002',
        'categoryId': 'cat-beverages',
        'name': 'Macchiato',
        'description': 'Ethiopian macchiato',
        'barcode': 'ETH-MAC-002',
        'price': 40.0,
        'cost': 18.0,
        'stockQuantity': 100.0,
        'unit': 'cup',
        'vatRate': vat,
      },
      {
        'id': 'prod-bev-003',
        'categoryId': 'cat-beverages',
        'name': 'Tea (Shay)',
        'description': 'Black tea with rue',
        'barcode': 'ETH-TEA-003',
        'price': 20.0,
        'cost': 8.0,
        'stockQuantity': 100.0,
        'unit': 'cup',
        'vatRate': vat,
      },
      {
        'id': 'prod-bev-004',
        'categoryId': 'cat-beverages',
        'name': 'Mango Juice',
        'description': 'Fresh mango juice',
        'barcode': 'ETH-JUICE-004',
        'price': 60.0,
        'cost': 30.0,
        'stockQuantity': 50.0,
        'unit': 'bottle',
        'vatRate': vat,
      },
      {
        'id': 'prod-bev-005',
        'categoryId': 'cat-beverages',
        'name': 'Bottled Water 500ml',
        'description': 'Purified drinking water',
        'barcode': 'ETH-WTR-005',
        'price': 15.0,
        'cost': 7.0,
        'stockQuantity': 200.0,
        'unit': 'bottle',
        'vatRate': vat,
      },
      {
        'id': 'prod-bev-006',
        'categoryId': 'cat-beverages',
        'name': 'Soft Drink Coca 350ml',
        'description': 'Coca cola soft drink',
        'barcode': 'ETH-COLA-006',
        'price': 35.0,
        'cost': 20.0,
        'stockQuantity': 120.0,
        'unit': 'can',
        'vatRate': vat,
      },
      {
        'id': 'prod-bev-007',
        'categoryId': 'cat-beverages',
        'name': 'Avocado Juice',
        'description': 'Fresh avocado smoothie',
        'barcode': 'ETH-AVO-007',
        'price': 70.0,
        'cost': 35.0,
        'stockQuantity': 40.0,
        'unit': 'glass',
        'vatRate': vat,
      },
      {
        'id': 'prod-bev-008',
        'categoryId': 'cat-beverages',
        'name': 'Spris (Layered Juice)',
        'description': 'Layered mixed fruit juice',
        'barcode': 'ETH-SPRIS-008',
        'price': 80.0,
        'cost': 40.0,
        'stockQuantity': 30.0,
        'unit': 'glass',
        'vatRate': vat,
      },
      // Pastries & Snacks
      {
        'id': 'prod-pas-009',
        'categoryId': 'cat-pastries',
        'name': 'Dabo (Ethiopian Bread)',
        'description': 'Traditional wheat bread',
        'barcode': 'ETH-DABO-009',
        'price': 25.0,
        'cost': 12.0,
        'stockQuantity': 60.0,
        'unit': 'pc',
        'vatRate': vat,
      },
      {
        'id': 'prod-pas-010',
        'categoryId': 'cat-pastries',
        'name': 'Sambusa',
        'description': 'Spiced pastry with lentils',
        'barcode': 'ETH-SAM-010',
        'price': 15.0,
        'cost': 7.0,
        'stockQuantity': 80.0,
        'unit': 'pc',
        'vatRate': vat,
      },
      {
        'id': 'prod-pas-011',
        'categoryId': 'cat-pastries',
        'name': 'Bombolino',
        'description': 'Ethiopian doughnut',
        'barcode': 'ETH-BOMB-011',
        'price': 20.0,
        'cost': 9.0,
        'stockQuantity': 70.0,
        'unit': 'pc',
        'vatRate': vat,
      },
      {
        'id': 'prod-pas-012',
        'categoryId': 'cat-pastries',
        'name': 'Kita',
        'description': 'Traditional flatbread snack',
        'barcode': 'ETH-KITA-012',
        'price': 12.0,
        'cost': 5.0,
        'stockQuantity': 90.0,
        'unit': 'pc',
        'vatRate': vat,
      },
      {
        'id': 'prod-pas-013',
        'categoryId': 'cat-pastries',
        'name': 'Chicken Sandwich',
        'description': 'Grilled chicken sandwich',
        'barcode': 'ETH-SAND-013',
        'price': 85.0,
        'cost': 45.0,
        'stockQuantity': 40.0,
        'unit': 'pc',
        'vatRate': vat,
      },
      {
        'id': 'prod-pas-014',
        'categoryId': 'cat-pastries',
        'name': 'Cake Slice',
        'description': 'Slice of vanilla cake',
        'barcode': 'ETH-CAKE-014',
        'price': 55.0,
        'cost': 25.0,
        'stockQuantity': 35.0,
        'unit': 'slice',
        'vatRate': vat,
      },
      // Pharmacy OTC
      {
        'id': 'prod-otc-015',
        'categoryId': 'cat-pharma-otc',
        'name': 'Paracetamol 500mg',
        'description': 'Pain and fever relief tablets',
        'barcode': 'PH-PCM-015',
        'price': 45.0,
        'cost': 28.0,
        'stockQuantity': 100.0,
        'unit': 'box',
        'vatRate': vat,
      },
      {
        'id': 'prod-otc-016',
        'categoryId': 'cat-pharma-otc',
        'name': 'Ibuprofen 400mg',
        'description': 'Anti-inflammatory tablets',
        'barcode': 'PH-IBU-016',
        'price': 55.0,
        'cost': 35.0,
        'stockQuantity': 80.0,
        'unit': 'box',
        'vatRate': vat,
      },
      {
        'id': 'prod-otc-017',
        'categoryId': 'cat-pharma-otc',
        'name': 'Amoxicillin 500mg',
        'description': 'Antibiotic capsules',
        'barcode': 'PH-AMOX-017',
        'price': 120.0,
        'cost': 85.0,
        'stockQuantity': 60.0,
        'unit': 'box',
        'vatRate': vat,
      },
      {
        'id': 'prod-otc-018',
        'categoryId': 'cat-pharma-otc',
        'name': 'Oral Rehydration Salts',
        'description': 'ORS sachets',
        'barcode': 'PH-ORS-018',
        'price': 25.0,
        'cost': 15.0,
        'stockQuantity': 150.0,
        'unit': 'pack',
        'vatRate': vat,
      },
      {
        'id': 'prod-otc-019',
        'categoryId': 'cat-pharma-otc',
        'name': 'Antacid Tablets',
        'description': 'Indigestion relief',
        'barcode': 'PH-ANT-019',
        'price': 35.0,
        'cost': 20.0,
        'stockQuantity': 90.0,
        'unit': 'box',
        'vatRate': vat,
      },
      {
        'id': 'prod-otc-020',
        'categoryId': 'cat-pharma-otc',
        'name': 'Vitamin C 1000mg',
        'description': 'Immune support tablets',
        'barcode': 'PH-VITC-020',
        'price': 150.0,
        'cost': 95.0,
        'stockQuantity': 50.0,
        'unit': 'bottle',
        'vatRate': vat,
      },
      {
        'id': 'prod-otc-021',
        'categoryId': 'cat-pharma-otc',
        'name': 'Cough Syrup',
        'description': 'Relief for dry cough',
        'barcode': 'PH-COUGH-021',
        'price': 85.0,
        'cost': 55.0,
        'stockQuantity': 45.0,
        'unit': 'bottle',
        'vatRate': vat,
      },
      // Pharmacy Personal Care
      {
        'id': 'prod-care-022',
        'categoryId': 'cat-pharma-care',
        'name': 'Hand Sanitizer 100ml',
        'description': 'Alcohol based sanitizer',
        'barcode': 'PC-SAN-022',
        'price': 65.0,
        'cost': 40.0,
        'stockQuantity': 70.0,
        'unit': 'bottle',
        'vatRate': vat,
      },
      {
        'id': 'prod-care-023',
        'categoryId': 'cat-pharma-care',
        'name': 'Antibacterial Soap',
        'description': 'Protecting hand soap',
        'barcode': 'PC-SOAP-023',
        'price': 35.0,
        'cost': 20.0,
        'stockQuantity': 100.0,
        'unit': 'bar',
        'vatRate': vat,
      },
      {
        'id': 'prod-care-024',
        'categoryId': 'cat-pharma-care',
        'name': 'Toothpaste',
        'description': 'Fluoride toothpaste',
        'barcode': 'PC-PASTE-024',
        'price': 75.0,
        'cost': 45.0,
        'stockQuantity': 80.0,
        'unit': 'tube',
        'vatRate': vat,
      },
      {
        'id': 'prod-care-025',
        'categoryId': 'cat-pharma-care',
        'name': 'Body Lotion',
        'description': 'Moisturizing lotion',
        'barcode': 'PC-LOTION-025',
        'price': 130.0,
        'cost': 80.0,
        'stockQuantity': 40.0,
        'unit': 'bottle',
        'vatRate': vat,
      },
      {
        'id': 'prod-care-026',
        'categoryId': 'cat-pharma-care',
        'name': 'Sunscreen 50ml',
        'description': 'SPF 50 sunscreen',
        'barcode': 'PC-SUN-026',
        'price': 220.0,
        'cost': 150.0,
        'stockQuantity': 30.0,
        'unit': 'tube',
        'vatRate': vat,
      },
      {
        'id': 'prod-care-027',
        'categoryId': 'cat-pharma-care',
        'name': 'Disposable Face Masks (10pcs)',
        'description': 'Surgical face masks',
        'barcode': 'PC-MASK-027',
        'price': 95.0,
        'cost': 60.0,
        'stockQuantity': 60.0,
        'unit': 'pack',
        'vatRate': vat,
      },
      // Essential Groceries
      {
        'id': 'prod-grc-028',
        'categoryId': 'cat-groceries',
        'name': 'Teff Flour 1kg',
        'description': 'Ethiopian teff flour',
        'barcode': 'GR-TEFF-028',
        'price': 180.0,
        'cost': 140.0,
        'stockQuantity': 50.0,
        'unit': 'kg',
        'vatRate': vat,
      },
      {
        'id': 'prod-grc-029',
        'categoryId': 'cat-groceries',
        'name': 'Shiro Powder 500g',
        'description': 'Ground chickpea spice mix',
        'barcode': 'GR-SHIRO-029',
        'price': 120.0,
        'cost': 85.0,
        'stockQuantity': 60.0,
        'unit': 'pack',
        'vatRate': vat,
      },
      {
        'id': 'prod-grc-030',
        'categoryId': 'cat-groceries',
        'name': 'Berbere 200g',
        'description': 'Ethiopian spice blend',
        'barcode': 'GR-BERB-030',
        'price': 95.0,
        'cost': 65.0,
        'stockQuantity': 70.0,
        'unit': 'pack',
        'vatRate': vat,
      },
      {
        'id': 'prod-grc-031',
        'categoryId': 'cat-groceries',
        'name': 'Mitmita 100g',
        'description': 'Hot chili spice powder',
        'barcode': 'GR-MITM-031',
        'price': 55.0,
        'cost': 35.0,
        'stockQuantity': 80.0,
        'unit': 'pack',
        'vatRate': vat,
      },
      {
        'id': 'prod-grc-032',
        'categoryId': 'cat-groceries',
        'name': 'Cooking Oil 1L',
        'description': 'Vegetable cooking oil',
        'barcode': 'GR-OIL-032',
        'price': 220.0,
        'cost': 170.0,
        'stockQuantity': 40.0,
        'unit': 'bottle',
        'vatRate': vat,
      },
      {
        'id': 'prod-grc-033',
        'categoryId': 'cat-groceries',
        'name': 'Sugar 1kg',
        'description': 'White refined sugar',
        'barcode': 'GR-SUGAR-033',
        'price': 90.0,
        'cost': 70.0,
        'stockQuantity': 100.0,
        'unit': 'kg',
        'vatRate': vat,
      },
      {
        'id': 'prod-grc-034',
        'categoryId': 'cat-groceries',
        'name': 'Salt 500g',
        'description': 'Iodized table salt',
        'barcode': 'GR-SALT-034',
        'price': 20.0,
        'cost': 12.0,
        'stockQuantity': 150.0,
        'unit': 'pack',
        'vatRate': vat,
      },
      {
        'id': 'prod-grc-035',
        'categoryId': 'cat-groceries',
        'name': 'Pasta 500g',
        'description': 'Macaroni pasta',
        'barcode': 'GR-PASTA-035',
        'price': 65.0,
        'cost': 45.0,
        'stockQuantity': 80.0,
        'unit': 'pack',
        'vatRate': vat,
      },
      {
        'id': 'prod-grc-036',
        'categoryId': 'cat-groceries',
        'name': 'Rice 1kg',
        'description': 'Long grain rice',
        'barcode': 'GR-RICE-036',
        'price': 110.0,
        'cost': 85.0,
        'stockQuantity': 90.0,
        'unit': 'kg',
        'vatRate': vat,
      },
    ];
  }
}
