import 'package:equatable/equatable.dart';

import '../../domain/entities/audit_log_entry.dart';

/// UI state for the audit trail page.
class AuditState extends Equatable {
  final bool loading;
  final List<AuditLogEntry> entries;
  final bool chainValid;
  final int? firstBrokenId;
  final String? exportPath;
  final String? exportError;
  final AuditLogEntry? selectedEntry;

  const AuditState({
    this.loading = false,
    this.entries = const [],
    this.chainValid = true,
    this.firstBrokenId,
    this.exportPath,
    this.exportError,
    this.selectedEntry,
  });

  bool get hasTamperedEntry =>
      entries.any((e) => e.integrityStatus == AuditIntegrityStatus.tampered);

  bool get hasUnverifiableEntry => entries.any(
    (e) => e.integrityStatus == AuditIntegrityStatus.unverifiable,
  );

  AuditState copyWith({
    bool? loading,
    List<AuditLogEntry>? entries,
    bool? chainValid,
    int? firstBrokenId,
    String? exportPath,
    String? exportError,
    AuditLogEntry? selectedEntry,
  }) {
    return AuditState(
      loading: loading ?? this.loading,
      entries: entries ?? this.entries,
      chainValid: chainValid ?? this.chainValid,
      firstBrokenId: firstBrokenId,
      exportPath: exportPath,
      exportError: exportError,
      selectedEntry: selectedEntry,
    );
  }

  @override
  List<Object?> get props => [
    loading,
    entries,
    chainValid,
    firstBrokenId,
    exportPath,
    exportError,
    selectedEntry,
  ];
}
