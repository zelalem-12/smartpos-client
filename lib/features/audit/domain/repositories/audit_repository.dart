import '../entities/audit_log_entry.dart';

/// Repository for the tamper-evident audit trail.
abstract class AuditRepository {
  /// List all audit log entries newest first.
  Future<List<AuditLogEntry>> getAuditTrail();

  /// Verify the full audit chain oldest first.
  Future<AuditChainResult> verifyChain();
}
