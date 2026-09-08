import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// Creates the initial manager account during first-time setup.
///
/// Validates the display name and 4-digit PIN, then delegates to
/// the repository for hashing and persistence.
class CreateManager {
  final AuthRepository _repository;

  const CreateManager(this._repository);

  /// Execute manager creation.
  ///
  /// Returns the created [UserEntity] on success.
  /// Throws [ValidationFailure] for invalid input.
  /// Throws [ConflictFailure] if a manager already exists.
  /// Throws [CacheFailure] for database errors.
  Future<UserEntity> call({
    required String name,
    required String pin,
  }) async {
    final trimmedName = name.trim();

    if (trimmedName.isEmpty) {
      throw const ValidationFailure('Manager name is required');
    }

    if (trimmedName.length < 2) {
      throw const ValidationFailure('Manager name must be at least 2 characters');
    }

    if (pin.length != AppConstants.pinLength) {
      throw ValidationFailure(
        'PIN must be exactly ${AppConstants.pinLength} digits',
      );
    }

    if (!RegExp(r'^\d{4}$').hasMatch(pin)) {
      throw const ValidationFailure('PIN must contain only digits');
    }

    return _repository.createManager(name: trimmedName, pin: pin);
  }
}
