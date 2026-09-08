import '../../../catalog/domain/entities/product_entity.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/repositories/cart_repository.dart';

/// In-memory implementation of [CartRepository].
///
/// The cart lives only for the duration of the current sale/session. This
/// keeps the POS flow fast, offline-safe, and independent of the database.
class CartRepositoryImpl implements CartRepository {
  CartEntity _cart = const CartEntity();

  @override
  CartEntity get cart => _cart;

  @override
  Future<CartEntity> addItem(ProductEntity product) async {
    _cart = _cart.addProduct(product);
    return _cart;
  }

  @override
  Future<CartEntity> removeItem(String productId) async {
    _cart = _cart.removeItem(productId);
    return _cart;
  }

  @override
  Future<CartEntity> updateQuantity(String productId, int quantity) async {
    _cart = _cart.updateQuantity(productId, quantity);
    return _cart;
  }

  @override
  Future<CartEntity> clear() async {
    _cart = _cart.clear();
    return _cart;
  }
}
