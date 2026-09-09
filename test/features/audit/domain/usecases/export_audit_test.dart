import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/features/audit/domain/entities/audit_log_entry.dart';
import 'package:smartpos_client/features/audit/domain/repositories/audit_repository.dart';
import 'package:smartpos_client/features/audit/domain/repositories/directory_provider.dart';
import 'package:smartpos_client/features/audit/domain/usecases/export_audit_csv.dart';
import 'package:smartpos_client/features/audit/domain/usecases/export_audit_json.dart';

class MockAuditRepository extends Mock implements AuditRepository {}

class _TestDirectoryProvider implements DirectoryProvider {
  @override
  Future<Directory> getDirectory() async {
    return Directory.systemTemp.createTemp('audit_export_test');
  }
}

void main() {
  late MockAuditRepository repository;
  late DirectoryProvider directoryProvider;
  late Directory tempDir;

  final entry = AuditLogEntry(
    id: 1,
    action: 'INVOICE_CREATED',
    userId: 'csh-001',
    details: 'Invoice #1 created by csh-001',
    payload: '{"n":1}',
    previousHash: '',
    currentHash: 'firsthash',
    createdAt: DateTime(2025, 1, 1, 10, 30),
    integrityStatus: AuditIntegrityStatus.valid,
  );

  final tamperedEntry = AuditLogEntry(
    id: 2,
    action: 'CREDIT_NOTE_CREATED',
    userId: 'mgr-001',
    details: 'Note, with "quotes" and commas',
    payload: '{"n":2}',
    previousHash: 'firsthash',
    currentHash: 'bad',
    createdAt: DateTime(2025, 1, 1, 11, 0),
    integrityStatus: AuditIntegrityStatus.tampered,
  );

  setUp(() async {
    repository = MockAuditRepository();
    directoryProvider = _TestDirectoryProvider();
    tempDir = await directoryProvider.getDirectory();
  });

  tearDown(() async {
    if (await tempDir.exists()) await tempDir.delete(recursive: true);
  });

  group('ExportAuditCsv', () {
    test('writes timestamped CSV with escaped commas and quotes', () async {
      when(() => repository.verifyChain()).thenAnswer(
        (_) async => AuditChainResult(
          entries: [entry, tamperedEntry],
          isChainValid: false,
          firstBrokenId: tamperedEntry.id,
        ),
      );

      final path = await ExportAuditCsv(repository, directoryProvider)();

      expect(path, endsWith('.csv'));
      final file = File(path);
      expect(await file.exists(), isTrue);

      final content = await file.readAsString();
      expect(content, contains('integrityStatus'));
      expect(content, contains('INVOICE_CREATED'));
      expect(content, contains('CREDIT_NOTE_CREATED'));
      expect(content, contains('"Note, with ""quotes"" and commas"'));
    });

    test('escapes newlines in details', () async {
      final newlineEntry = AuditLogEntry(
        id: 3,
        action: 'TEST',
        userId: 'u',
        details: 'line1\nline2',
        payload: '{}',
        previousHash: 'firsthash',
        currentHash: 'bad',
        createdAt: DateTime(2025, 1, 1),
        integrityStatus: AuditIntegrityStatus.unverifiable,
      );
      when(() => repository.verifyChain()).thenAnswer(
        (_) async =>
            AuditChainResult(entries: [newlineEntry], isChainValid: false),
      );

      final path = await ExportAuditCsv(repository, directoryProvider)();
      final content = await File(path).readAsString();
      final lines = content.split('\r\n');
      expect(lines.length, greaterThanOrEqualTo(2));
      expect(content, contains('"line1\nline2"'));
    });
  });

  group('ExportAuditJson', () {
    test('writes parseable JSON with chain metadata', () async {
      when(() => repository.verifyChain()).thenAnswer(
        (_) async => AuditChainResult(entries: [entry], isChainValid: true),
      );

      final path = await ExportAuditJson(repository, directoryProvider)();

      expect(path, endsWith('.json'));
      final file = File(path);
      expect(await file.exists(), isTrue);

      final json =
          jsonDecode(await file.readAsString()) as Map<String, dynamic>;
      expect(json['chainValid'], isTrue);
      expect(json['firstBrokenId'], isNull);
      final entries = json['entries'] as List<dynamic>;
      expect(entries.length, 1);
      expect(entries.first['action'], 'INVOICE_CREATED');
      expect(entries.first['integrityStatus'], 'valid');
      expect(entries.first['payload'], '{"n":1}');
    });
  });
}
