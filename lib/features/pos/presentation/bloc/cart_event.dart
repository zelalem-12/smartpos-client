import 'package:equatable/equatable.dart';

import '../../../catalog/domain/entities/product_entity.dart';

/// Events for [CartBloc].
sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

/// Load the current cart state.
class LoadCart extends CartEvent {
  const LoadCart();
}

/// Add one unit of [product] to the cart.
class AddToCart extends CartEvent {
  final ProductEntity product;

  const AddToCart(this.product);

  @override
  List<Object?> get props => [product];
}

/// Remove a line item from the cart by product ID.
class RemoveFromCart extends CartEvent {
  final String productId;

  const RemoveFromCart(this.productId);

  @override
  List<Object?> get props => [productId];
}

/// Change the quantity of a line item. A quantity of zero or below removes
/// the item.
class UpdateQuantity extends CartEvent {
  final String productId;
  final int quantity;

  const UpdateQuantity({required this.productId, required this.quantity});

  @override
  List<Object?> get props => [productId, quantity];
}

/// Clear all items from the cart.
class ClearCartEvent extends CartEvent {
  const ClearCartEvent();
}
