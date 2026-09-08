import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// Creates a new cashier account (manager-only operation).
///
/// Validates the username, full name, and password, then delegates to
/// the repository for hashing and persistence.
class CreateCashier {
  final AuthRepository _repository;

  const CreateCashier(this._repository);

  /// Execute cashier creation.
  ///
  /// Returns the created [UserEntity] on success.
  /// Throws [ValidationFailure] for invalid input.
  /// Throws [ConflictFailure] if the username already exists.
  /// Throws [CacheFailure] for database errors.
  Future<UserEntity> call({
    required String username,
    required String fullName,
    required String password,
  }) async {
    final trimmedUsername = username.trim();
    final trimmedFullName = fullName.trim();

    if (trimmedUsername.isEmpty) {
      throw const ValidationFailure('Username is required');
    }

    if (trimmedUsername.length < 3) {
      throw const ValidationFailure('Username must be at least 3 characters');
    }

    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(trimmedUsername)) {
      throw const ValidationFailure(
        'Username may only contain letters, numbers, and underscores',
      );
    }

    if (trimmedFullName.isEmpty) {
      throw const ValidationFailure('Full name is required');
    }

    if (trimmedFullName.length < 2) {
      throw const ValidationFailure('Full name must be at least 2 characters');
    }

    if (password.isEmpty) {
      throw const ValidationFailure('Password is required');
    }

    if (password.length < 4) {
      throw const ValidationFailure('Password must be at least 4 characters');
    }

    return _repository.createCashier(
      username: trimmedUsername,
      fullName: trimmedFullName,
      password: password,
    );
  }
}
