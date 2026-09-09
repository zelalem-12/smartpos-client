import 'dart:io';

import '../repositories/audit_repository.dart';
import '../repositories/directory_provider.dart';

/// Exports the verified audit trail as a properly escaped CSV file.
class ExportAuditCsv {
  final AuditRepository repository;
  final DirectoryProvider directoryProvider;

  const ExportAuditCsv(this.repository, this.directoryProvider);

  Future<String> call() async {
    final result = await repository.verifyChain();
    final rows = result.entries;
    final dir = await directoryProvider.getDirectory();
    final timestamp = _timestamp();
    final file = File('${dir.path}/audit_export_$timestamp.csv');

    final header = const [
      'id',
      'action',
      'invoiceId',
      'userId',
      'details',
      'payload',
      'previousHash',
      'currentHash',
      'createdAt',
      'integrityStatus',
    ].map(_escape).join(',');

    final lines = [header];
    for (final row in rows) {
      lines.add(
        [
          row.id.toString(),
          row.action,
          row.invoiceId?.toString() ?? '',
          row.userId,
          row.details,
          row.payload ?? '',
          row.previousHash,
          row.currentHash,
          row.createdAt.toIso8601String(),
          row.integrityStatus.name,
        ].map(_escape).join(','),
      );
    }

    await file.writeAsString(lines.join('\r\n'));
    return file.path;
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

  /// Escapes a field per RFC 4180: wrap in double quotes and double any
  /// embedded double quotes; also force quotes when the value contains a
  /// comma, newline, or carriage return.
  static String _escape(String value) {
    final needsQuotes =
        value.contains(',') ||
        value.contains('"') ||
        value.contains('\n') ||
        value.contains('\r');
    final escaped = value.replaceAll('"', '""');
    return needsQuotes ? '"$escaped"' : escaped;
  }
}
