import 'package:lykluk/modules/ecommerce/data/repo_impl/market_repo_impls.dart';
import 'package:lykluk/modules/ecommerce/domain/repo/market_repositories.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/state/cart_state.dart';
import 'package:riverpod/riverpod.dart';



final cartNotifierProvider = NotifierProvider<CartController, CartState>(
  CartController.new,
);




class CartController extends Notifier<CartState> {
  late final CartRepository _cartRepository;
  @override
  build() {
    _cartRepository = ref.read(cartRepoProvider);
    return CartState.initial();
  }

  void add({required int productId, required int quantity}) async {
    try {
      state = CartState.addingToCart();
      final response = await _cartRepository.add(
        data: {"productId": productId, "quantity": quantity},
      );
      response.fold(
        (l) {
          state = CartState.addingToCartFailed(l.message);
        },
        (r) {
          state = CartState.addedToCart(cart: r.data);
        },
      );
    } catch (e) {
      state = CartState.addingToCartFailed(e.toString());
    }
  }

  void remove({required int itemId}) async {
    try {
      state = CartState.removingFromCart( productId: itemId);
      final response = await _cartRepository.remove(
        productId: itemId.toString(),
      );
      response.fold(
        (l) {
          state = CartState.removingFromCartFailed(l.message);
        },
        (r) {
          state = CartState.removedFromCart(cart: r.data);
        },
      );
    } catch (e) {
      state = CartState.removingFromCartFailed(e.toString());
    }
  }

  void update({required int itemId, required int quantity}) async {
    try {
      state = CartState.updatingCart();
      final response = await _cartRepository.update(
        data: {"quantity": quantity},
        productId: itemId.toString(),
      );
      response.fold(
        (l) {
          state = CartState.updatingCartFailed(l.message);
        },
        (r) {
          state = CartState.updatedCart(cart: r.data);
        },
      );
    } catch (e) {
      state = CartState.updatingCartFailed(e.toString());
    }
  }

  void clear() {}

  void validate()async {
    try {
      state = CartState.validingCart();
      final response = await _cartRepository.validate();
      response.fold(
        (l) {
          state = CartState.validingCartFailed(msg:  l.message,messages:  l.data?.data['errors'] as List<String>);
        },
        (r) {
          state = CartState.validatedCart(cartmap: r.data);
        },
      );
    } catch (e) {
      state = CartState.validingCartFailed(messages: [],msg: e.toString());
    }
  }
}
