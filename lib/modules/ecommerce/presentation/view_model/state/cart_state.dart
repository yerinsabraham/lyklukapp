import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../model/cart_model.dart';
part 'cart_state.freezed.dart';

@freezed
class CartState with _$CartState {
  const factory CartState.initial() = CartInitial;

  /// adding to cart
  const factory CartState.addingToCart() = CartAddingToCart;
  const factory CartState.addedToCart({required CartModel cart}) =
      CartAddedToCart;
  const factory CartState.addingToCartFailed(String message) =
      CartAddingToCartFailed;

  /// removing from cart
  const factory CartState.removingFromCart({required int productId}) =
      CartRemovingFromCart;
  const factory CartState.removedFromCart({required CartModel cart}) =
      CartRemovedFromCart;
  const factory CartState.removingFromCartFailed(String message) =
      CartRemovingFromCartFailed;

  /// updating cart
  const factory CartState.updatingCart() = CartUpdatingCart;
  const factory CartState.updatedCart({required CartModel cart}) =
      CartUpdatedCart;
  const factory CartState.updatingCartFailed(String message) =
      CartUpdatingCartFailed;

  /// valid cart
  const factory CartState.validingCart() = CartValidingCart;
  const factory CartState.validatedCart({required Map<String, dynamic> cartmap}) = CartValidCart;
  const factory CartState.validingCartFailed({
    required String msg,
     required List<String> messages,
  }) = CartValidingCartFailed;
}
