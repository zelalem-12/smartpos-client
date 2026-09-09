import 'package:smartpos_client/core/database/app_database.dart';
import 'package:smartpos_client/core/repositories/store_config_repository.dart';
import 'package:smartpos_client/core/repositories/user_repository.dart';
import 'package:smartpos_client/core/services/session_service.dart';

/// A [SessionService] pre-configured for widget tests.
///
/// Extends [SessionService] (a [ChangeNotifier]) so it satisfies GoRouter's
/// `refreshListenable`, and seeds the cached startup state via
/// [SessionService.seedStartupState] so the synchronous `evaluateRedirect`
/// works without an async `init()` call or a real database.
class FakeSessionService extends SessionService {
  FakeSessionService({
    bool isActivated = true,
    bool hasManager = true,
    String role = 'MANAGER',
    String id = 'u1',
    String name = 'Abebe',
  }) : super(_NoopStoreConfigRepository(), _NoopUserRepository()) {
    seedStartupState(isActivated: isActivated, hasManager: hasManager);
    setUser(id, name, role);
  }
}

class _NoopStoreConfigRepository implements StoreConfigRepository {
  const _NoopStoreConfigRepository();

  @override
  Future<bool> isDeviceActivated() async => true;

  @override
  Future<StoreConfig?> getStoreConfig() async => null;

  @override
  Future<int> saveStoreConfig(StoreConfigsCompanion config) async => 0;
}

class _NoopUserRepository implements UserRepository {
  const _NoopUserRepository();

  @override
  Future<List<User>> getActiveUsers() async => const [];

  @override
  Future<List<User>> getAllUsers() async => const [];

  @override
  Future<User?> getUserById(String id) async => null;

  @override
  Future<int> insertUser(UsersCompanion user) async => 0;

  @override
  Future<bool> updateUser(UsersCompanion user) async => false;

  @override
  Future<bool> hasManager() async => true;

  @override
  Future<User?> findUserByUsername(String username) async => null;
}
