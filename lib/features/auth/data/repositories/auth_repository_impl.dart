import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/password_hasher.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_source.dart';

/// Concrete auth repository backed by the local Drift database.
///
/// Passwords are hashed with PBKDF2-HMAC-SHA256 (per-user salt, persisted
/// iteration count). Legacy rows created before schema v6 hold an unsalted
/// SHA-256 digest and are transparently re-hashed with PBKDF2 on the next
/// successful login, so existing installations are upgraded without forcing
/// a password reset.
class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalSource _localSource;
  final Uuid _uuid;
  final PasswordHasher _hasher;

  AuthRepositoryImpl({
    required this._localSource,
    Uuid? uuid,
    this._hasher = const PasswordHasher(),
  }) : _uuid = uuid ?? const Uuid();

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
    final hash = _hasher.hash(password);

    final user = UsersCompanion.insert(
      id: id,
      username: username,
      fullName: fullName,
      role: role,
      passwordHash: hash.hashHex,
      passwordSalt: Value(hash.saltHex),
      passwordIterations: Value(hash.iterations),
      isActive: const Value(true),
      createdAt: Value(now),
    );

    await _localSource.insertUser(user);

    return UserEntity(
      id: id,
      username: username,
      fullName: fullName,
      role: role,
      passwordHash: hash.hashHex,
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

    final verified = _verifyStoredPassword(user, password);
    if (!verified) {
      throw const AuthFailure('Invalid username or password');
    }

    // Transparent upgrade: legacy unsalted SHA-256 rows are re-hashed with
    // PBKDF2 on the first successful login after the v6 migration.
    if (user.passwordIterations == null || user.passwordSalt == null) {
      await _upgradeLegacyPassword(user.id, password);
    }

    return _mapToEntity(user);
  }

  bool _verifyStoredPassword(User user, String password) {
    if (user.passwordSalt != null && user.passwordIterations != null) {
      return _hasher.verify(
        password,
        PasswordHash(
          saltHex: user.passwordSalt!,
          iterations: user.passwordIterations!,
          hashHex: user.passwordHash,
        ),
      );
    }
    // Legacy unsalted SHA-256 row.
    return _hasher.verifyLegacySha256(password, user.passwordHash);
  }

  Future<void> _upgradeLegacyPassword(String userId, String password) async {
    final hash = _hasher.hash(password);
    await _localSource.updateUser(
      UsersCompanion(
        id: Value(userId),
        passwordHash: Value(hash.hashHex),
        passwordSalt: Value(hash.saltHex),
        passwordIterations: Value(hash.iterations),
        updatedAt: Value(DateTime.now()),
      ),
    );
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
}
