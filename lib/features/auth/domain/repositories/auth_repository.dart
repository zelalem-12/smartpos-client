import '../entities/user_entity.dart';

/// Abstract contract for local authentication and user management.
///
/// Implementations persist users to the local Drift database.
abstract class AuthRepository {
  /// Create the initial manager account.
  ///
  /// Validates the manager doesn't already exist, hashes the password,
  /// and persists the user. Returns the created [UserEntity].
  Future<UserEntity> createManager({
    required String username,
    required String fullName,
    required String password,
  });

  /// Create a new cashier account (manager-only operation).
  ///
  /// Throws [ConflictFailure] if the username already exists.
  Future<UserEntity> createCashier({
    required String username,
    required String fullName,
    required String password,
  });

  /// Check if any active manager already exists.
  Future<bool> hasManager();

  /// Authenticate an active user by username and password.
  ///
  /// Throws [AuthFailure] when credentials are invalid or the user is inactive.
  Future<UserEntity> loginWithCredentials({
    required String username,
    required String password,
  });

  /// Check whether [username] is already taken by an active user.
  Future<bool> usernameExists(String username);
}
