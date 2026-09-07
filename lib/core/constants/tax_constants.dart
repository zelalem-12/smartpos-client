/// Ethiopian tax constants per VAT Regulation No. 570/2024.
class TaxConstants {
  TaxConstants._();

  /// Standard Ethiopian VAT rate: 15%
  static const double vatRate = 0.15;

  /// TIN (Taxpayer Identification Number) must be exactly 10 digits.
  static const int tinLength = 10;

  /// VAT Registration Number length (typically 9 digits).
  static const int vatRegNoLength = 9;
}
