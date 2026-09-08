import '../../../catalog/domain/entities/product_entity.dart';
import '../entities/cart_entity.dart';

/// Abstract repository for in-memory cart operations.
abstract class CartRepository {
  /// Returns the current cart state.
  CartEntity get cart;

  /// Adds one unit of [product] to the cart. If the product already exists,
  /// its quantity is incremented by one.
  Future<CartEntity> addItem(ProductEntity product);

  /// Removes the line item for [productId] entirely.
  Future<CartEntity> removeItem(String productId);

  /// Sets the quantity for [productId]. A quantity of zero or below
  /// removes the item from the cart.
  Future<CartEntity> updateQuantity(String productId, int quantity);

  /// Removes all items from the cart.
  Future<CartEntity> clear();
}
