import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

/// Clears all items from the cart.
class ClearCart {
  final CartRepository _repository;

  const ClearCart(this._repository);

  Future<CartEntity> call() => _repository.clear();
}
