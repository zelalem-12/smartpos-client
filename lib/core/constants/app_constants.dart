/// Application-wide constants.
class AppConstants {
  AppConstants._();

  static const String appName = 'SmartPOS Ethiopia';
  static const String appVersion = '1.0.0';

  // Mock API base URL (will be replaced with real backend later)
  static const String apiBaseUrl = 'https://api.smartpos.et/v1';

  // License key format: ACT-XXXXX (letters/digits)
  static const String licenseKeyPrefix = 'ACT-';
  static const int licenseKeyLength = 9; // ACT-XXXXX

  // PIN configuration
  static const int pinLength = 4;

  // Sync queue
  static const int maxOfflineDays = 7;

  // Receipt
  static const String duplicateWatermark = '*** DUPLICATE COPY / \u12F5\u130B\u121A \u12E8\u1273\u1270\u1218 ***';
}
