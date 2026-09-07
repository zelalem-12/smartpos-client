import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/failures.dart';
import '../entities/store_config_entity.dart';
import '../repositories/activation_repository.dart';

/// Activates the POS device using a license key.
///
/// Validates the key format (ACT-XXXXX, 9 chars) before delegating
/// to the repository for remote verification and local persistence.
class ActivateDevice {
  final ActivationRepository _repository;

  const ActivateDevice(this._repository);

  /// Execute the activation.
  ///
  /// Returns the persisted [StoreConfigEntity] on success.
  /// Throws [ValidationFailure] for bad key format,
  /// [ServerFailure] for API errors, [CacheFailure] for DB errors.
  Future<StoreConfigEntity> call(String licenseKey) async {
    final trimmed = licenseKey.trim().toUpperCase();

    if (trimmed.isEmpty) {
      throw const ValidationFailure('License key is required');
    }

    if (!trimmed.startsWith(AppConstants.licenseKeyPrefix)) {
      throw ValidationFailure(
        'License key must start with "${AppConstants.licenseKeyPrefix}"',
      );
    }

    if (trimmed.length != AppConstants.licenseKeyLength) {
      throw ValidationFailure(
        'License key must be ${AppConstants.licenseKeyLength} characters '
        '(e.g. ACT-XXXXX)',
      );
    }

    return _repository.activateDevice(trimmed);
  }
}
