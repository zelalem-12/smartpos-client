import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:smartpos_client/core/database/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting();
  });

  tearDown(() async {
    await db.close();
  });

  group('StoreConfig', () {
    test('isDeviceActivated returns false on fresh database', () async {
      expect(await db.isDeviceActivated(), isFalse);
    });

    test('saveStoreConfig inserts and getStoreConfig retrieves', () async {
      await db.saveStoreConfig(
        StoreConfigsCompanion.insert(
          licenseKey: 'ACT-89412',
          businessName: 'Bole Roasters Cafe PLC',
          tradeName: 'Bole Cafe',
          tin: '0012345678',
          vatRegNo: '123456789',
          sector: '18. Restaurants & Food Service',
          address: 'Addis Ababa, Bole',
          deviceSerial: 'SUNMI-V2P-ET-89412',
        ),
      );

      final config = await db.getStoreConfig();
      expect(config, isNotNull);
      expect(config!.tin, '0012345678');
      expect(config.businessName, 'Bole Roasters Cafe PLC');
      expect(config.tradeName, 'Bole Cafe');
      expect(config.licenseKey, 'ACT-89412');
      expect(config.deviceSerial, 'SUNMI-V2P-ET-89412');
    });

    test('isDeviceActivated returns true after config saved', () async {
      await db.saveStoreConfig(
        StoreConfigsCompanion.insert(
          licenseKey: 'ACT-89412',
          businessName: 'Test',
          tradeName: 'Test',
          tin: '0012345678',
          vatRegNo: '123456789',
          sector: 'Test',
          address: 'Test',
          deviceSerial: 'TEST-001',
        ),
      );

      expect(await db.isDeviceActivated(), isTrue);
    });
  });

  group('Users', () {
    test('getActiveUsers returns empty on fresh database', () async {
      final users = await db.getActiveUsers();
      expect(users, isEmpty);
    });

    test('insertUser and retrieve by ID', () async {
      await db.insertUser(
        UsersCompanion.insert(
          id: 'mgr-001',
          username: 'abebe01',
          fullName: 'Abebe Bikila',
          role: 'MANAGER',
          passwordHash: 'abc123hash',
        ),
      );

      final user = await db.getUserById('mgr-001');
      expect(user, isNotNull);
      expect(user!.username, 'abebe01');
      expect(user.fullName, 'Abebe Bikila');
      expect(user.role, 'MANAGER');
      expect(user.isActive, isTrue);
    });

    test('hasManager returns false when no manager exists', () async {
      expect(await db.hasManager(), isFalse);
    });

    test('hasManager returns true after manager inserted', () async {
      await db.insertUser(
        UsersCompanion.insert(
          id: 'mgr-001',
          username: 'abebe01',
          fullName: 'Abebe Bikila',
          role: 'MANAGER',
          passwordHash: 'abc123hash',
        ),
      );

      expect(await db.hasManager(), isTrue);
    });

    test('hasManager returns false when manager is deactivated', () async {
      await db.insertUser(
        UsersCompanion.insert(
          id: 'mgr-001',
          username: 'abebe01',
          fullName: 'Abebe Bikila',
          role: 'MANAGER',
          passwordHash: 'abc123hash',
          isActive: const Value(false),
        ),
      );

      expect(await db.hasManager(), isFalse);
    });

    test('findUserByUsername returns correct user', () async {
      await db.insertUser(
        UsersCompanion.insert(
          id: 'csh-001',
          username: 'selam_t',
          fullName: 'Selam Teshale',
          role: 'CASHIER',
          passwordHash: 'pin1111hash',
        ),
      );
      await db.insertUser(
        UsersCompanion.insert(
          id: 'csh-002',
          username: 'dawit_k',
          fullName: 'Dawit Kebede',
          role: 'CASHIER',
          passwordHash: 'pin2222hash',
        ),
      );

      final user = await db.findUserByUsername('dawit_k');
      expect(user, isNotNull);
      expect(user!.fullName, 'Dawit Kebede');
    });

    test('findUserByUsername returns null for inactive user', () async {
      await db.insertUser(
        UsersCompanion.insert(
          id: 'csh-001',
          username: 'inactive',
          fullName: 'Inactive User',
          role: 'CASHIER',
          passwordHash: 'inactivehash',
          isActive: const Value(false),
        ),
      );

      final user = await db.findUserByUsername('inactive');
      expect(user, isNull);
    });

    test('getActiveUsers returns only active users', () async {
      await db.insertUser(
        UsersCompanion.insert(
          id: 'u1',
          username: 'active',
          fullName: 'Active',
          role: 'CASHIER',
          passwordHash: 'h1',
        ),
      );
      await db.insertUser(
        UsersCompanion.insert(
          id: 'u2',
          username: 'inactive',
          fullName: 'Inactive',
          role: 'CASHIER',
          passwordHash: 'h2',
          isActive: const Value(false),
        ),
      );

      final users = await db.getActiveUsers();
      expect(users.length, 1);
      expect(users.first.username, 'active');
    });
  });

  group('Categories', () {
    test('getAllCategories returns empty on fresh database', () async {
      final categories = await db.getAllCategories();
      expect(categories, isEmpty);
    });

    test('upsertCategory inserts and getCategoryById retrieves', () async {
      await db.upsertCategory(
        CategoriesCompanion.insert(
          id: 'cat-beverages',
          name: 'Beverages',
          description: const Value('Hot and cold drinks'),
        ),
      );

      final category = await db.getCategoryById('cat-beverages');
      expect(category, isNotNull);
      expect(category!.name, 'Beverages');
      expect(category.isActive, isTrue);
    });

    test('getAllCategories orders by name', () async {
      await db.upsertCategory(
        CategoriesCompanion.insert(id: 'cat-z', name: 'Zoo'),
      );
      await db.upsertCategory(
        CategoriesCompanion.insert(id: 'cat-a', name: 'Animals'),
      );

      final categories = await db.getAllCategories();
      expect(categories.first.name, 'Animals');
      expect(categories.last.name, 'Zoo');
    });
  });

  group('Products', () {
    test('insertProduct and getProductById retrieves', () async {
      await db.upsertCategory(
        CategoriesCompanion.insert(id: 'cat-beverages', name: 'Beverages'),
      );
      await db.insertProduct(
        ProductsCompanion.insert(
          id: 'prod-1',
          categoryId: 'cat-beverages',
          name: 'Ethiopian Coffee',
          barcode: 'ETH-COFFEE-001',
          price: 35.0,
          unit: 'cup',
        ),
      );

      final product = await db.getProductById('prod-1');
      expect(product, isNotNull);
      expect(product!.name, 'Ethiopian Coffee');
      expect(product.price, 35.0);
      expect(product.isActive, isTrue);
    });

    test('searchProducts filters by name and barcode', () async {
      await db.upsertCategory(
        CategoriesCompanion.insert(id: 'cat-beverages', name: 'Beverages'),
      );
      await db.insertProduct(
        ProductsCompanion.insert(
          id: 'prod-1',
          categoryId: 'cat-beverages',
          name: 'Ethiopian Coffee',
          barcode: 'ETH-COFFEE-001',
          price: 35.0,
          unit: 'cup',
        ),
      );
      await db.insertProduct(
        ProductsCompanion.insert(
          id: 'prod-2',
          categoryId: 'cat-beverages',
          name: 'Macchiato',
          barcode: 'ETH-MAC-002',
          price: 40.0,
          unit: 'cup',
        ),
      );

      final byName = await db.searchProducts('coffee');
      expect(byName.length, 1);
      expect(byName.first.barcode, 'ETH-COFFEE-001');

      final byBarcode = await db.searchProducts('ETH-MAC');
      expect(byBarcode.length, 1);
      expect(byBarcode.first.name, 'Macchiato');
    });

    test('updateProduct modifies product', () async {
      await db.upsertCategory(
        CategoriesCompanion.insert(id: 'cat-beverages', name: 'Beverages'),
      );
      await db.insertProduct(
        ProductsCompanion.insert(
          id: 'prod-1',
          categoryId: 'cat-beverages',
          name: 'Ethiopian Coffee',
          barcode: 'ETH-COFFEE-001',
          price: 35.0,
          unit: 'cup',
        ),
      );

      final updated = await db.updateProduct(
        const ProductsCompanion(
          id: Value('prod-1'),
          name: Value('Premium Coffee'),
          price: Value(50.0),
        ),
      );
      expect(updated, isTrue);

      final product = await db.getProductById('prod-1');
      expect(product!.name, 'Premium Coffee');
      expect(product.price, 50.0);
    });

    test('findProductByBarcode returns correct product', () async {
      await db.upsertCategory(
        CategoriesCompanion.insert(id: 'cat-beverages', name: 'Beverages'),
      );
      await db.insertProduct(
        ProductsCompanion.insert(
          id: 'prod-1',
          categoryId: 'cat-beverages',
          name: 'Ethiopian Coffee',
          barcode: 'ETH-COFFEE-001',
          price: 35.0,
          unit: 'cup',
        ),
      );

      final product = await db.findProductByBarcode('ETH-COFFEE-001');
      expect(product, isNotNull);
      expect(product!.name, 'Ethiopian Coffee');
    });

    test('duplicate barcode insert throws', () async {
      await db.upsertCategory(
        CategoriesCompanion.insert(id: 'cat-beverages', name: 'Beverages'),
      );
      await db.insertProduct(
        ProductsCompanion.insert(
          id: 'prod-1',
          categoryId: 'cat-beverages',
          name: 'Ethiopian Coffee',
          barcode: 'ETH-COFFEE-001',
          price: 35.0,
          unit: 'cup',
        ),
      );

      expect(
        () => db.insertProduct(
          ProductsCompanion.insert(
            id: 'prod-2',
            categoryId: 'cat-beverages',
            name: 'Another Coffee',
            barcode: 'ETH-COFFEE-001',
            price: 30.0,
            unit: 'cup',
          ),
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('countProducts returns zero on fresh database', () async {
      expect(await db.countProducts(), 0);
    });
  });
}
