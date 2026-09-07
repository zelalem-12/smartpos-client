import '../../../../core/database/app_database.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/store_config_entity.dart';

/// Local data source for persisting activation data.
///
/// Writes the store configuration to the Drift database after
/// successful remote activation.
class ActivationLocalSource {
  final AppDatabase _db;

  const ActivationLocalSource(this._db);

  /// Persist the store configuration from an activation response.
  ///
  /// Throws [CacheFailure] if the database write fails.
  Future<void> saveStoreConfig(StoreConfigEntity entity) async {
    try {
      await _db.saveStoreConfig(
        StoreConfigsCompanion.insert(
          licenseKey: entity.licenseKey,
          businessName: entity.businessName,
          tradeName: entity.tradeName,
          tin: entity.tin,
          vatRegNo: entity.vatRegNo,
          sector: entity.sector,
          address: entity.address,
          deviceSerial: entity.deviceSerial,
        ),
      );
    } catch (e) {
      throw CacheFailure('Failed to save store config: $e');
    }
  }

  /// Check if the device has already been activated.
  Future<bool> isDeviceActivated() => _db.isDeviceActivated();
}
