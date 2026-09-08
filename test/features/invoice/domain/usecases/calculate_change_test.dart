import 'package:flutter_test/flutter_test.dart';
import 'package:smartpos_client/features/invoice/domain/usecases/calculate_change.dart';

void main() {
  const calculateChange = CalculateChange();

  group('CalculateChange', () {
    test('returns change when cash tendered exceeds total', () {
      expect(calculateChange(100.0, 150.0), 50.0);
    });

    test('returns zero when cash tendered equals total', () {
      expect(calculateChange(100.0, 100.0), 0.0);
    });

    test('returns zero when cash tendered is less than total', () {
      expect(calculateChange(100.0, 80.0), 0.0);
    });

    test('returns zero for zero total', () {
      expect(calculateChange(0.0, 0.0), 0.0);
    });
  });
}
