import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

/// Result of hashing a password with PBKDF2-HMAC-SHA256.
///
/// All values are hex-encoded so they can be stored as SQLite TEXT columns.
/// [iterations] is persisted alongside the hash so the cost can be raised in
/// future migrations without invalidating existing credentials.
class PasswordHash {
  /// Hex-encoded 16-byte salt.
  final String saltHex;

  /// PBKDF2 iteration count used to derive [hashHex].
  final int iterations;

  /// Hex-encoded 32-byte derived key.
  final String hashHex;

  const PasswordHash({
    required this.saltHex,
    required this.iterations,
    required this.hashHex,
  });
}

/// Salted, slow password hashing for local POS credentials.
///
/// Uses PBKDF2-HMAC-SHA256 (NIST SP 800-132) with a per-user random salt and a
/// tunable iteration count. This replaces the previous unsalted single-pass
/// SHA-256 scheme, which was vulnerable to rainbow tables and identical-hash
/// detection across users.
///
/// The default iteration count is sized for ~30-60ms on a Sunmi V2-Pro class
/// device — fast enough for interactive login, slow enough to make offline
/// brute force of a stolen database impractical.
///
/// Legacy SHA-256 hashes (created before this change) are detected by a
/// missing [PasswordHash.iterations] on the user row and transparently
/// re-hashed with PBKDF2 on the next successful login.
class PasswordHasher {
  const PasswordHasher();

  /// Default PBKDF2 iteration count for newly hashed passwords.
  static const int defaultIterations = 100000;

  static const int _saltBytes = 16;
  static const int _keyBytes = 32;
  static final _secureRandom = Random.secure();

  /// Hash [password] with PBKDF2-HMAC-SHA256.
  ///
  /// If [saltHex] is omitted a cryptographically secure random salt is
  /// generated. Pass an explicit [salt] only when re-deriving a key for
  /// verification against a stored hash.
  PasswordHash hash(
    String password, {
    String? saltHex,
    int iterations = defaultIterations,
  }) {
    if (iterations < 1000) {
      throw ArgumentError('Iteration count must be at least 1000');
    }
    final salt = saltHex != null ? _hexDecode(saltHex) : _randomSalt();
    final key = _pbkdf2(utf8.encode(password), salt, iterations, _keyBytes);
    return PasswordHash(
      saltHex: _hexEncode(salt),
      iterations: iterations,
      hashHex: _hexEncode(key),
    );
  }

  /// Verify [password] against a previously computed [stored] hash.
  ///
  /// Comparison is constant-time to avoid timing side channels.
  bool verify(String password, PasswordHash stored) {
    final salt = _hexDecode(stored.saltHex);
    final key = _pbkdf2(
      utf8.encode(password),
      salt,
      stored.iterations,
      _keyBytes,
    );
    return _constantTimeEquals(_hexEncode(key), stored.hashHex);
  }

  /// Compute the legacy unsalted SHA-256 hash used by pre-v6 databases.
  ///
  /// Kept only to verify and transparently upgrade legacy credentials.
  String legacySha256(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  /// Verify [password] against a legacy unsalted SHA-256 [storedHash].
  bool verifyLegacySha256(String password, String storedHash) {
    return _constantTimeEquals(legacySha256(password), storedHash);
  }

  /// PBKDF2 key derivation (RFC 2898) using HMAC-SHA256 as the PRF.
  static Uint8List _pbkdf2(
    List<int> password,
    List<int> salt,
    int iterations,
    int keyBytes,
  ) {
    final hmac = Hmac(sha256, password);
    final blockSize = 32;
    final blocks = (keyBytes + blockSize - 1) ~/ blockSize;
    final out = BytesBuilder();

    for (var blockIndex = 1; blockIndex <= blocks; blockIndex++) {
      // INT_32_BE(blockIndex)
      final indexBytes = ByteData(4)..setUint32(0, blockIndex);
      final firstInput = Uint8List.fromList([
        ...salt,
        ...indexBytes.buffer.asUint8List(),
      ]);
      var u = Uint8List.fromList(hmac.convert(firstInput).bytes);
      final t = Uint8List.fromList(u);

      for (var j = 1; j < iterations; j++) {
        u = Uint8List.fromList(hmac.convert(u).bytes);
        for (var k = 0; k < t.length; k++) {
          t[k] ^= u[k];
        }
      }

      out.add(t);
    }

    final result = out.toBytes();
    return Uint8List.fromList(result.sublist(0, keyBytes));
  }

  static Uint8List _randomSalt() {
    final bytes = Uint8List(_saltBytes);
    for (var i = 0; i < _saltBytes; i++) {
      bytes[i] = _secureRandom.nextInt(256);
    }
    return bytes;
  }

  static String _hexEncode(List<int> bytes) {
    const digits = '0123456789abcdef';
    final out = StringBuffer();
    for (final b in bytes) {
      out.write(digits[b >> 4]);
      out.write(digits[b & 0x0f]);
    }
    return out.toString();
  }

  static Uint8List _hexDecode(String hex) {
    final bytes = hex.codeUnits;
    final out = Uint8List(bytes.length ~/ 2);
    for (var i = 0; i < out.length; i++) {
      final hi = _hexDigit(bytes[i * 2]);
      final lo = _hexDigit(bytes[i * 2 + 1]);
      out[i] = (hi << 4) | lo;
    }
    return out;
  }

  static int _hexDigit(int codeUnit) {
    if (codeUnit >= 0x30 && codeUnit <= 0x39) return codeUnit - 0x30;
    if (codeUnit >= 0x41 && codeUnit <= 0x46) return codeUnit - 0x41 + 10;
    if (codeUnit >= 0x61 && codeUnit <= 0x66) return codeUnit - 0x61 + 10;
    throw FormatException('Invalid hex digit: $codeUnit');
  }

  /// Constant-time string equality to mitigate timing attacks.
  static bool _constantTimeEquals(String a, String b) {
    if (a.length != b.length) return false;
    var diff = 0;
    for (var i = 0; i < a.length; i++) {
      diff |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
    }
    return diff == 0;
  }
}
