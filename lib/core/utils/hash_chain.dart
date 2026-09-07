import 'dart:convert';
import 'package:crypto/crypto.dart';

/// SHA-256 fiscal hash chaining for invoice tamper detection.
///
/// Each invoice's hash incorporates the previous invoice's hash,
/// creating an unbreakable chain. If any invoice in the chain is
/// tampered with, all subsequent hashes become invalid.
///
/// chain: hash(n) = SHA256(hash(n-1) + invoiceJson)
///
/// Required by MOR Directive Art. 4.2 for audit integrity.
class HashChain {
  const HashChain._();

  /// Compute the SHA-256 hash for a new invoice in the chain.
  ///
  /// [previousHash] - The hash of the previous invoice (empty string for the first invoice).
  /// [invoiceJson] - The JSON string representation of the current invoice.
  ///
  /// Returns the hex-encoded SHA-256 hash.
  static String computeHash(String previousHash, String invoiceJson) {
    final input = '$previousHash$invoiceJson';
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Verify that a hash in the chain is valid.
  ///
  /// Returns true if the hash matches the expected value for the given
  /// previous hash and invoice JSON.
  static bool verifyHash(String expectedHash, String previousHash, String invoiceJson) {
    final computed = computeHash(previousHash, invoiceJson);
    return computed == expectedHash;
  }

  /// Verify the integrity of an entire chain of invoices.
  ///
  /// Each entry is a map with 'hash' and 'json' keys.
  /// Returns the index of the first invalid entry, or -1 if the chain is valid.
  static int verifyChain(List<Map<String, String>> entries) {
    var previousHash = '';
    for (var i = 0; i < entries.length; i++) {
      final entry = entries[i];
      final hash = entry['hash'] ?? '';
      final json = entry['json'] ?? '';
      if (!verifyHash(hash, previousHash, json)) {
        return i;
      }
      previousHash = hash;
    }
    return -1;
  }
}
