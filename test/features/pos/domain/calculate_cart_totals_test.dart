import 'package:flutter_test/flutter_test.dart';
import 'package:smartpos_client/features/catalog/domain/entities/product_entity.dart';
import 'package:smartpos_client/features/pos/domain/entities/cart_entity.dart';
import 'package:smartpos_client/features/pos/domain/entities/cart_item_entity.dart';
import 'package:smartpos_client/features/pos/domain/usecases/calculate_cart_totals.dart';

void main() {
  group('CalculateCartTotals', () {
    final now = DateTime(2024);

    ProductEntity product({required String id, required double price}) {
      return ProductEntity(
        id: id,
        categoryId: 'cat-1',
        name: id,
        barcode: 'BAR-$id',
        price: price,
        unit: 'pc',
        isActive: true,
        createdAt: now,
      );
    }

    test('empty cart totals are zero', () {
      const cart = CartEntity();
      final totals = CalculateCartTotals()(cart);

      expect(totals['gross'], 0.0);
      expect(totals['net'], 0.0);
      expect(totals['vat'], 0.0);
    });

    test('2 x 80 + 320 yields gross 480, net 417.39, vat 62.61', () {
      final cart = CartEntity(
        items: [
          CartItemEntity(product: product(id: 'p80', price: 80.0), quantity: 2),
          CartItemEntity(product: product(id: 'p320', price: 320.0)),
        ],
      );

      final totals = CalculateCartTotals()(cart);

      expect(totals['gross'], closeTo(480.0, 0.01));
      expect(totals['net'], closeTo(417.39, 0.01));
      expect(totals['vat'], closeTo(62.61, 0.01));
      expect(totals['net']! + totals['vat']!, closeTo(totals['gross']!, 0.01));
    });

    test('single item extracts VAT correctly', () {
      final cart = CartEntity(
        items: [CartItemEntity(product: product(id: 'p100', price: 100.0))],
      );

      final totals = CalculateCartTotals()(cart);

      expect(totals['gross'], closeTo(100.0, 0.01));
      expect(totals['net'], closeTo(86.96, 0.01));
      expect(totals['vat'], closeTo(13.04, 0.01));
    });
  });
}
