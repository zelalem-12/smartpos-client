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

  AuthRepositoryImpl({required this._localSource, Uuid? uuid})
    : _uuid = uuid ?? const Uuid();

  @override
  Future<bool> hasManager() => _localSource.hasManager();

  @override
  Future<bool> usernameExists(String username) =>
      _localSource.usernameExists(username);

  @override
  Future<UserEntity> createManager({
    required String username,
    required String fullName,
    required String password,
  }) async {
    final alreadyHasManager = await _localSource.hasManager();
    if (alreadyHasManager) {
      throw const ConflictFailure('A manager already exists on this device');
    }

    return _createUser(
      username: username,
      fullName: fullName,
      password: password,
      role: 'MANAGER',
    );
  }

  @override
  Future<UserEntity> createCashier({
    required String username,
    required String fullName,
    required String password,
  }) async {
    return _createUser(
      username: username,
      fullName: fullName,
      password: password,
      role: 'CASHIER',
    );
  }

  Future<UserEntity> _createUser({
    required String username,
    required String fullName,
    required String password,
    required String role,
  }) async {
    final usernameTaken = await _localSource.usernameExists(username);
    if (usernameTaken) {
      throw ConflictFailure('Username "$username" is already taken');
    }

    final now = DateTime.now();
    final id = _uuid.v4();
    final passwordHash = _hashPassword(password);

    final user = UsersCompanion.insert(
      id: id,
      username: username,
      fullName: fullName,
      role: role,
      passwordHash: passwordHash,
      isActive: const Value(true),
      createdAt: Value(now),
    );

    await _localSource.insertUser(user);

    return UserEntity(
      id: id,
      username: username,
      fullName: fullName,
      role: role,
      passwordHash: passwordHash,
      isActive: true,
      createdAt: now,
    );
  }

  @override
  Future<UserEntity> loginWithCredentials({
    required String username,
    required String password,
  }) async {
    final user = await _localSource.findUserByUsername(username);

    if (user == null) {
      throw const AuthFailure('Invalid username or password');
    }

    final passwordHash = _hashPassword(password);
    if (user.passwordHash != passwordHash) {
      throw const AuthFailure('Invalid username or password');
    }

    return _mapToEntity(user);
  }

  UserEntity _mapToEntity(User user) {
    return UserEntity(
      id: user.id,
      username: user.username,
      fullName: user.fullName,
      role: user.role,
      passwordHash: user.passwordHash,
      isActive: user.isActive,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
    );
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
