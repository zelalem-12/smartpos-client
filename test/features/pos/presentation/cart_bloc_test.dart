import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartpos_client/features/catalog/domain/entities/product_entity.dart';
import 'package:smartpos_client/features/pos/data/repositories/cart_repository_impl.dart';
import 'package:smartpos_client/features/pos/domain/repositories/cart_repository.dart';
import 'package:smartpos_client/features/pos/domain/usecases/add_item_to_cart.dart';
import 'package:smartpos_client/features/pos/domain/usecases/clear_cart.dart'
    as usecases;
import 'package:smartpos_client/features/pos/domain/usecases/get_cart.dart';
import 'package:smartpos_client/features/pos/domain/usecases/remove_item_from_cart.dart';
import 'package:smartpos_client/features/pos/domain/usecases/update_cart_item_quantity.dart';
import 'package:smartpos_client/features/pos/presentation/bloc/cart_bloc.dart';
import 'package:smartpos_client/features/pos/presentation/bloc/cart_event.dart';
import 'package:smartpos_client/features/pos/presentation/bloc/cart_state.dart';

void main() {
  late CartRepository cartRepository;

  final now = DateTime(2024);
  final product = ProductEntity(
    id: 'p1',
    categoryId: 'cat-1',
    name: 'Coffee',
    barcode: 'BAR-001',
    price: 35.0,
    unit: 'cup',
    isActive: true,
    createdAt: now,
  );

  setUp(() {
    cartRepository = CartRepositoryImpl();
  });

  CartBloc buildBloc() {
    return CartBloc(
      getCart: GetCart(cartRepository),
      addItemToCart: AddItemToCart(cartRepository),
      removeItemFromCart: RemoveItemFromCart(cartRepository),
      updateQuantity: UpdateCartItemQuantity(cartRepository),
      clearCart: usecases.ClearCart(cartRepository),
    );
  }

  group('CartBloc', () {
    test('initial state is CartInitial', () {
      expect(buildBloc().state, isA<CartInitial>());
    });

    blocTest<CartBloc, CartState>(
      'emits empty cart on LoadCart',
      build: buildBloc,
      act: (bloc) => bloc.add(const LoadCart()),
      expect: () => [
        isA<CartLoaded>().having((s) => s.cart.isEmpty, 'isEmpty', true),
      ],
    );

    blocTest<CartBloc, CartState>(
      'adding a product creates a line item',
      build: buildBloc,
      act: (bloc) => bloc
        ..add(const LoadCart())
        ..add(AddToCart(product)),
      skip: 1,
      expect: () => [
        isA<CartLoaded>().having((s) => s.cart.items.length, 'line count', 1),
      ],
    );

    blocTest<CartBloc, CartState>(
      'adding the same product increments quantity',
      build: buildBloc,
      act: (bloc) => bloc
        ..add(const LoadCart())
        ..add(AddToCart(product))
        ..add(AddToCart(product)),
      skip: 2,
      expect: () => [
        isA<CartLoaded>().having(
          (s) => s.cart.quantityOf(product.id),
          'quantity',
          2,
        ),
      ],
    );

    blocTest<CartBloc, CartState>(
      'increment quantity updates the line',
      build: buildBloc,
      act: (bloc) => bloc
        ..add(const LoadCart())
        ..add(AddToCart(product))
        ..add(const UpdateQuantity(productId: 'p1', quantity: 5)),
      skip: 2,
      expect: () => [
        isA<CartLoaded>().having((s) => s.cart.quantityOf('p1'), 'quantity', 5),
      ],
    );

    blocTest<CartBloc, CartState>(
      'decrement to one removes the item',
      build: buildBloc,
      act: (bloc) => bloc
        ..add(const LoadCart())
        ..add(AddToCart(product))
        ..add(const UpdateQuantity(productId: 'p1', quantity: 0)),
      skip: 2,
      expect: () => [
        isA<CartLoaded>().having((s) => s.cart.isEmpty, 'cart empty', true),
      ],
    );

    blocTest<CartBloc, CartState>(
      'remove deletes the line item',
      build: buildBloc,
      act: (bloc) => bloc
        ..add(const LoadCart())
        ..add(AddToCart(product))
        ..add(const RemoveFromCart('p1')),
      skip: 2,
      expect: () => [
        isA<CartLoaded>().having((s) => s.cart.isEmpty, 'cart empty', true),
      ],
    );

    blocTest<CartBloc, CartState>(
      'clear empties the cart',
      build: buildBloc,
      act: (bloc) => bloc
        ..add(const LoadCart())
        ..add(AddToCart(product))
        ..add(const ClearCartEvent()),
      skip: 2,
      expect: () => [
        isA<CartLoaded>().having((s) => s.cart.isEmpty, 'cart empty', true),
      ],
    );

    blocTest<CartBloc, CartState>(
      'totals update after adding items',
      build: buildBloc,
      act: (bloc) => bloc
        ..add(const LoadCart())
        ..add(AddToCart(product))
        ..add(AddToCart(product)),
      skip: 2,
      expect: () => [
        isA<CartLoaded>().having((s) => s.cart.grossTotal, 'gross total', 70.0),
      ],
    );
  });
}
