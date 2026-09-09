import 'package:equatable/equatable.dart';

/// Integrity status of an individual audit entry.
enum AuditIntegrityStatus { valid, unverifiable, tampered }

/// Domain representation of an audit log entry with its verification status.
class AuditLogEntry extends Equatable {
  final int id;
  final String action;
  final int? invoiceId;
  final String userId;
  final String details;
  final String? payload;
  final String previousHash;
  final String currentHash;
  final DateTime createdAt;
  final AuditIntegrityStatus integrityStatus;

  const AuditLogEntry({
    required this.id,
    required this.action,
    this.invoiceId,
    required this.userId,
    required this.details,
    this.payload,
    required this.previousHash,
    required this.currentHash,
    required this.createdAt,
    required this.integrityStatus,
  });

  bool get isValid => integrityStatus == AuditIntegrityStatus.valid;
  bool get isTampered => integrityStatus == AuditIntegrityStatus.tampered;
  bool get isUnverifiable =>
      integrityStatus == AuditIntegrityStatus.unverifiable;

  @override
  List<Object?> get props => [
    id,
    action,
    invoiceId,
    userId,
    details,
    payload,
    previousHash,
    currentHash,
    createdAt,
    integrityStatus,
  ];
}

/// Result of verifying the full audit chain.
class AuditChainResult extends Equatable {
  final List<AuditLogEntry> entries;
  final bool isChainValid;
  final int? firstBrokenId;

  const AuditChainResult({
    required this.entries,
    required this.isChainValid,
    this.firstBrokenId,
  });

  @override
  List<Object?> get props => [entries, isChainValid, firstBrokenId];
}
