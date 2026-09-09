import 'dart:convert';
import 'dart:io';

import '../entities/audit_log_entry.dart';
import '../repositories/audit_repository.dart';
import '../repositories/directory_provider.dart';

/// Exports the verified audit trail as structured, parseable JSON.
class ExportAuditJson {
  final AuditRepository repository;
  final DirectoryProvider directoryProvider;

  const ExportAuditJson(this.repository, this.directoryProvider);

  Future<String> call() async {
    final result = await repository.verifyChain();
    final dir = await directoryProvider.getDirectory();
    final timestamp = _timestamp();
    final file = File('${dir.path}/audit_export_$timestamp.json');

    final export = <String, dynamic>{
      'exportedAt': DateTime.now().toIso8601String(),
      'chainValid': result.isChainValid,
      'firstBrokenId': result.firstBrokenId,
      'entries': result.entries.map((e) => _mapEntry(e)).toList(),
    };

    await file.writeAsString(
      const JsonEncoder.withIndent('  ').convert(export),
    );
    return file.path;
  }

  static Map<String, dynamic> _mapEntry(AuditLogEntry e) {
    return {
      'id': e.id,
      'action': e.action,
      'invoiceId': e.invoiceId,
      'userId': e.userId,
      'details': e.details,
      'payload': e.payload,
      'previousHash': e.previousHash,
      'currentHash': e.currentHash,
      'createdAt': e.createdAt.toIso8601String(),
      'integrityStatus': e.integrityStatus.name,
    };
  }

  static String _timestamp() {
    final now = DateTime.now();
    return '${now.year.toString().padLeft(4, '0')}'
        '${now.month.toString().padLeft(2, '0')}'
        '${now.day.toString().padLeft(2, '0')}_'
        '${now.hour.toString().padLeft(2, '0')}'
        '${now.minute.toString().padLeft(2, '0')}'
        '${now.second.toString().padLeft(2, '0')}';
  }
}
