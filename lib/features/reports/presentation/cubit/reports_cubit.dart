import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/phase9_requests.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/services/session_service.dart';
import '../../domain/usecases/report_usecases.dart';

class ReportsState extends Equatable {
  final bool loading;
  final ReportTotals? totals;
  final String? error;
  final int? zNumber;
  const ReportsState({
    this.loading = false,
    this.totals,
    this.error,
    this.zNumber,
  });
  @override
  List<Object?> get props => [loading, totals, error, zNumber];
}

class ReportsCubit extends Cubit<ReportsState> {
  final GenerateXReport generateX;
  final CloseZReport closeZ;
  final SessionService session;
  ReportsCubit(this.generateX, this.closeZ, this.session)
    : super(const ReportsState());
  Future<void> load([DateTime? date]) async {
    emit(const ReportsState(loading: true));
    try {
      emit(ReportsState(totals: await generateX(date ?? DateTime.now())));
    } catch (e) {
      emit(ReportsState(error: _message(e)));
    }
  }

  Future<void> closeDay(String cashCount) async {
    if (!session.isManager) {
      emit(
        ReportsState(
          totals: state.totals,
          error: 'Manager authorization required',
        ),
      );
      return;
    }
    final amount = double.tryParse(cashCount);
    if (amount == null || amount < 0) {
      emit(
        ReportsState(totals: state.totals, error: 'Enter a valid cash count'),
      );
      return;
    }
    final totals = state.totals;
    if (totals == null) return;
    emit(ReportsState(loading: true, totals: totals));
    try {
      final number = await closeZ(
        date: totals.date,
        managerId: session.currentSession!.id,
        cashCount: amount,
      );
      emit(ReportsState(totals: totals, zNumber: number));
    } catch (e) {
      emit(ReportsState(totals: totals, error: _message(e)));
    }
  }

  static String _message(Object e) =>
      e is Failure ? e.message : 'Unable to generate report';
}
