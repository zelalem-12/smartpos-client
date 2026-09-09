import '../../../../core/database/app_database.dart';
import '../../../../core/utils/hash_chain.dart';
import '../../domain/entities/audit_log_entry.dart';
import '../../domain/repositories/audit_repository.dart';

class AuditRepositoryImpl implements AuditRepository {
  final AppDatabase _db;

  AuditRepositoryImpl(this._db);

  @override
  Future<List<AuditLogEntry>> getAuditTrail() async {
    final rows = await _db.getAllAuditLogs(newestFirst: true);
    return rows.map(_toEntry).toList();
  }

  @override
  Future<AuditChainResult> verifyChain() async {
    final rows = await _db.getAllAuditLogs(newestFirst: false);
    final entries = <AuditLogEntry>[];
    var priorHash = '';
    int? firstBrokenId;

    for (final row in rows) {
      final status = _verifyEntry(row, priorHash);
      final entry = _toEntry(row, status: status);
      entries.add(entry);

      if (firstBrokenId == null && status != AuditIntegrityStatus.valid) {
        firstBrokenId = row.id;
      }

      priorHash = row.currentHash;
    }

    return AuditChainResult(
      entries: entries.reversed.toList(),
      isChainValid: firstBrokenId == null,
      firstBrokenId: firstBrokenId,
    );
  }

  static AuditLogEntry _toEntry(AuditLog row, {AuditIntegrityStatus? status}) {
    return AuditLogEntry(
      id: row.id,
      action: row.action,
      invoiceId: row.invoiceId,
      userId: row.userId,
      details: row.details,
      payload: row.payload,
      previousHash: row.previousHash,
      currentHash: row.currentHash,
      createdAt: row.createdAt,
      integrityStatus: status ?? AuditIntegrityStatus.valid,
    );
  }

  static AuditIntegrityStatus _verifyEntry(
    AuditLog row,
    String expectedPreviousHash,
  ) {
    if (row.previousHash != expectedPreviousHash) {
      return AuditIntegrityStatus.tampered;
    }

    final payload = row.payload;
    if (payload == null || payload.isEmpty) {
      // Legacy rows created before payload persistence cannot be verified.
      return AuditIntegrityStatus.unverifiable;
    }

    final computed = HashChain.computeHash(row.previousHash, payload);
    if (computed != row.currentHash) {
      return AuditIntegrityStatus.tampered;
    }

    return AuditIntegrityStatus.valid;
  }
}
