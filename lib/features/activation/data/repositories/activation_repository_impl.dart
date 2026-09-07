import '../../domain/entities/store_config_entity.dart';
import '../../domain/repositories/activation_repository.dart';
import '../datasources/activation_local_source.dart';
import '../datasources/activation_remote_source.dart';

/// Concrete activation repository that composes remote + local sources.
///
/// 1. Calls the remote source to verify the license key and get config.
/// 2. Persists the config locally via the local source.
/// 3. Returns the domain entity.
class ActivationRepositoryImpl implements ActivationRepository {
  final ActivationRemoteSource _remoteSource;
  final ActivationLocalSource _localSource;

  const ActivationRepositoryImpl({
    required this._remoteSource,
    required this._localSource,
  });

  @override
  Future<StoreConfigEntity> activateDevice(String licenseKey) async {
    // 1. Call remote API
    final response = await _remoteSource.activateDevice(licenseKey);

    // 2. Convert to domain entity
    final entity = response.toEntity(licenseKey);

    // 3. Persist locally
    await _localSource.saveStoreConfig(entity);

    return entity;
  }
}
