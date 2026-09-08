import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

/// Retrieves the current cart state.
class GetCart {
  final CartRepository _repository;

  const GetCart(this._repository);

  CartEntity call() => _repository.cart;
}
