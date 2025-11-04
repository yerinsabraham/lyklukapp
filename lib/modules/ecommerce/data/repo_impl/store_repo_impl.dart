import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/services/queue_system/queue_service.dart';
import 'package:lykluk/core/services/services.dart';
import 'package:lykluk/core/shared/resources/failure.dart';
import 'package:lykluk/core/shared/resources/response_data.dart';
import 'package:lykluk/core/shared/resources/typedefs.dart';
import 'package:lykluk/modules/chats/data/models/user_model.dart';
import 'package:lykluk/modules/ecommerce/model/order_model.dart';
import 'package:lykluk/modules/ecommerce/model/product_model.dart';
import 'package:lykluk/modules/ecommerce/model/store_analytics_model.dart';
import 'package:lykluk/modules/ecommerce/model/store_model.dart';
import 'package:lykluk/utils/pagination/pagination.dart';
import 'package:lykluk/utils/storage/local_storage.dart';

import '../../domain/repo/store_repository.dart';
import '../market_contants.dart/market_endpoints.dart';


final storeRepoProvider = Provider((ref) {
  return StoreRepoImpl( apiService :ref.read(apiServiceProvider), queueService: ref.read(queueServiceProvider));
});


class StoreRepoImpl implements StoreRepository {
  final ApiService _apiService;
  final QueueService _queueService;

  const StoreRepoImpl({required ApiService apiService, required QueueService queueService}): _apiService = apiService, _queueService = queueService;
  @override
  FutureResponse<StoreModel> createStore({
    required Map<String, dynamic> data,
  }) async {
    try {
      final res = await _apiService.postData(
        MarketEndpoints.createStore,
        hasHeader: true,
        body: data,
       
      );
      if (res.isSuccessful) {
        final raw = (res.data as Map<String, dynamic>)['data']['store'];
        final store = StoreModel.fromJson(raw);
        /// save to local storage
        HiveStorage.store= store;
        return Right(
          ResponseData(
            data: store,
            message: res.message ?? "Store registration successful",
          ),
        );
      } else {
        return Left(Failure(res.message ?? "Store registration failed"));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e.toString(),
        stackTrace: s,
        reason:
            'Error occured while creating store, try again later -- Store Repository',
      );
      return Left(
        Failure("Error occured while creating store, try again later"),
      );
    }
  }

  @override
  FutureResponse<PaginatedResponse<StoreModel>> getMyStores({
    required Map<String, dynamic> query,
  }) async {
   try {
      final res = await _apiService.getData(
        MarketEndpoints.getMyStores,
        queryParameters: query,
        hasHeader: true,
      );
      if (res.isSuccessful) {
        final raw = Map<String, dynamic>.from(res.data as Map)['data'];

        final result = PaginatedResponse.fromJson(
          fieldName: "stores",
          json: raw,
          dataFromJson:
              (d) => StoreModel.fromJson(Map<String, dynamic>.from(d as Map)),
        );
        return Right(ResponseData(data: result, message: ""));
      } else {
        return Left(Failure(res.message ?? ""));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "StoreRepo-- Unable to load  my stores, please try again later",
      );
      return Left(Failure("Somthing went wrong, please try again later"));
    }
  }

  @override
  FutureResponse<StoreModel> getStoreById({required int storeId}) async {
    try {
      final res = await _apiService.getData(
        MarketEndpoints.getStore.replaceFirst("id", storeId.toString()),
        hasHeader: true,
       
      );
      if (res.isSuccessful) {
        final raw = (res.data as Map<String, dynamic>)['data'];
        if( !raw.containsKey('store')){
          return Left(Failure( res.message ?? "Store not found"));
        }
        final store = StoreModel.fromJson(raw['store']);
        return Right(
          ResponseData(
            data: store,
            message: res.message ?? "Store loaded successful",
          ),
        );
      } else {
        return Left(Failure(res.message ?? "Store failed to load"));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e.toString(),
        stackTrace: s,
        reason:
            'Error occured while loading store, try again later -- Store Repository',
      );
      return Left(
        Failure("Error occured while loading store, try again later"),
      );
    }
  }

  @override
  FutureResponse<StoreModel> rejectStore({
    required Map<String, dynamic> data,
    required int storeId,
  }) async {
    try {
      final res = await _apiService.postData(
        MarketEndpoints.rejectStore.replaceFirst("id", storeId.toString()),
        hasHeader: true,
        body: data,
       
      );
      if (res.isSuccessful) {
        final raw = (res.data as Map<String, dynamic>)['data']['store'];
        final store = StoreModel.fromJson(raw);
        return Right(
          ResponseData(
            data: store,
            message: res.message ?? "rejected store successful",
          ),
        );
      } else {
        return Left(Failure(res.message ?? "Rejection failed"));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e.toString(),
        stackTrace: s,
        reason:
            'Error occured while rejecting store, try again later -- Store Repository',
      );
      return Left(
        Failure("Error occured while rejecting store, try again later"),
      );
    }
  }

