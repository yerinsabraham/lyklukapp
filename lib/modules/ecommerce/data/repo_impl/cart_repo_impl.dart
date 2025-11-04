import 'package:fpdart/fpdart.dart';

import 'package:lykluk/core/services/services.dart';
import 'package:lykluk/core/shared/resources/failure.dart';
import 'package:lykluk/core/shared/resources/response_data.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../core/shared/resources/typedefs.dart';
import '../../domain/repo/market_repositories.dart';
import '../../model/market_models.dart';
import '../market_contants.dart/market_endpoints.dart';

final cartRepoProvider = Provider<CartRepository>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return CartRepositoryImpl(apiService);
});

class CartRepositoryImpl implements CartRepository {
  final ApiService _apiService;
  CartRepositoryImpl(this._apiService);

  @override
  FutureResponse<CartModel> add({required Map<String, dynamic> data}) async {
    try {
      final response = await _apiService.postData(
        MarketEndpoints.addToCart,
        hasHeader: true,
        body: data,
      );
      if (response.isSuccessful) {
        final data = response.data as Map<String, dynamic>;
        final cartModel = CartModel.fromJson(data['data']['cart']);
        return Right(ResponseData(data: cartModel, message: "Cart item added"));
      } else {
        return Left(Failure("Unable to add to cart, please try again later"));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "Unable to add cart ",
      );
      return Left(Failure("Unable to add to cart , please try again later"));
    }
  }

  @override
  FutureResponse<StringMap> clear({required Map<String, dynamic>? data}) async {
    try {
      final response = await _apiService.deleteData(
        MarketEndpoints.clearCart,
        hasHeader: true,
        body: data,
      );
      if (response.isSuccessful) {
        final data = response.data;

        return Right(ResponseData(data: data, message: "Cart cleared"));
      } else {
        return Left(Failure("Unable to add to cart, please try again later"));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "Unable to add cart ",
      );
      return Left(Failure("Unable to add to cart , please try again later"));
    }
  }

  @override
  FutureResponse<CartModel> getCart() async {
    try {
      final response = await _apiService.getData(
        MarketEndpoints.getCart,
        hasHeader: true,
      );
      if (response.isSuccessful) {
        final data = (response.data as Map<String, dynamic>)['data'];
        final cartModel = CartModel.fromJson(data['cart']);
        return Right(ResponseData(data: cartModel, message: "Cart loaded"));
      } else {
        return Left(
          Failure("Unable to load cart items, please try again later"),
        );
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "Unable to load cart items",
      );
      return Left(Failure("Unable to load cart items, please try again later"));
    }
  }

  @override
  FutureResponse<CartModel> remove({required String productId}) async {
    try {
      final response = await _apiService.deleteData(
        MarketEndpoints.removeFromCart.replaceFirst("{id}", productId),
        hasHeader: true,
      );
      if (response.isSuccessful) {
        final data = (response.data as Map<String, dynamic>)['data'];
        final cartModel = CartModel.fromJson(data['cart']);

        return Right(ResponseData(data: cartModel, message: "Cart remove"));
      } else {
        return Left(
          Failure("Unable to remove to cart, please try again later"),
        );
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "Unable to remove cart ",
      );
      return Left(Failure("Unable to add to remove , please try again later"));
    }
  }

  @override
  FutureResponse<CartModel> update({
    required Map<String, dynamic> data,
    required String productId,
  }) async {
    try {
      final response = await _apiService.putData(
        MarketEndpoints.updateCart.replaceFirst("id", productId),
        hasHeader: true,
        body: data,
      );
      if (response.isSuccessful) {
        final data = (response.data as Map<String, dynamic>)['data'];
        final cartModel = CartModel.fromJson(data['cart']);

        return Right(ResponseData(data: cartModel, message: "Cart updated"));
      } else {
        return Left(
          Failure("Unable to update to cart, please try again later"),
        );
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "Unable to update cart ",
      );
      return Left(Failure("Unable to update to cart , please try again later"));
    }
  }

  @override
  FutureResponse<StringMap> validate() async {
    try {
      final response = await _apiService.getData(
        MarketEndpoints.validateCart,
        hasHeader: true,
      );
      if (response.isSuccessful) {
        final data = (response.data as Map<String, dynamic>)['data'];
        // final cartModel = CartModel.fromJson(data['cart']);

        return Right(ResponseData(data: data, message: "Cart validated"));
      } else {
        if (response.statusCode == 400) {
          final errors = (response.data as Map<String, dynamic>)['data'];
          return Left(
            Failure(
              response.message ?? "Cart validation failed",
              code: response.statusCode,
              data: ResponseData(data: errors),
            ),
          );
        }
        return Left(
          Failure("Unable to validate  cart, please try again later"),
        );
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "Unable to validate cart ",
      );
      return Left(Failure("Unable to validate  cart , please try again later"));
    }
  }
}
