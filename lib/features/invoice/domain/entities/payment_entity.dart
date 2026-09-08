import 'package:equatable/equatable.dart';

import 'payment_method.dart';

/// Domain representation of the payment recorded for an invoice.
class PaymentEntity extends Equatable {
  final PaymentMethod method;
  final double amount;
  final double? cashTendered;
  final String? referenceCode;

  const PaymentEntity({
    required this.method,
    required this.amount,
    this.cashTendered,
    this.referenceCode,
  });

  /// Change due when cash tendered exceeds the amount.
  double? get change => method == PaymentMethod.cash && cashTendered != null
      ? cashTendered! - amount
      : null;

  @override
  List<Object?> get props => [method, amount, cashTendered, referenceCode];
}
