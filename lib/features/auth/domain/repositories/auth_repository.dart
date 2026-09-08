import '../entities/user_entity.dart';

/// Abstract contract for local authentication and user management.
///
/// Implementations persist users to the local Drift database.
abstract class AuthRepository {
  /// Create the initial manager account.
  ///
  /// Validates the manager doesn't already exist, hashes the PIN,
  /// and persists the user. Returns the created [UserEntity].
  Future<UserEntity> createManager({
    required String name,
    required String pin,
  });

  /// Check if any active manager already exists.
  Future<bool> hasManager();
}
