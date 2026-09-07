import '../../core/database/app_database.dart';

/// Abstract repository for store configuration operations.
///
/// Decouples BLoCs/services from direct database access.
/// In the future, this can be composed with remote data sources
/// for sync scenarios.
abstract class StoreConfigRepository {
  /// Get the stored configuration (returns null if device not activated).
  Future<StoreConfig?> getStoreConfig();

  /// Save store configuration during activation.
  Future<int> saveStoreConfig(StoreConfigsCompanion config);

  /// Check if the device has been activated.
  Future<bool> isDeviceActivated();
}
