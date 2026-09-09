import '../../core/database/app_database.dart';
import 'user_repository.dart';

/// Local database implementation of [UserRepository].
///
/// Delegates all operations to the Drift [AppDatabase].
/// When a remote sync layer is needed, compose this with
/// a higher-level repository that also calls a remote source.
class UserRepositoryImpl implements UserRepository {
  final AppDatabase _db;

  const UserRepositoryImpl(this._db);

  @override
  Future<List<User>> getActiveUsers() => _db.getActiveUsers();

  @override
  Future<List<User>> getAllUsers() => _db.getAllUsers();

  @override
  Future<User?> getUserById(String id) => _db.getUserById(id);

  @override
  Future<int> insertUser(UsersCompanion user) => _db.insertUser(user);

  @override
  Future<bool> updateUser(UsersCompanion user) => _db.updateUser(user);

  @override
  Future<bool> hasManager() => _db.hasManager();

  @override
  Future<User?> findUserByUsername(String username) =>
      _db.findUserByUsername(username);
}
