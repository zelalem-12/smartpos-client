import 'package:equatable/equatable.dart';

import '../../../../core/utils/vat_calculator.dart';
import '../../../catalog/domain/entities/product_entity.dart';
import 'cart_item_entity.dart';

/// Domain entity representing the full shopping cart.
class CartEntity extends Equatable {
  final List<CartItemEntity> items;

  const CartEntity({this.items = const []});

  /// Total number of distinct product lines.
  int get lineCount => items.length;

  /// Total item count across all lines.
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  /// True when the cart contains no items.
  bool get isEmpty => items.isEmpty;

  /// True when the cart contains at least one item.
  bool get isNotEmpty => items.isNotEmpty;

  /// Sum of all line gross (tax-inclusive) totals.
  double get grossTotal => items.fold(0, (sum, item) => sum + item.grossTotal);

  /// Net (before-VAT) total derived from the gross total using the
  /// Ethiopian 15% inclusive VAT rate.
  double get netTotal => VatCalculator.grossToNet(grossTotal);

  /// VAT portion extracted from the gross total.
  double get vatTotal => grossTotal - netTotal;

  /// Finds a line item for [productId], if any.
  CartItemEntity? findItem(String productId) {
    try {
      return items.firstWhere((item) => item.product.id == productId);
    } on StateError {
      return null;
    }
  }

  /// Returns the quantity for [productId], or 0 when not in cart.
  int quantityOf(String productId) => findItem(productId)?.quantity ?? 0;

  /// Returns a new cart with [product] added. If the product is already
  /// present, its quantity is incremented by one.
  CartEntity addProduct(ProductEntity product) {
    final existing = findItem(product.id);
    if (existing == null) {
      return CartEntity(
        items: [
          ...items,
          CartItemEntity(product: product, quantity: 1),
        ],
      );
    }
    return updateQuantity(product.id, existing.quantity + 1);
  }

  /// Returns a new cart with [productId] removed entirely.
  CartEntity removeItem(String productId) {
    return CartEntity(
      items: items.where((item) => item.product.id != productId).toList(),
    );
  }

  /// Returns a new cart where [productId] has the requested [quantity].
  /// A quantity of zero or below removes the item.
  CartEntity updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      return removeItem(productId);
    }
    return CartEntity(
      items: items.map((item) {
        if (item.product.id == productId) {
          return item.copyWith(quantity: quantity);
        }
        return item;
      }).toList(),
    );
  }

  /// Returns an empty cart.
  CartEntity clear() => const CartEntity();

  @override
  List<Object?> get props => [items];
}
