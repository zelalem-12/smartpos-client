import 'package:flutter_test/flutter_test.dart';
import 'package:smartpos_client/core/utils/currency_formatter.dart';

void main() {
  group('CurrencyFormatter', () {
    group('format', () {
      test('formats 1234.50 as "1,234.50 ETB"', () {
        expect(CurrencyFormatter.format(1234.5), '1,234.50 ETB');
      });

      test('formats 0 as "0.00 ETB"', () {
        expect(CurrencyFormatter.format(0), '0.00 ETB');
      });

      test('formats large number with comma separators', () {
        expect(CurrencyFormatter.format(1000000.0), '1,000,000.00 ETB');
      });

      test('formats small decimal correctly', () {
        expect(CurrencyFormatter.format(0.50), '0.50 ETB');
      });

      test('formats typical POS total', () {
        expect(CurrencyFormatter.format(540.0), '540.00 ETB');
      });
    });

    group('formatNumber', () {
      test('formats without ETB suffix', () {
        expect(CurrencyFormatter.formatNumber(1234.5), '1,234.50');
      });
    });

    group('formatCompact', () {
      test('formats without comma separators', () {
        expect(CurrencyFormatter.formatCompact(1234.5), '1234.50');
      });

      test('formats zero', () {
        expect(CurrencyFormatter.formatCompact(0.0), '0.00');
      });
    });
  });
}
