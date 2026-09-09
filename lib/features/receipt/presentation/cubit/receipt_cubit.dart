import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../pos/domain/usecases/clear_cart.dart';
import '../../domain/entities/receipt_data.dart';
import '../../domain/usecases/generate_receipt.dart';
import '../../domain/usecases/print_receipt.dart';
import 'receipt_state.dart';

/// Manages loading, previewing and printing a receipt for a completed sale.
class ReceiptCubit extends Cubit<ReceiptState> {
  final GenerateReceipt _generateReceipt;
  final PrintReceipt _printReceipt;
  final ClearCart _clearCart;

  ReceiptCubit({
    required this._generateReceipt,
    required this._printReceipt,
    required this._clearCart,
  }) : super(const ReceiptLoading());

  /// Loads the receipt for the supplied invoice ID.
  ///
  /// A null or negative [invoiceId] is treated as an invalid/missing ID.
  Future<void> load(int? invoiceId) async {
    if (invoiceId == null || invoiceId <= 0) {
      emit(
        ReceiptError(
          'Invalid or missing invoice ID. Please return to the POS and try again.',
          invoiceId: invoiceId,
        ),
      );
      return;
    }

    emit(const ReceiptLoading());

    try {
      final receipt = await _generateReceipt(invoiceId);
      emit(ReceiptReady(receipt));
    } on Failure catch (e) {
      emit(ReceiptError(e.message, invoiceId: invoiceId));
    } catch (e) {
      emit(ReceiptError('Failed to load receipt: $e', invoiceId: invoiceId));
    }
  }

  /// Prints the currently loaded receipt.
  ///
  /// [markAsDuplicate] adds the duplicate watermark to the output.
  Future<void> printReceipt({bool markAsDuplicate = false}) async {
    final receipt = _currentReceipt;
    if (receipt == null) return;

    emit(ReceiptPrinting(receipt, isDuplicate: markAsDuplicate));

    try {
      await _printReceipt(receipt, isDuplicate: markAsDuplicate);
      emit(ReceiptPrinted(receipt, isDuplicate: markAsDuplicate));
    } on Failure catch (e) {
      emit(ReceiptError(e.message, receipt: receipt));
    } catch (e) {
      emit(ReceiptError('Print failed: $e', receipt: receipt));
    }
  }

  /// Marks a receipt as a duplicate and reprints it.
  Future<void> reprint() => printReceipt(markAsDuplicate: true);

  /// Clears the cart so a new sale starts empty.
  Future<void> newSale() async {
    try {
      await _clearCart();
    } catch (_) {
      // Cart clear is best-effort; the POS will reload it anyway.
    }
  }

  ReceiptData? get _currentReceipt {
    final s = state;
    if (s is ReceiptReady) return s.receipt;
    if (s is ReceiptPrinting) return s.receipt;
    if (s is ReceiptPrinted) return s.receipt;
    if (s is ReceiptError) return s.receipt;
    return null;
  }
}
