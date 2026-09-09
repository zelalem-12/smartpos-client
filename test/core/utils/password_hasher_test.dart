import 'package:flutter_test/flutter_test.dart';
import 'package:smartpos_client/core/utils/password_hasher.dart';

void main() {
  const hasher = PasswordHasher();

  group('PasswordHasher PBKDF2', () {
    test('hash produces a salt, iterations and a 32-byte hex key', () {
      final h = hasher.hash('secret123');
      expect(h.saltHex.length, 32); // 16 bytes -> 32 hex chars
      expect(h.iterations, PasswordHasher.defaultIterations);
      expect(h.hashHex.length, 64); // 32 bytes -> 64 hex chars
    });

    test('verify succeeds for the correct password', () {
      final h = hasher.hash('correct horse battery');
      expect(hasher.verify('correct horse battery', h), isTrue);
    });

    test('verify fails for the wrong password', () {
      final h = hasher.hash('correct horse battery');
      expect(hasher.verify('wrong password', h), isFalse);
    });

    test('two hashes for the same password differ (random salt)', () {
      final a = hasher.hash('samepassword');
      final b = hasher.hash('samepassword');
      expect(a.saltHex, isNot(b.saltHex));
      expect(a.hashHex, isNot(b.hashHex));
    });

    test('verify accepts an explicit salt (re-derivation)', () {
      final h = hasher.hash('pw', saltHex: '00112233445566778899aabbccddeeff');
      expect(h.saltHex, '00112233445566778899aabbccddeeff');
      expect(hasher.verify('pw', h), isTrue);
    });

    test('rejects iteration counts below 1000', () {
      expect(() => hasher.hash('pw', iterations: 999), throwsArgumentError);
    });

    test('verify fails if the stored hash is tampered', () {
      final h = hasher.hash('pw');
      final tampered = PasswordHash(
        saltHex: h.saltHex,
        iterations: h.iterations,
        hashHex: '00' * 32,
      );
      expect(hasher.verify('pw', tampered), isFalse);
    });
  });

  group('PasswordHasher legacy SHA-256', () {
    test('legacySha256 matches the unsalted SHA-256 digest', () {
      // Known SHA-256 of "1234".
      expect(
        hasher.legacySha256('1234'),
        '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4',
      );
    });

    test('verifyLegacySha256 accepts the correct password', () {
      final stored = hasher.legacySha256('mypass');
      expect(hasher.verifyLegacySha256('mypass', stored), isTrue);
    });

    test('verifyLegacySha256 rejects the wrong password', () {
      final stored = hasher.legacySha256('mypass');
      expect(hasher.verifyLegacySha256('other', stored), isFalse);
    });
  });
}
