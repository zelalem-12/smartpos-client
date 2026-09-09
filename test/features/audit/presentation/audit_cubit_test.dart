import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/features/audit/domain/entities/audit_log_entry.dart';
import 'package:smartpos_client/features/audit/domain/repositories/audit_repository.dart';
import 'package:smartpos_client/features/audit/domain/repositories/directory_provider.dart';
import 'package:smartpos_client/features/audit/domain/usecases/export_audit_csv.dart';
import 'package:smartpos_client/features/audit/domain/usecases/export_audit_json.dart';
import 'package:smartpos_client/features/audit/domain/usecases/get_audit_trail.dart';
import 'package:smartpos_client/features/audit/presentation/cubit/audit_cubit.dart';
import 'package:smartpos_client/features/audit/presentation/cubit/audit_state.dart';

class MockAuditRepository extends Mock implements AuditRepository {}

class _TestDirectoryProvider implements DirectoryProvider {
  @override
  Future<Directory> getDirectory() async {
    return Directory.systemTemp.createTemp('audit_test');
  }
}

void main() {
  late MockAuditRepository repository;
  late DirectoryProvider directoryProvider;
  late AuditCubit cubit;

  final entry = AuditLogEntry(
    id: 1,
    action: 'INVOICE_CREATED',
    userId: 'csh-001',
    details: 'Invoice #1',
    payload: '{"n":1}',
    previousHash: '',
    currentHash: 'abc123',
    createdAt: DateTime(2025, 1, 1),
    integrityStatus: AuditIntegrityStatus.valid,
  );

  setUp(() {
    repository = MockAuditRepository();
    directoryProvider = _TestDirectoryProvider();

    when(() => repository.verifyChain()).thenAnswer(
      (_) async => AuditChainResult(entries: [entry], isChainValid: true),
    );

    cubit = AuditCubit(
      verifyAuditChain: VerifyAuditChain(repository),
      exportCsv: ExportAuditCsv(repository, directoryProvider),
      exportJson: ExportAuditJson(repository, directoryProvider),
    );
  });

  blocTest<AuditCubit, AuditState>(
    'load emits entries and valid chain',
    build: () => cubit,
    act: (c) => c.load(),
    expect: () => [
      isA<AuditState>().having((s) => s.loading, 'loading', isTrue),
      isA<AuditState>()
          .having((s) => s.loading, 'loading', isFalse)
          .having((s) => s.entries.length, 'entries', 1)
          .having((s) => s.chainValid, 'chainValid', isTrue),
    ],
  );

  blocTest<AuditCubit, AuditState>(
    'selectEntry updates selected entry',
    build: () => cubit,
    act: (c) => c.selectEntry(entry),
    expect: () => [
      isA<AuditState>().having((s) => s.selectedEntry, 'selected', entry),
    ],
  );

  blocTest<AuditCubit, AuditState>(
    'exportCsv emits exported path',
    setUp: () {
      when(() => repository.verifyChain()).thenAnswer(
        (_) async => AuditChainResult(entries: [entry], isChainValid: true),
      );
    },
    build: () => cubit,
    act: (c) => c.exportCsv(),
    verify: (c) {
      expect(c.state.exportPath, isNotNull);
      expect(c.state.exportPath, endsWith('.csv'));
    },
  );

  blocTest<AuditCubit, AuditState>(
    'exportJson emits exported path',
    setUp: () {
      when(() => repository.verifyChain()).thenAnswer(
        (_) async => AuditChainResult(entries: [entry], isChainValid: true),
      );
    },
    build: () => cubit,
    act: (c) => c.exportJson(),
    verify: (c) {
      expect(c.state.exportPath, isNotNull);
      expect(c.state.exportPath, endsWith('.json'));
    },
  );

  blocTest<AuditCubit, AuditState>(
    'clearSelection removes selected entry and export path',
    build: () => cubit,
    seed: () => AuditState(selectedEntry: entry, exportPath: '/tmp/x.csv'),
    act: (c) => c.clearSelection(),
    expect: () => [
      isA<AuditState>()
          .having((s) => s.selectedEntry, 'selected', isNull)
          .having((s) => s.exportPath, 'path', isNull)
          .having((s) => s.exportError, 'error', isNull),
    ],
  );
}
