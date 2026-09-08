import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

/// Updates the quantity of a cart line item. A quantity of zero or below
/// removes the item.
class UpdateCartItemQuantity {
  final CartRepository _repository;

  const UpdateCartItemQuantity(this._repository);

  Future<CartEntity> call(String productId, int quantity) =>
      _repository.updateQuantity(productId, quantity);
}
