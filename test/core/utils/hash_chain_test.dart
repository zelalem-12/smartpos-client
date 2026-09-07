import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartpos_client/core/utils/hash_chain.dart';

void main() {
  group('HashChain', () {
    group('computeHash', () {
      test('produces a 64-character hex hash', () {
        final hash = HashChain.computeHash('', '{"id": 1}');
        expect(hash.length, 64);
        expect(RegExp(r'^[a-f0-9]{64}$').hasMatch(hash), isTrue);
      });

      test('produces deterministic output', () {
        final hash1 = HashChain.computeHash('abc', '{"id": 1}');
        final hash2 = HashChain.computeHash('abc', '{"id": 1}');
        expect(hash1, hash2);
      });

      test('different inputs produce different hashes', () {
        final hash1 = HashChain.computeHash('', '{"id": 1}');
        final hash2 = HashChain.computeHash('', '{"id": 2}');
        expect(hash1, isNot(hash2));
      });

      test('first invoice uses empty previous hash', () {
        final hash = HashChain.computeHash('', '{"invoice": 1}');
        expect(hash, isNotEmpty);
      });
    });

    group('verifyHash', () {
      test('returns true for a valid hash', () {
        const json = '{"invoice": 1}';
        final hash = HashChain.computeHash('', json);
        expect(HashChain.verifyHash(hash, '', json), isTrue);
      });

      test('returns false for a tampered hash', () {
        const json = '{"invoice": 1}';
        expect(HashChain.verifyHash('0000deadbeef', '', json), isFalse);
      });

      test('returns false for tampered content', () {
        const json = '{"invoice": 1}';
        final hash = HashChain.computeHash('', json);
        expect(HashChain.verifyHash(hash, '', '{"invoice": 999}'), isFalse);
      });
    });

    group('verifyChain', () {
      test('valid chain of 3 invoices returns -1 (no error)', () {
        final invoices = <String>[
          jsonEncode({'id': 1, 'total': 100}),
          jsonEncode({'id': 2, 'total': 200}),
          jsonEncode({'id': 3, 'total': 300}),
        ];

        final entries = <Map<String, String>>[];
        var prevHash = '';
        for (final inv in invoices) {
          final hash = HashChain.computeHash(prevHash, inv);
          entries.add({'hash': hash, 'json': inv});
          prevHash = hash;
        }

        expect(HashChain.verifyChain(entries), -1);
      });

      test('tampered entry #2 returns index 1', () {
        final invoices = <String>[
          jsonEncode({'id': 1, 'total': 100}),
          jsonEncode({'id': 2, 'total': 200}),
          jsonEncode({'id': 3, 'total': 300}),
        ];

        final entries = <Map<String, String>>[];
        var prevHash = '';
        for (final inv in invoices) {
          final hash = HashChain.computeHash(prevHash, inv);
          entries.add({'hash': hash, 'json': inv});
          prevHash = hash;
        }

        // Tamper with entry #1 (index 1) — change the JSON
        entries[1] = {
          'hash': entries[1]['hash']!,
          'json': jsonEncode({'id': 2, 'total': 999}),
        };

        expect(HashChain.verifyChain(entries), 1);
      });

      test('empty chain returns -1', () {
        expect(HashChain.verifyChain([]), -1);
      });

      test('single valid entry returns -1', () {
        const json = '{"id": 1}';
        final hash = HashChain.computeHash('', json);
        expect(
          HashChain.verifyChain([{'hash': hash, 'json': json}]),
          -1,
        );
      });
    });
  });
}
