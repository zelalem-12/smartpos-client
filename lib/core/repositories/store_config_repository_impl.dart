import '../../core/database/app_database.dart';
import 'store_config_repository.dart';

/// Local database implementation of [StoreConfigRepository].
///
/// Delegates all operations to the Drift [AppDatabase].
/// When a remote sync layer is needed, compose this with
/// a remote data source in a higher-level repository.
class StoreConfigRepositoryImpl implements StoreConfigRepository {
  final AppDatabase _db;

  const StoreConfigRepositoryImpl(this._db);

  @override
  Future<StoreConfig?> getStoreConfig() => _db.getStoreConfig();

  @override
  Future<int> saveStoreConfig(StoreConfigsCompanion config) =>
      _db.saveStoreConfig(config);

  @override
  Future<bool> isDeviceActivated() => _db.isDeviceActivated();
}
