import 'package:intl/intl.dart';

import '../constants/app_constants.dart';

/// Ethiopian Birr currency formatting.
class CurrencyFormatter {
  const CurrencyFormatter._();

  static final _formatter = NumberFormat('#,##0.00', 'en_US');

  /// Format a number as Ethiopian Birr: "1,234.50 ETB"
  static String format(double amount) {
    return '${_formatter.format(amount)} ${AppConstants.currencyCode}';
  }

  /// Format without currency suffix: "1,234.50"
  static String formatNumber(double amount) {
    return _formatter.format(amount);
  }

  /// Format for compact display (e.g. receipt lines): "1234.50"
  static String formatCompact(double amount) {
    return amount.toStringAsFixed(2);
  }
}
