// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_config_dao.dart';

// ignore_for_file: type=lint
mixin _$StoreConfigDaoMixin on DatabaseAccessor<AppDatabase> {
  $StoreConfigsTable get storeConfigs => attachedDatabase.storeConfigs;
  StoreConfigDaoManager get managers => StoreConfigDaoManager(this);
}

class StoreConfigDaoManager {
  final _$StoreConfigDaoMixin _db;
  StoreConfigDaoManager(this._db);
  $$StoreConfigsTableTableManager get storeConfigs =>
      $$StoreConfigsTableTableManager(_db.attachedDatabase, _db.storeConfigs);
}
