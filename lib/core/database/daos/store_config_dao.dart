import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/store_config_table.dart';

part 'store_config_dao.g.dart';

/// Data access for the store configuration table.
///
/// Persistence-only: no business validation lives here.
@DriftAccessor(tables: [StoreConfigs])
class StoreConfigDao extends DatabaseAccessor<AppDatabase>
    with _$StoreConfigDaoMixin {
  StoreConfigDao(super.db);

  Future<StoreConfig?> getStoreConfig() {
    final query = select(storeConfigs)..limit(1);
    return query.getSingleOrNull();
  }

  Future<int> saveStoreConfig(StoreConfigsCompanion config) {
    return into(storeConfigs).insert(config);
  }

  Future<bool> isDeviceActivated() async {
    final config = await getStoreConfig();
    return config != null;
  }
}
