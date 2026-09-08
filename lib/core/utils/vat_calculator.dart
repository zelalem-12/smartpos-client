import '../constants/tax_constants.dart';

/// Ethiopian VAT calculation engine.
///
/// All prices in SmartPOS are **tax-inclusive** (gross amounts).
/// The standard Ethiopian VAT rate is 15% per Regulation No. 570/2024.
///
/// Formula:
///   net = gross / (1 + rate)
///   vat = gross - net
///
/// Example: gross = 100.00 ETB
///   net = 100.00 / 1.15 = 86.96 ETB
///   vat = 100.00 - 86.96 = 13.04 ETB
class VatCalculator {
  const VatCalculator._();

  /// Extract the net (before-tax) amount from a gross (tax-inclusive) amount.
  ///
  /// Uses the standard 15% VAT rate. Result is rounded to 2 decimal places.
  static double grossToNet(
    double grossAmount, {
    double rate = TaxConstants.vatRate,
  }) {
    if (grossAmount <= 0) return 0.0;
    final net = grossAmount / (1 + rate);
    return _round2(net);
  }

  /// Extract the VAT portion from a gross (tax-inclusive) amount.
  ///
  /// vat = gross - net
  static double grossToVat(
    double grossAmount, {
    double rate = TaxConstants.vatRate,
  }) {
    if (grossAmount <= 0) return 0.0;
    final net = grossToNet(grossAmount, rate: rate);
    return _round2(grossAmount - net);
  }

  /// Calculate the gross amount from a net amount (add VAT on top).
  ///
  /// gross = net * (1 + rate)
  static double netToGross(
    double netAmount, {
    double rate = TaxConstants.vatRate,
  }) {
    if (netAmount <= 0) return 0.0;
    return _round2(netAmount * (1 + rate));
  }

  /// Round to 2 decimal places (Ethiopian Santim precision).
  static double _round2(double value) {
    return (value * 100).roundToDouble() / 100;
  }
}
