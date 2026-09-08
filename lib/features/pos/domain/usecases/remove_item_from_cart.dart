import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

/// Removes a line item from the cart by product ID.
class RemoveItemFromCart {
  final CartRepository _repository;

  const RemoveItemFromCart(this._repository);

  Future<CartEntity> call(String productId) =>
      _repository.removeItem(productId);
}
