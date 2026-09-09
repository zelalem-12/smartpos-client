import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/services/session_service.dart';
import '../../domain/entities/return_invoice.dart';
import '../../domain/usecases/credit_note_usecases.dart';

class CreditNoteState extends Equatable {
  final bool loading;
  final ReturnInvoice? invoice;
  final Map<int, double> quantities;
  final String? error;
  final CreditNoteResult? result;
  const CreditNoteState({
    this.loading = false,
    this.invoice,
    this.quantities = const {},
    this.error,
    this.result,
  });
  CreditNoteState copyWith({
    bool? loading,
    ReturnInvoice? invoice,
    Map<int, double>? quantities,
    String? error,
    CreditNoteResult? result,
    bool clearError = false,
  }) => CreditNoteState(
    loading: loading ?? this.loading,
    invoice: invoice ?? this.invoice,
    quantities: quantities ?? this.quantities,
    error: clearError ? null : error ?? this.error,
    result: result ?? this.result,
  );
  @override
  List<Object?> get props => [loading, invoice, quantities, error, result];
}

class CreditNoteCubit extends Cubit<CreditNoteState> {
  final FindReturnInvoice findInvoice;
  final CreateCreditNote createCreditNote;
  final SessionService session;
  CreditNoteCubit(this.findInvoice, this.createCreditNote, this.session)
    : super(const CreditNoteState());
  Future<void> search(String value) async {
    final number = int.tryParse(value);
    if (number == null) {
      emit(state.copyWith(error: 'Enter a valid invoice number'));
      return;
    }
    emit(const CreditNoteState(loading: true));
    try {
      emit(CreditNoteState(invoice: await findInvoice(number)));
    } catch (e) {
      emit(CreditNoteState(error: _message(e)));
    }
  }

  void setQuantity(int itemId, double quantity) {
    final map = Map<int, double>.from(state.quantities)..[itemId] = quantity;
    emit(state.copyWith(quantities: map, clearError: true));
  }

  Future<void> submit(String reason) async {
    if (!session.isManager) {
      emit(state.copyWith(error: 'Manager authorization required'));
      return;
    }
    final invoice = state.invoice;
    if (invoice == null) return;
    emit(state.copyWith(loading: true, clearError: true));
    try {
      final result = await createCreditNote(
        invoiceId: invoice.id,
        managerId: session.currentSession!.id,
        reason: reason,
        quantities: state.quantities,
      );
      emit(state.copyWith(loading: false, result: result));
    } catch (e) {
      emit(state.copyWith(loading: false, error: _message(e)));
    }
  }

  static String _message(Object e) =>
      e is Failure ? e.message : 'Unable to complete credit note';
}
