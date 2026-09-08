// ignore_for_file: prefer_initializing_formals

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/add_item_to_cart.dart';
import '../../domain/usecases/clear_cart.dart' as usecases;
import '../../domain/usecases/get_cart.dart';
import '../../domain/usecases/remove_item_from_cart.dart';
import '../../domain/usecases/update_cart_item_quantity.dart';
import 'cart_event.dart';
import 'cart_state.dart';

/// Manages the shopping cart for the POS sale flow.
///
/// Adding the same product increments its quantity. Decrementing at a
/// quantity of one removes the item entirely.
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({
    required GetCart getCart,
    required AddItemToCart addItemToCart,
    required RemoveItemFromCart removeItemFromCart,
    required UpdateCartItemQuantity updateQuantity,
    required usecases.ClearCart clearCart,
  }) : _getCart = getCart,
       _addItemToCart = addItemToCart,
       _removeItemFromCart = removeItemFromCart,
       _updateQuantity = updateQuantity,
       _clearCart = clearCart,
       super(const CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateQuantity>(_onUpdateQuantity);
    on<ClearCartEvent>(_onClearCart);
  }

  final GetCart _getCart;
  final AddItemToCart _addItemToCart;
  final RemoveItemFromCart _removeItemFromCart;
  final UpdateCartItemQuantity _updateQuantity;
  final usecases.ClearCart _clearCart;

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    final cart = _getCart();
    emit(CartLoaded(cart));
  }

  Future<void> _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    final cart = await _addItemToCart(event.product);
    emit(CartLoaded(cart));
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCart event,
    Emitter<CartState> emit,
  ) async {
    final cart = await _removeItemFromCart(event.productId);
    emit(CartLoaded(cart));
  }

  Future<void> _onUpdateQuantity(
    UpdateQuantity event,
    Emitter<CartState> emit,
  ) async {
    final cart = await _updateQuantity(event.productId, event.quantity);
    emit(CartLoaded(cart));
  }

  Future<void> _onClearCart(
    ClearCartEvent event,
    Emitter<CartState> emit,
  ) async {
    final cart = await _clearCart();
    emit(CartLoaded(cart));
  }
}
