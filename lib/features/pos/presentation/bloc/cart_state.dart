import 'package:equatable/equatable.dart';

import '../../domain/entities/cart_entity.dart';

/// States for [CartBloc].
sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

/// Initial cart state.
class CartInitial extends CartState {
  const CartInitial();
}

/// Cart loaded successfully with computed totals.
class CartLoaded extends CartState {
  final CartEntity cart;

  const CartLoaded(this.cart);

  @override
  List<Object?> get props => [cart];
}
