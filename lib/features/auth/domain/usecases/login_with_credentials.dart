import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// Authenticate an active user with username and password.
///
/// Validates the credentials and delegates verification to the
/// [AuthRepository].
class LoginWithCredentials {
  final AuthRepository _repository;

  const LoginWithCredentials(this._repository);

  /// Execute credential login.
  ///
  /// Returns the matching [UserEntity] on success.
  /// Throws [ValidationFailure] for invalid input.
  /// Throws [AuthFailure] when the credentials are incorrect.
  Future<UserEntity> call({
    required String username,
    required String password,
  }) async {
    final trimmedUsername = username.trim();

    if (trimmedUsername.isEmpty) {
      throw const ValidationFailure('Username is required');
    }

    if (password.isEmpty) {
      throw const ValidationFailure('Password is required');
    }

    return _repository.loginWithCredentials(
      username: trimmedUsername,
      password: password,
    );
  }
}
