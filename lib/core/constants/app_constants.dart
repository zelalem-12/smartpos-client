/// Application-wide constants.
class AppConstants {
  AppConstants._();

  static const String appName = 'SmartPOS';
  static const String appTagline = 'Sell Smarter. Stay Compliant.';
  static const String appVersion = '1.0.0';

  // Mock API base URL (will be replaced with real backend later)
  static const String apiBaseUrl = 'https://api.smartpos.et/v1';

  // License key format: MOR-XXXXXXXX (8 random alphanumeric chars)
  static const String licenseKeyPrefix = 'MOR-';
  static const int licenseKeyLength = 12; // MOR- + 8 chars
  static const String mockLicenseKey = 'MOR-4A9K2L8Q';

  // PIN configuration
  static const int pinLength = 4;

  // Sync queue
  static const int maxOfflineDays = 7;

  // Receipt
  static const String duplicateWatermark =
      '*** DUPLICATE COPY / \u12F5\u130B\u121A \u12E8\u1273\u1270\u1218 ***';
}