  @override
  FutureResponse<StoreModel> updateStore({
    required Map<String, dynamic> data,
  }) async {
    try {
      final res = await _apiService.putData(
        MarketEndpoints.updateStore,
        hasHeader: true,
       
      );
      if (res.isSuccessful) {
        final raw = (res.data as Map<String, dynamic>)['data']['store'];
        final store = StoreModel.fromJson(raw);
        return Right(
          ResponseData(
            data: store,
            message: res.message ?? "Store updated successful",
          ),
        );
      } else {
        return Left(Failure(res.message ?? "Store update failed"));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e.toString(),
        stackTrace: s,
        reason:
            'Error occured while updating store, try again later -- Store Repository',
      );
      return Left(
        Failure("Error occured while updating store, try again later"),
      );
    }
  }

  @override
  FutureResponse<StoreModel> verifyStore({
    required Map<String, dynamic> data,
    required int storeId,
  }) async {
    try {
      final res = await _apiService.postData(
        MarketEndpoints.verifyStore.replaceFirst("id", storeId.toString()),
        hasHeader: true,
        body: data,
       
      );
      if (res.isSuccessful) {
        final raw = (res.data as Map<String, dynamic>)['data']['store'];
        final store = StoreModel.fromJson(raw);
        return Right(
          ResponseData(
            data: store,
            message: res.message ?? "verified store successful",
          ),
        );
      } else {
        return Left(Failure(res.message ?? "Verification failed"));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e.toString(),
        stackTrace: s,
        reason:
            'Error occured while verifying store, try again later -- Store Repository',
      );
      return Left(
        Failure("Error occured while verifying store, try again later"),
      );
    }
  }
  
  @override
  FutureResponse<StoreModel> updateStoreSetting({
    required Map<String, dynamic> data,
  }) async {
    try {
      final res = await _apiService.putData(
        MarketEndpoints.updateStoreSettings,
        hasHeader: true,
       
      );
      if (res.isSuccessful) {
        final raw = (res.data as Map<String, dynamic>)['data']['store'];
        final store = StoreModel.fromJson(raw);
        return Right(
          ResponseData(
            data: store,
            message: res.message ?? "Store udpate settings successful",
          ),
        );
      } else {
        return Left(Failure(res.message ?? "Store udpate settings failed"));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e.toString(),
        stackTrace: s,
        reason:
            'Error occured while updating store settings, try again later -- Store Repository',
      );
      return Left(
        Failure("Error occured while updating store settings, try again later"),
      );
    }
  }
  
  @override
  FutureResponse<PaginatedResponse<StoreModel>> getStores({
    required Map<String, dynamic> query,
  }) async {
    try {
      final res = await _apiService.getData(
        MarketEndpoints.getStores,
        queryParameters: query,
        hasHeader: true,
       
      );
      if (res.isSuccessful) {
        final raw = Map<String, dynamic>.from(res.data as Map);

        final result = PaginatedResponse.fromJson(
          fieldName: "data",
          json: raw,
          dataFromJson:
              (d) => StoreModel.fromJson(Map<String, dynamic>.from(d as Map)),
        );
        return Right(ResponseData(data: result, message: ""));
      } else {
        return Left(Failure(res.message ?? ""));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "StoreRepo-- Unable to load stores, please try again later",
      );
      return Left(Failure("Somthing went wrong, please try again later"));
    }
  }
  
  @override
  FutureResponse<StringMap> setStoreCarriers({required Map<String, dynamic> data, required int storeId})async {
     try {
      final res = await _apiService.putData(
        MarketEndpoints.setPerferredCarriers,
       queryParameters: {
        "storeId": storeId.toString(),
       },
        hasHeader: true,
        body: data,
      );
      if (res.isSuccessful) {
        final raw = (res.data as Map<String, dynamic>)['data'];
        // final store = StoreModel.fromJson(raw);
        return Right(
          ResponseData(
            data: StringMap.from( raw),
            message: res.message ?? "Store carriers updated successfully",
          ),
        );
      } else {
        return Left(Failure(res.message ?? "Store carriers update  failed"));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e.toString(),
        stackTrace: s,
        reason:
            'Error occured while updating store carriers, try again later -- Store Repository',
      );
      return Left(
        Failure("Error occured while updating store settings, try again later"),
      );
    }
  }
  
  @override
  FutureResponse<StringMap> verifyStoreIndentity({required Map<String, dynamic> data})async {
    try {
      final res = await _apiService.postData(
        MarketEndpoints.verifyStoreIndentity,
        hasHeader: true,
        body: data,
       
      );
      if (res.isSuccessful) {
        final raw = (res.data as Map<String, dynamic>)['data']['storeKYC'];
        final store =  StringMap.from(raw);
        return Right(
          ResponseData(
            data: store,
            message: res.message ?? "Verification details submitted successfully",
          ),
        );
      } else {
        return Left(Failure(res.message ?? "Verification details submission failed"));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e.toString(),
        stackTrace: s,
        reason:
            'Error occured while submitting verification details for store, try again later -- Store Repository',
      );
      return Left(
        Failure("Error occured while submitting verification details, try again later"),
      );
    }
  }
  
