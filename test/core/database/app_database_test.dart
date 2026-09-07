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
          name: 'Abebe Bikila',
          role: 'MANAGER',
          pinHash: 'abc123hash',
        ),
      );

      final user = await db.getUserById('mgr-001');
      expect(user, isNotNull);
      expect(user!.name, 'Abebe Bikila');
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
          name: 'Abebe Bikila',
          role: 'MANAGER',
          pinHash: 'abc123hash',
        ),
      );

      expect(await db.hasManager(), isTrue);
    });

    test('hasManager returns false when manager is deactivated', () async {
      await db.insertUser(
        UsersCompanion.insert(
          id: 'mgr-001',
          name: 'Abebe Bikila',
          role: 'MANAGER',
          pinHash: 'abc123hash',
          isActive: const Value(false),
        ),
      );

      expect(await db.hasManager(), isFalse);
    });

    test('findUserByPinHash returns correct user', () async {
      await db.insertUser(
        UsersCompanion.insert(
          id: 'csh-001',
          name: 'Selam Teshale',
          role: 'CASHIER',
          pinHash: 'pin1111hash',
        ),
      );
      await db.insertUser(
        UsersCompanion.insert(
          id: 'csh-002',
          name: 'Dawit Kebede',
          role: 'CASHIER',
          pinHash: 'pin2222hash',
        ),
      );

      final user = await db.findUserByPinHash('pin2222hash');
      expect(user, isNotNull);
      expect(user!.name, 'Dawit Kebede');
    });

    test('findUserByPinHash returns null for inactive user', () async {
      await db.insertUser(
        UsersCompanion.insert(
          id: 'csh-001',
          name: 'Inactive User',
          role: 'CASHIER',
          pinHash: 'inactivehash',
          isActive: const Value(false),
        ),
      );

      final user = await db.findUserByPinHash('inactivehash');
      expect(user, isNull);
    });

    test('getActiveUsers returns only active users', () async {
      await db.insertUser(
        UsersCompanion.insert(
          id: 'u1',
          name: 'Active',
          role: 'CASHIER',
          pinHash: 'h1',
        ),
      );
      await db.insertUser(
        UsersCompanion.insert(
          id: 'u2',
          name: 'Inactive',
          role: 'CASHIER',
          pinHash: 'h2',
          isActive: const Value(false),
        ),
      );

      final users = await db.getActiveUsers();
      expect(users.length, 1);
      expect(users.first.name, 'Active');
    });
  });
}
