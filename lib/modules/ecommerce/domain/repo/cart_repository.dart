import '../../../../core/shared/resources/typedefs.dart';
import '../../model/market_models.dart';

abstract class CartRepository {
  /// add item to cart
   FutureResponse<CartModel> add({required Map<String, dynamic> data});
  /// remove item from cart
   FutureResponse<CartModel> remove({required String productId});
  /// get cart items
   FutureResponse<CartModel> getCart();
  /// clear cart
   FutureResponse<StringMap> clear({required Map<String, dynamic>? data});
  /// update cart 
   FutureResponse<CartModel> update({required Map<String, dynamic> data, required String productId});

   /// validate cart
    FutureResponse<StringMap>   validate();
  
}