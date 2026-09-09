import '../../core/database/app_database.dart';

/// Abstract repository for user operations.
///
/// Mediates between the data layer (local DB, remote API) and
/// the BLoC/service layer. Implementations can compose local
/// and remote data sources for sync scenarios.
abstract class UserRepository {
  /// Get all active users.
  Future<List<User>> getActiveUsers();

  Future<List<User>> getAllUsers();

  /// Get a user by ID.
  Future<User?> getUserById(String id);

  /// Insert a new user (manager or cashier).
  Future<int> insertUser(UsersCompanion user);

  /// Update a user (e.g. PIN change, deactivation).
  Future<bool> updateUser(UsersCompanion user);

  /// Check if any active manager exists.
  Future<bool> hasManager();

  /// Find an active user by username.
  Future<User?> findUserByUsername(String username);
}
