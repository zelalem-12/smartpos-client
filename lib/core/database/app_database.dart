import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'tables/store_config_table.dart';
import 'tables/users_table.dart';

part 'app_database.g.dart';

/// The single Drift database instance for the entire POS application.
///
/// In production, this uses an encrypted SQLite file via sqlite3mc.
/// In tests, this uses NativeDatabase.memory() for instant in-memory testing.
@DriftDatabase(tables: [StoreConfigs, Users])
class AppDatabase extends _$AppDatabase {
  /// Production constructor — call with a real QueryExecutor.
  AppDatabase(super.e);

  /// Test constructor — uses an in-memory database.
  AppDatabase.forTesting()
      : super(
          NativeDatabase.memory(),
        );

  @override
  int get schemaVersion => 1;

  // ─── Store Config DAO ───────────────────────────────────────────────

  /// Get the stored configuration (returns null if device not activated).
  Future<StoreConfig?> getStoreConfig() async {
    return (select(storeConfigs)..limit(1)).getSingleOrNull();
  }

  /// Save store configuration during activation.
  Future<int> saveStoreConfig(StoreConfigsCompanion config) {
    return into(storeConfigs).insert(config);
  }

  /// Check if the device has been activated.
  Future<bool> isDeviceActivated() async {
    final config = await getStoreConfig();
    return config != null;
  }

  // ─── Users DAO ──────────────────────────────────────────────────────

  /// Get all active users.
  Future<List<User>> getActiveUsers() {
    return (select(users)..where((u) => u.isActive.equals(true))).get();
  }

  /// Get a user by ID.
  Future<User?> getUserById(String id) {
    return (select(users)..where((u) => u.id.equals(id))).getSingleOrNull();
  }

  /// Insert a new user (manager or cashier).
  Future<int> insertUser(UsersCompanion user) {
    return into(users).insert(user);
  }

  /// Update a user (e.g. PIN change, deactivation).
  Future<bool> updateUser(UsersCompanion user) {
    return (update(users)..where((u) => u.id.equals(user.id.value)))
        .write(user)
        .then((rows) => rows > 0);
  }

  /// Check if any manager exists.
  Future<bool> hasManager() async {
    final managers = await (select(users)
          ..where((u) => u.role.equals('MANAGER') & u.isActive.equals(true)))
        .get();
    return managers.isNotEmpty;
  }

  /// Find a user by PIN hash and active status.
  Future<User?> findUserByPinHash(String pinHash) {
    return (select(users)
          ..where((u) => u.pinHash.equals(pinHash) & u.isActive.equals(true)))
        .getSingleOrNull();
  }
}
