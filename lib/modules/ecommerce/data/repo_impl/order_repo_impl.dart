import 'package:fpdart/fpdart.dart';
import 'package:lykluk/core/services/services.dart';
import 'package:lykluk/core/shared/resources/failure.dart';
import 'package:lykluk/core/shared/resources/response_data.dart';
import 'package:lykluk/core/shared/resources/typedefs.dart';
import 'package:lykluk/modules/ecommerce/domain/repo/order_repository.dart';
import 'package:lykluk/modules/ecommerce/model/order_model.dart';
import 'package:lykluk/utils/pagination/pagination.dart';
import 'package:riverpod/riverpod.dart';

import '../market_contants.dart/market_endpoints.dart';

final orderRepoProvider = Provider<OrderRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return OrderRepoImpl(apiService);
});

class OrderRepoImpl implements OrderRepository {
  final ApiService _apiService;
  OrderRepoImpl(this._apiService);

  @override
  FutureResponse<OrderModel> createOrder({required Map<String, dynamic> data}) async {
    try {
      final response = await _apiService.postData(
        MarketEndpoints.createOrder,
        hasHeader: true,
        body: data,
      );
      if (response.isSuccessful) {
        final data = response.data;
        final orderModel = OrderModel.fromJson(data['data']);
        return Right(ResponseData(data: orderModel, message: "Order created"));
      } else {
        return Left(Failure("Unable to create order, please try again later"));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "Unable to create order",
      );
      return Left(Failure("Unable to create order, please try again later"));
    }
  }

  @override
  FutureResponse createTrackingEntry({required String orderId, required Map<String, dynamic> data}) async {
    try {
      final response = await _apiService.postData(
        MarketEndpoints.createTrackingEntry.replaceFirst('{id}', orderId),
        hasHeader: true,
        body: data,
      );
      if (response.isSuccessful) {
        final data = response.data;
        return Right(ResponseData(data: data, message: "Tracking entry created"));
      } else {
        return Left(Failure("Unable to create tracking entry, please try again later"));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "Unable to create tracking entry",
      );
      return Left(Failure("Unable to create tracking entry, please try again later"));
    }
  }

  @override
  FutureResponse getInternationalOrderStats() async {
    try {
      final response = await _apiService.getData(
        MarketEndpoints.getInternationalOrdersStats,
        hasHeader: true,
      );
      if (response.isSuccessful) {
        final data = response.data;
        final orderModel = OrderModel.fromJson(data['data']);
        return Right(ResponseData(data: orderModel, message: "International order loaded"));
      } else {
        return Left(Failure("Unable to load international order, please try again later"));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "Unable to load international order",
      );
      return Left(Failure("Unable to load international order, please try again later"));
    }
  }

  @override
  FutureResponse<PaginatedResponse<OrderModel>> getMyOrders({required Map<String, dynamic> query}) async {
    try {
      final response = await _apiService.getData(
        MarketEndpoints.getOrders,
        queryParameters: query,
        hasHeader: true,
      );
      if (response.isSuccessful) {
        final raw = Map<String, dynamic>.from(response.data as Map);
        final result = PaginatedResponse.fromJson(
          fieldName: "data",
          json: raw,
          dataFromJson: (d) => OrderModel.fromJson(d as Map<String, dynamic>),
        );
        return Right(ResponseData(data: result, message: "Orders loaded"));
      } else {
        return Left(Failure("Unable to load orders, please try again later"));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "Unable to load orders",
      );
      return Left(Failure("Unable to load orders, please try again later"));
    }
  }

  @override
  FutureResponse getOrderById({required String id}) async {
    try {
      final response = await _apiService.getData(
        MarketEndpoints.getOrderById.replaceFirst('{id}', id),
        hasHeader: true,
      );
      if (response.isSuccessful) {
        final data = response.data;
        final orderModel = OrderModel.fromJson(data['data']);
        return Right(ResponseData(data: orderModel, message: "Order loaded"));
      } else {
        return Left(Failure("Unable to load order, please try again later"));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "Unable to load order",
      );
      return Left(Failure("Unable to load order, please try again later"));
    }
  }

  @override
  FutureResponse getOrderStats({required Map<String, dynamic> query}) async {
    try {
      final response = await _apiService.getData(
        MarketEndpoints.getOrderStats,
        queryParameters: query,
        hasHeader: true,
      );
      if (response.isSuccessful) {
        final data = response.data;
        return Right(ResponseData(data: data, message: "Order stats loaded"));
      } else {
        return Left(Failure("Unable to load order stats, please try again later"));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "Unable to load order stats",
      );
      return Left(Failure("Unable to load order stats, please try again later"));
    }
  }

  @override
  FutureResponse getOrdersByCurrency({required Map<String, dynamic> query}) async {
    try {
      final response = await _apiService.getData(
        MarketEndpoints.getOrdersByCurrency,
        queryParameters: query,
        hasHeader: true,
      );
      if (response.isSuccessful) {
        final data = response.data;
        return Right(ResponseData(data: data, message: "Orders by currency loaded"));
      } else {
        return Left(Failure("Unable to load orders by currency, please try again later"));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "Unable to load orders by currency",
      );
      return Left(Failure("Unable to load orders by currency, please try again later"));
    }
  }

  @override
  FutureResponse updateOrderStatus({required String orderId, required Map<String, dynamic> data}) async {
    try {
      final response = await _apiService.putData(
        MarketEndpoints.udpateOrderStatus.replaceFirst('{id}', orderId),
        hasHeader: true,
        body: data,
      );
      if (response.isSuccessful) {
        final data = response.data;
        return Right(ResponseData(data: data, message: "Order status updated"));
      } else {
        return Left(Failure("Unable to update order status, please try again later"));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "Unable to update order status",
      );
      return Left(Failure("Unable to update order status, please try again later"));
    }
  }

  @override
  FutureResponse updateTrackingStatus({required String orderId, required Map<String, dynamic> data}) async {
    try {
      final response = await _apiService.putData(
        MarketEndpoints.updateTrackingStatus.replaceFirst('{id}', orderId),
        hasHeader: true,
        body: data,
      );
      if (response.isSuccessful) {
        final data = response.data;
        return Right(ResponseData(data: data, message: "Tracking status updated"));
      } else {
        return Left(Failure("Unable to update tracking status, please try again later"));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "Unable to update tracking status",
      );
      return Left(Failure("Unable to update tracking status, please try again later"));
    }
  }

  @override
  FutureResponse<StringMap> validateCarrierChoice({required Map<String, dynamic> data}) async {
    try {
      final response = await _apiService.postData(
        MarketEndpoints.validateCarrierChoice,
        hasHeader: true,
        body: data,
      );
      if (response.isSuccessful) {
        final data = response.data;
        return Right(ResponseData(data: data, message: "Carrier choice validated"));
      } else {
        return Left(Failure("Unable to validate carrier choice, please try again later"));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "Unable to validate carrier choice",
      );
      return Left(Failure("Unable to validate carrier choice, please try again later"));
    }
  }
}