import '../entities/store_config_entity.dart';

/// Abstract contract for device activation operations.
///
/// Implementations compose remote (API) and local (Drift) data sources.
abstract class ActivationRepository {
  /// Activate the device using the given [licenseKey].
  ///
  /// 1. Validates key format.
  /// 2. Calls the remote API to retrieve store configuration.
  /// 3. Persists the configuration locally.
  /// 4. Returns the resulting [StoreConfigEntity].
  ///
  /// Throws or returns a failure on validation/network/storage errors.
  Future<StoreConfigEntity> activateDevice(String licenseKey);
}
