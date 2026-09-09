/// API endpoint constants.
class ApiEndpoints {
  ApiEndpoints._();

  static const String activateDevice = '/devices/activate';
  static const String syncInvoices = '/invoices/sync';
  static const String sync = '/sync';
  static const String catalogSync = '/catalog/sync';
  static const String usersSync = '/users/sync';
  static const String dailySummary = '/reports/daily-summary';
  static const String submitCancellation = '/invoices/cancel';
  static const String submitCreditNote = '/credit-notes';
}
