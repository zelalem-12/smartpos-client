import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/services/session_service.dart';
import '../../../credit_notes/domain/entities/return_invoice.dart';
import '../../domain/usecases/cancellation_usecases.dart';

class CancellationState extends Equatable {
  final bool loading;
  final ReturnInvoice? invoice;
  final String? error;
  final bool success;
  const CancellationState({
    this.loading = false,
    this.invoice,
    this.error,
    this.success = false,
  });
  @override
  List<Object?> get props => [loading, invoice, error, success];
}

class CancellationCubit extends Cubit<CancellationState> {
  final FindCancellationInvoice findInvoice;
  final RequestCancellation requestCancellation;
  final SessionService session;
  CancellationCubit(this.findInvoice, this.requestCancellation, this.session)
    : super(const CancellationState());
  Future<void> search(String value) async {
    final n = int.tryParse(value);
    if (n == null) {
      emit(const CancellationState(error: 'Enter a valid invoice number'));
      return;
    }
    emit(const CancellationState(loading: true));
    try {
      emit(CancellationState(invoice: await findInvoice(n)));
    } catch (e) {
      emit(CancellationState(error: _message(e)));
    }
  }

  Future<void> submit(String reason) async {
    if (!session.isManager) {
      emit(
        CancellationState(
          invoice: state.invoice,
          error: 'Manager authorization required',
        ),
      );
      return;
    }
    final i = state.invoice;
    if (i == null) return;
    emit(CancellationState(loading: true, invoice: i));
    try {
      await requestCancellation(
        invoiceId: i.id,
        managerId: session.currentSession!.id,
        reason: reason,
      );
      emit(CancellationState(invoice: i, success: true));
    } catch (e) {
      emit(CancellationState(invoice: i, error: _message(e)));
    }
  }

  static String _message(Object e) =>
      e is Failure ? e.message : 'Unable to request cancellation';
}
