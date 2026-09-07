/// String utility extensions.
extension StringExtensions on String {
  /// Check if the string is a valid TIN (exactly 10 digits).
  bool get isValidTin => RegExp(r'^\d{10}$').hasMatch(this);

  /// Check if the string is a valid 4-digit PIN.
  bool get isValidPin => RegExp(r'^\d{4}$').hasMatch(this);

  /// Check if this matches the license key format ACT-XXXXX.
  bool get isValidLicenseKey =>
      RegExp(r'^ACT-[A-Z0-9]{5}$', caseSensitive: false).hasMatch(this);
}
