import 'package:equatable/equatable.dart';

import '../../../pos/domain/entities/cart_entity.dart';
import '../../domain/entities/payment_method.dart';

/// Base class for checkout states.
sealed class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object?> get props => [];
}

/// Checkout form is displayed with the current cart and payment options.
class CheckoutLoaded extends CheckoutState {
  final CartEntity cart;
  final PaymentMethod paymentMethod;
  final String cashTendered;
  final String buyerTin;
  final bool isProcessing;
  final String? errorMessage;

  const CheckoutLoaded({
    required this.cart,
    this.paymentMethod = PaymentMethod.cash,
    this.cashTendered = '',
    this.buyerTin = '',
    this.isProcessing = false,
    this.errorMessage,
  });

  double get total => cart.grossTotal;

  double get parsedTendered => double.tryParse(cashTendered) ?? 0.0;

  double get change => paymentMethod.isCash ? parsedTendered - total : 0.0;

  bool get hasChange => paymentMethod.isCash && change > 0;

  CheckoutLoaded copyWith({
    CartEntity? cart,
    PaymentMethod? paymentMethod,
    String? cashTendered,
    String? buyerTin,
    bool? isProcessing,
    String? errorMessage,
  }) {
    return CheckoutLoaded(
      cart: cart ?? this.cart,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      cashTendered: cashTendered ?? this.cashTendered,
      buyerTin: buyerTin ?? this.buyerTin,
      isProcessing: isProcessing ?? this.isProcessing,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    cart,
    paymentMethod,
    cashTendered,
    buyerTin,
    isProcessing,
    errorMessage,
  ];
}

/// Checkout completed successfully; the invoice is ready to be printed.
class CheckoutCompleted extends CheckoutState {
  final String invoiceId;

  const CheckoutCompleted(this.invoiceId);

  @override
  List<Object?> get props => [invoiceId];
}
