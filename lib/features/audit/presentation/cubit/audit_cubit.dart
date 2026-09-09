import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/audit_log_entry.dart';
import '../../domain/usecases/export_audit_csv.dart';
import '../../domain/usecases/export_audit_json.dart';
import '../../domain/usecases/get_audit_trail.dart';
import 'audit_state.dart';

class AuditCubit extends Cubit<AuditState> {
  final VerifyAuditChain _verifyAuditChain;
  final ExportAuditCsv _exportCsv;
  final ExportAuditJson _exportJson;

  AuditCubit({
    required this._verifyAuditChain,
    required this._exportCsv,
    required this._exportJson,
  }) : super(const AuditState());

  Future<void> load() async {
    emit(state.copyWith(loading: true, exportPath: null, exportError: null));
    try {
      final result = await _verifyAuditChain();
      emit(
        state.copyWith(
          loading: false,
          entries: result.entries,
          chainValid: result.isChainValid,
          firstBrokenId: result.firstBrokenId,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loading: false,
          exportError: 'Failed to load audit trail: $e',
        ),
      );
    }
  }

  Future<void> refresh() => load();

  void selectEntry(AuditLogEntry? entry) {
    emit(state.copyWith(selectedEntry: entry));
  }

  Future<void> exportCsv() async {
    emit(state.copyWith(loading: true, exportPath: null, exportError: null));
    try {
      final path = await _exportCsv();
      emit(state.copyWith(loading: false, exportPath: path));
    } catch (e) {
      emit(state.copyWith(loading: false, exportError: e.toString()));
    }
  }

  Future<void> exportJson() async {
    emit(state.copyWith(loading: true, exportPath: null, exportError: null));
    try {
      final path = await _exportJson();
      emit(state.copyWith(loading: false, exportPath: path));
    } catch (e) {
      emit(state.copyWith(loading: false, exportError: e.toString()));
    }
  }

  void clearSelection() {
    emit(
      state.copyWith(selectedEntry: null, exportPath: null, exportError: null),
    );
  }
}
