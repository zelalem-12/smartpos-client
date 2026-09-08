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
}
