import '../../../../core/database/app_database.dart';
import '../../../../core/error/failures.dart';

/// Local data source for authentication-related persistence.
///
/// Writes manager/cashier user records to the Drift database.
class AuthLocalSource {
  final AppDatabase _db;

  const AuthLocalSource(this._db);

  /// Insert a new user into the database.
  ///
  /// Throws [CacheFailure] if the database write fails.
  Future<void> insertUser(UsersCompanion user) async {
    try {
      await _db.insertUser(user);
    } catch (e) {
      throw CacheFailure('Failed to save user: $e');
    }
  }

  /// Check if any active manager exists.
  Future<bool> hasManager() => _db.hasManager();

  /// Find an active user by their username.
  ///
  /// Returns `null` when no matching active user is found.
  Future<User?> findUserByUsername(String username) =>
      _db.findUserByUsername(username);

  /// Check whether an active user with [username] already exists.
  Future<bool> usernameExists(String username) async {
    final user = await _db.findUserByUsername(username);
    return user != null;
  }
}
