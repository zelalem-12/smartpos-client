import 'package:equatable/equatable.dart';

import '../../../catalog/domain/entities/product_entity.dart';

/// Domain entity representing a single line item in the cart.
class CartItemEntity extends Equatable {
  final ProductEntity product;
  final int quantity;

  const CartItemEntity({required this.product, this.quantity = 1});

  /// Gross (tax-inclusive) unit price.
  double get unitGrossPrice => product.price;

  /// Total gross amount for this line.
  double get grossTotal => unitGrossPrice * quantity;

  CartItemEntity copyWith({ProductEntity? product, int? quantity}) {
    return CartItemEntity(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [product, quantity];
}
