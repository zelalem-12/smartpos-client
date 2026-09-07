import 'package:flutter_test/flutter_test.dart';
import 'package:smartpos_client/core/utils/vat_calculator.dart';

void main() {
  group('VatCalculator', () {
    group('grossToNet', () {
      test('extracts net from 100.00 ETB gross at 15%', () {
        expect(VatCalculator.grossToNet(100.0), closeTo(86.96, 0.01));
      });

      test('extracts net from 80.00 ETB (espresso price)', () {
        expect(VatCalculator.grossToNet(80.0), closeTo(69.57, 0.01));
      });

      test('extracts net from 540.00 ETB (typical cart total)', () {
        expect(VatCalculator.grossToNet(540.0), closeTo(469.57, 0.01));
      });

      test('returns 0 for zero amount', () {
        expect(VatCalculator.grossToNet(0.0), 0.0);
      });

      test('returns 0 for negative amount', () {
        expect(VatCalculator.grossToNet(-50.0), 0.0);
      });

      test('handles very small amount (1 ETB)', () {
        final net = VatCalculator.grossToNet(1.0);
        expect(net, closeTo(0.87, 0.01));
      });

      test('handles large amount (100,000 ETB)', () {
        final net = VatCalculator.grossToNet(100000.0);
        expect(net, closeTo(86956.52, 0.01));
      });
    });

    group('grossToVat', () {
      test('extracts VAT from 100.00 ETB gross at 15%', () {
        expect(VatCalculator.grossToVat(100.0), closeTo(13.04, 0.01));
      });

      test('extracts VAT from 540.00 ETB cart total', () {
        expect(VatCalculator.grossToVat(540.0), closeTo(70.43, 0.01));
      });

      test('returns 0 for zero amount', () {
        expect(VatCalculator.grossToVat(0.0), 0.0);
      });

      test('returns 0 for negative amount', () {
        expect(VatCalculator.grossToVat(-50.0), 0.0);
      });

      test('net + vat equals gross', () {
        const gross = 480.0;
        final net = VatCalculator.grossToNet(gross);
        final vat = VatCalculator.grossToVat(gross);
        expect(net + vat, closeTo(gross, 0.01));
      });
    });

    group('netToGross', () {
      test('calculates gross from net at 15%', () {
        expect(VatCalculator.netToGross(86.96), closeTo(100.0, 0.01));
      });

      test('returns 0 for zero amount', () {
        expect(VatCalculator.netToGross(0.0), 0.0);
      });

      test('returns 0 for negative amount', () {
        expect(VatCalculator.netToGross(-50.0), 0.0);
      });
    });
  });
}