  @override
  FutureResponse<String> uploadStoreDocument({required Map<String, dynamic> data, required Function(double) onProgress,
  })async {
    try {
      final res =  await _apiService.postData(
        MarketEndpoints.uploadeStoreDocument,
        hasHeader: true,
        body: FormData.fromMap(data),
        onReceiveProgress: onProgress
      );
      if (res.isSuccessful) {
        final raw = (res.data as Map<String, dynamic>)['data']['documentFileId'];
        final fileId = raw as String;
        return Right(
          ResponseData(
            data: fileId,
            message: res.message ?? "Store document uploaded successfully",
          ),
        );
      } else {
        return Left(Failure(res.message ?? "Store document upload failed"));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e.toString(),
        stackTrace: s,
        reason:
            'Error occured while uploading store document, try again later -- Store Repository',
      );
      return Left(
        Failure("Error occured while uploading store document, try again later"),
      );
    } 
  }

  @override
  FutureResponse<PaginatedResponse<ProductModel>> getStoreProducts({
    required int storeId,
    required Map<String, dynamic> query,
  }) async {
    try {
      final res = await _apiService.getData(
        MarketEndpoints.getStoreProducts.replaceFirst("id", storeId.toString()),
        queryParameters: query,
        hasHeader: true,
      );
      if (res.isSuccessful) {
        final raw = Map<String, dynamic>.from(res.data as Map)["data"];
        final result = await Isolate.run(() {
          final values = PaginatedResponse.fromJson(
            fieldName: "products",
            paginationField: "pagination",
            json: raw,
            dataFromJson:
                (d) => ProductModel.fromJson(d as Map<String, dynamic>),
          );
          return values;
        });
        return Right(ResponseData(data: result, message: ""));
      } else {
        return Left(Failure(res.message ?? ""));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason:
            "productRepoProvider-- Unable to load store products $storeId, please try again later",
      );
      return Left(Failure("Somthing went wrong, please try again later"));
    }
  }

  @override
  FutureResponse<StoreAnalyticsModel> getStoreAnalytics({required int storeId, required Map<String, dynamic> query}) {
    // TODO: implement getStoreAnalytics
    throw UnimplementedError();
  }

  @override
  FutureResponse<PaginatedResponse<OrderModel>> getStoreOrders({required int storeId, required Map<String, dynamic> query}) async{
      try {
      final res = await _apiService.getData(
        MarketEndpoints.getStoreOrders.replaceFirst("id", storeId.toString()),
        queryParameters: query,
        hasHeader: true,
      );
      if (res.isSuccessful) {
        final raw = Map<String, dynamic>.from(res.data as Map)["data"];
        final result = await Isolate.run(() {
          final values = PaginatedResponse.fromJson(
            fieldName: "orders",
            paginationField: "pagination",
            json: raw,
            dataFromJson:
                (d) => OrderModel.fromJson(d as Map<String, dynamic>),
          );
          return values;
        });
        return Right(ResponseData(data: result, message: ""));
      } else {
        return Left(Failure(res.message ?? ""));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason:
            "productRepoProvider-- Unable to load store orders $storeId, please try again later",
      );
      return Left(Failure("Somthing went wrong, please try again later"));
    }
  }

  @override
  FutureResponse<StringMap> followStore({required int storeId})async {
  try {
      final res = await _apiService.postData(
        MarketEndpoints.followStore.replaceFirst("{id}", storeId.toString()),
        hasHeader: true,
      );
      if (res.isSuccessful) {
        final raw = Map<String, dynamic>.from(res.data as Map);
        final result = Map<String, bool>.from(raw["data"]);
        return Right(ResponseData(data: result, message: ""));
      } else {
        /// add to queue
        _queueService.addToQueue(
          endpoint: MarketEndpoints.followStore.replaceFirst("{id}", storeId.toString()),
          method: 'POST',
          hasHeaders: true,
        );
        return Right(
          ResponseData(data: {"isFollow": true}, message: res.message ?? ""),
        );
        // return Left(Failure(res.message ?? ""));
      }
    } catch (e) {
      LoggerService.logError(
        error: e,
        reason: "ProductRepoImpl-- Unable to follow store $storeId, please try again later",
      );
      // return Left(Failure("Somthing went wrong, please try again later"));
      // /// add to queue
      _queueService.addToQueue(
        endpoint: MarketEndpoints.saveProduct.replaceFirst("{id}", storeId.toString()),
        method: 'POST',
        hasHeaders: true,
      );
      return Right(ResponseData(data: {"isSaved": true}, message: ""));
    }
  }

  @override
  FutureResponse<PaginatedResponse<UserModel>> getStoreFollowers({required int storeId, required Map<String, dynamic> query}) {
    // TODO: implement getStoreFollowers
    throw UnimplementedError();
  }

  @override
  FutureResponse<StringMap> unfollowStore({required int storeId}) {
    // TODO: implement unfollowStore
    throw UnimplementedError();
  }

  
  
 
}
