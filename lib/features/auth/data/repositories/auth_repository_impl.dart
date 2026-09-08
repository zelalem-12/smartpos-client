import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_source.dart';

/// Concrete auth repository backed by the local Drift database.
class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalSource _localSource;
  final Uuid _uuid;

  AuthRepositoryImpl({
    required this._localSource,
    Uuid? uuid,
  }) : _uuid = uuid ?? const Uuid();

  @override
  Future<UserEntity> createManager({
    required String name,
    required String pin,
  }) async {
    final alreadyHasManager = await _localSource.hasManager();
    if (alreadyHasManager) {
      throw const ConflictFailure('A manager already exists on this device');
    }

    final now = DateTime.now();
    final id = _uuid.v4();
    final pinHash = _hashPin(pin);

    final user = UsersCompanion.insert(
      id: id,
      name: name,
      role: 'MANAGER',
      pinHash: pinHash,
      isActive: const Value(true),
      createdAt: Value(now),
    );

    await _localSource.insertUser(user);

    return UserEntity(
      id: id,
      name: name,
      role: 'MANAGER',
      pinHash: pinHash,
      isActive: true,
      createdAt: now,
    );
  }

  @override
  Future<bool> hasManager() => _localSource.hasManager();

  String _hashPin(String pin) {
    final bytes = utf8.encode(pin);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
