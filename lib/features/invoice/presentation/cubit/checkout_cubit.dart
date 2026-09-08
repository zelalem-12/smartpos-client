import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/tax_constants.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/services/session_service.dart';
import '../../../pos/domain/usecases/clear_cart.dart';
import '../../../pos/domain/usecases/get_cart.dart';
import '../../domain/entities/payment_method.dart';
import '../../domain/usecases/create_invoice.dart';
import 'checkout_state.dart';

/// Manages the checkout / invoice-creation screen.
class CheckoutCubit extends Cubit<CheckoutState> {
  final GetCart _getCart;
  final CreateInvoice _createInvoice;
  final ClearCart _clearCart;
  final SessionService _session;

  CheckoutCubit({
    required this._getCart,
    required this._createInvoice,
    required this._clearCart,
    required this._session,
  }) : super(CheckoutLoaded(cart: _getCart()));

  /// Reloads the cart (useful when the page is rebuilt or returned to).
  void refreshCart() {
    final current = state;
    if (current is CheckoutLoaded && !current.isProcessing) {
      emit(current.copyWith(cart: _getCart(), errorMessage: null));
    }
  }

  /// Changes the selected payment method.
  void selectPaymentMethod(PaymentMethod method) {
    final current = state;
    if (current is! CheckoutLoaded || current.isProcessing) return;
    emit(
      current.copyWith(
        paymentMethod: method,
        cashTendered: method.isCash ? current.cashTendered : '',
        errorMessage: null,
      ),
    );
  }

  /// Updates the amount of cash tendered by the buyer.
  void updateCashTendered(String value) {
    final current = state;
    if (current is! CheckoutLoaded || current.isProcessing) return;
    emit(current.copyWith(cashTendered: value, errorMessage: null));
  }

  /// Updates the optional buyer TIN.
  void updateBuyerTin(String value) {
    final current = state;
    if (current is! CheckoutLoaded || current.isProcessing) return;
    emit(current.copyWith(buyerTin: value, errorMessage: null));
  }

  /// Validates the checkout form and creates the invoice if valid.
  Future<void> confirmCheckout() async {
    final current = state;
    if (current is! CheckoutLoaded || current.isProcessing) return;

    final error = _validate(current);
    if (error != null) {
      emit(current.copyWith(errorMessage: error));
      return;
    }

    final session = _session.currentSession;
    if (session == null) {
      emit(current.copyWith(errorMessage: 'No active cashier session'));
      return;
    }

    emit(current.copyWith(isProcessing: true, errorMessage: null));

    try {
      final invoice = await _createInvoice(
        cart: current.cart,
        paymentMethod: current.paymentMethod,
        cashierId: session.id,
        cashTendered: current.paymentMethod.isCash
            ? current.parsedTendered
            : null,
        buyerTin: current.buyerTin.isEmpty ? null : current.buyerTin,
      );

      // Cart must only be cleared after a successful atomic invoice creation.
      await _clearCart();
      emit(CheckoutCompleted(invoice.id));
    } on Failure catch (e) {
      emit(current.copyWith(isProcessing: false, errorMessage: e.message));
    } catch (e) {
      emit(
        current.copyWith(
          isProcessing: false,
          errorMessage: 'Checkout failed: $e',
        ),
      );
    }
  }

  String? _validate(CheckoutLoaded state) {
    if (state.cart.isEmpty) return 'Cart is empty';

    if (state.paymentMethod.isCash) {
      final tendered = state.parsedTendered;
      if (tendered < state.total) {
        return 'Cash tendered must be at least ${state.total.toStringAsFixed(2)} ETB';
      }
    }

    if (state.buyerTin.isNotEmpty &&
        (!RegExp(r'^[0-9]+$').hasMatch(state.buyerTin) ||
            state.buyerTin.length != TaxConstants.tinLength)) {
      return 'Buyer TIN must be exactly ${TaxConstants.tinLength} digits';
    }

    return null;
  }
}
