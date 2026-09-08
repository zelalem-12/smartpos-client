/// Supported payment methods for a POS sale.
enum PaymentMethod {
  cash,
  telebirr,
  cbeBirr;

  /// Human-readable label shown on buttons and selectors.
  String get label {
    switch (this) {
      case PaymentMethod.cash:
        return 'Cash';
      case PaymentMethod.telebirr:
        return 'Telebirr';
      case PaymentMethod.cbeBirr:
        return 'CBE Birr';
    }
  }

  /// Whether this is an electronic / cashless method.
  bool get isElectronic => this != PaymentMethod.cash;

  /// Whether the cashier must collect and tender physical cash.
  bool get isCash => this == PaymentMethod.cash;
}
