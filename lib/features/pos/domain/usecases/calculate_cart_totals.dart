import '../entities/cart_entity.dart';

/// Calculates the tax-inclusive gross, net and VAT totals for a cart.
class CalculateCartTotals {
  const CalculateCartTotals();

  /// Returns a map with the Ethiopian 15% inclusive-VAT totals.
  ///
  /// Keys: `gross`, `net`, `vat`.
  Map<String, double> call(CartEntity cart) {
    return {
      'gross': cart.grossTotal,
      'net': cart.netTotal,
      'vat': cart.vatTotal,
    };
  }
}
