import '../entities/audit_log_entry.dart';
import '../repositories/audit_repository.dart';

/// Loads the full audit trail newest first.
class GetAuditTrail {
  final AuditRepository repository;
  const GetAuditTrail(this.repository);

  Future<List<AuditLogEntry>> call() => repository.getAuditTrail();
}

/// Verifies the full audit chain oldest first and returns each entry's status.
class VerifyAuditChain {
  final AuditRepository repository;
  const VerifyAuditChain(this.repository);

  Future<AuditChainResult> call() => repository.verifyChain();
}
