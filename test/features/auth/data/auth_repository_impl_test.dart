import 'package:flutter_test/flutter_test.dart';
import 'package:smartpos_client/core/database/app_database.dart';
import 'package:smartpos_client/core/error/failures.dart';
import 'package:smartpos_client/core/utils/password_hasher.dart';
import 'package:smartpos_client/features/auth/data/datasources/auth_local_source.dart';
import 'package:smartpos_client/features/auth/data/repositories/auth_repository_impl.dart';

void main() {
  late AppDatabase db;
  late AuthLocalSource localSource;
  late AuthRepositoryImpl repo;

  setUp(() {
    db = AppDatabase.forTesting();
    localSource = AuthLocalSource(db);
    repo = AuthRepositoryImpl(localSource: localSource);
  });

  tearDown(() => db.close());

  group('AuthRepositoryImpl password hashing', () {
    test('createManager stores a PBKDF2 salt and iteration count', () async {
      final manager = await repo.createManager(
        username: 'abebe01',
        fullName: 'Abebe Bikila',
        password: '1234',
      );

      final stored = await db.getUserById(manager.id);
      expect(stored, isNotNull);
      expect(stored!.passwordSalt, isNotNull);
      expect(stored.passwordIterations, PasswordHasher.defaultIterations);
      // The stored hash must NOT be the unsalted SHA-256 of "1234".
      expect(stored.passwordHash, isNot(PasswordHasher().legacySha256('1234')));
    });

    test('loginWithCredentials succeeds with the correct password', () async {
      await repo.createManager(
        username: 'abebe01',
        fullName: 'Abebe',
        password: 'secret',
      );
      final user = await repo.loginWithCredentials(
        username: 'abebe01',
        password: 'secret',
      );
      expect(user.username, 'abebe01');
    });

    test('loginWithCredentials fails with the wrong password', () async {
      await repo.createManager(
        username: 'abebe01',
        fullName: 'Abebe',
        password: 'secret',
      );
      expect(
        () => repo.loginWithCredentials(username: 'abebe01', password: 'wrong'),
        throwsA(isA<AuthFailure>()),
      );
    });

    test('loginWithCredentials fails for an unknown user', () async {
      expect(
        () => repo.loginWithCredentials(username: 'nobody', password: 'x'),
        throwsA(isA<AuthFailure>()),
      );
    });

    test(
      'transparently re-hashes a legacy SHA-256 row on next successful login',
      () async {
        // Seed a legacy unsalted SHA-256 user directly into the DB.
        const hasher = PasswordHasher();
        await db.insertUser(
          UsersCompanion.insert(
            id: 'legacy-1',
            username: 'legacy',
            fullName: 'Legacy User',
            role: 'CASHIER',
            passwordHash: hasher.legacySha256('oldpass'),
            // passwordSalt / passwordIterations intentionally null (legacy).
          ),
        );

        final storedBefore = await db.getUserById('legacy-1');
        expect(storedBefore!.passwordSalt, isNull);
        expect(storedBefore.passwordIterations, isNull);

        // First login with the legacy password succeeds and upgrades the row.
        final user = await repo.loginWithCredentials(
          username: 'legacy',
          password: 'oldpass',
        );
        expect(user.id, 'legacy-1');

        final storedAfter = await db.getUserById('legacy-1');
        expect(storedAfter!.passwordSalt, isNotNull);
        expect(
          storedAfter.passwordIterations,
          PasswordHasher.defaultIterations,
        );
        // The hash must no longer be the legacy digest.
        expect(storedAfter.passwordHash, isNot(hasher.legacySha256('oldpass')));

        // The old password still works against the new PBKDF2 hash.
        expect(
          await repo.loginWithCredentials(
            username: 'legacy',
            password: 'oldpass',
          ),
          isNotNull,
        );
        // A wrong password now fails against the upgraded hash.
        expect(
          () => repo.loginWithCredentials(username: 'legacy', password: 'nope'),
          throwsA(isA<AuthFailure>()),
        );
      },
    );

    test('createCashier stores PBKDF2 credentials', () async {
      // A manager must exist first for the device state, but createCashier
      // itself only checks username uniqueness.
      final cashier = await repo.createCashier(
        username: 'selam_t',
        fullName: 'Selam',
        password: 'cashierpw',
      );
      final stored = await db.getUserById(cashier.id);
      expect(stored!.passwordSalt, isNotNull);
      expect(stored.passwordIterations, PasswordHasher.defaultIterations);
    });
  });
}
