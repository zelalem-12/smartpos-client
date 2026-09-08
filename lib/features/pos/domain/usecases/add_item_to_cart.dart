import '../../../catalog/domain/entities/product_entity.dart';
import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

/// Adds one unit of [product] to the cart, incrementing quantity if already
/// present.
class AddItemToCart {
  final CartRepository _repository;

  const AddItemToCart(this._repository);

  Future<CartEntity> call(ProductEntity product) =>
      _repository.addItem(product);
}
