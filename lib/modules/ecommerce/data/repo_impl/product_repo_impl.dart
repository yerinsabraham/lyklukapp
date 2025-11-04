import 'dart:isolate';

import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/di/injection.dart';
import 'package:lykluk/core/services/services.dart';
import 'package:lykluk/core/shared/resources/typedefs.dart';
import 'package:lykluk/modules/ecommerce/domain/repo/product_repository.dart';
import 'package:lykluk/utils/pagination/pagination.dart';
import 'package:lykluk/utils/storage/local_storage.dart';

import '../../../../core/services/queue_system/queue_service.dart';
import '../../../../core/shared/resources/failure.dart';
import '../../../../core/shared/resources/response_data.dart';
import '../../model/market_models.dart';
import '../ecommerce_services/product_image_uploader.dart';
import '../ecommerce_services/upload_event.dart';
import '../market_contants.dart/market_endpoints.dart';

final productRepoProvider = Provider((ref) {
  return ProductRepoImpl(
    ref.read(apiServiceProvider),
    ref.read(queueServiceProvider),
    getIt<ProductImageUploadService>(),
  );
});

class ProductRepoImpl implements ProductRepository {
  final ApiService _apiService;
  final QueueService _queueService;
  final ProductImageUploadService _productImageUploadService;

  const ProductRepoImpl(
    this._apiService,
    this._queueService,
    this._productImageUploadService,
  );

  @override
  FutureResponse<ProductModel> createProduct({
    required Map<String, dynamic> data,
  }) async {
    try {
      final res = await _apiService.postData(
        MarketEndpoints.createProduct,
        hasHeader: true,
        body: data,
      );
      if (res.isSuccessful) {
        final raw = Map<String, dynamic>.from(res.data as Map)['data'];
        final result = ProductModel.fromJson(raw['product']);
        return Right(ResponseData(data: result, message: ""));
      } else {
        return Left(Failure(res.message ?? "Unable to create product"));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason:
            "productRepoProvider-- Unable to create product, please try again later",
      );
      return Left(Failure("Somthing went wrong, please try again later"));
    }
  }

  @override
  FutureResponse<Map> deleteProduct({required String productId}) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  FutureResponse<PaginatedResponse<ProductModel>> getFeaturedProduct({
    required Map<String, dynamic> query,
  }) {
    // TODO: implement getFeaturedProduct
    throw UnimplementedError();
  }

  @override
  FutureResponse<ProductModel> getProduct({required int productId}) async {
    try {
      final res = await _apiService.getData(
        MarketEndpoints.getProduct.replaceFirst('id', productId.toString()),
        hasHeader: true,
      );
      if (res.isSuccessful) {
        final raw = Map<String, dynamic>.from(res.data as Map)['data'];
        final result = ProductModel.fromJson(raw['product']);
        return Right(ResponseData(data: result, message: ""));
      } else {
        return Left(Failure(res.message ?? ""));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason:
            "productRepoProvider-- Unable to load  product, please try again later",
      );
      return Left(Failure("Somthing went wrong, please try again later"));
    }
  }

  @override
  FutureResponse<PaginatedResponse<ProductModel>> getProducts({
    required Map<String, dynamic> query,
  }) async {
    try {
      final res = await _apiService.getData(
        MarketEndpoints.getProducts,
        queryParameters: query,
        hasHeader: true,
      );
      if (res.isSuccessful) {
        final raw = Map<String, dynamic>.from(res.data as Map)['data'];
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
            "productRepoProvider-- Unable to load my products, please try again later",
      );
      return Left(Failure("Somthing went wrong, please try again later"));
    }
  }

  @override
  FutureResponse<PaginatedResponse<ProductModel>> getMyProducts({
    required Map<String, dynamic> query,
  }) async {
    try {
      final res = await _apiService.getData(
        MarketEndpoints.getMyProducts,
        queryParameters: query,
        hasHeader: true,
      );
      if (res.isSuccessful) {
        final raw = Map<String, dynamic>.from(res.data as Map)['data'];
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
        return Right(ResponseData(data: result, message: res.message ?? ""));
      } else {
        return Left(Failure(res.message ?? ""));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason:
            "productRepoProvider-- Unable to load my products, please try again later",
      );
      return Left(Failure("Somthing went wrong, please try again later"));
    }
  }

  @override
  FutureResponse<ProductModel> updatetInventory({
    required Map<String, dynamic> data,
  }) {
    // TODO: implement updatetInventory
    throw UnimplementedError();
  }

  @override
  FutureResponse<ProductModel> updatetProduct({
    required Map<String, dynamic> data,
  }) {
    // TODO: implement updatetProduct
    throw UnimplementedError();
  }

  @override
  FutureResponse<StringMap<bool>> saveProduct({
    required String productId,
  }) async {
    try {
      final res = await _apiService.postData(
        MarketEndpoints.saveProduct.replaceFirst("{id}", productId),
        hasHeader: true,
      );
      if (res.isSuccessful) {
        // final raw = Map<String, dynamic>.from(res.data as Map)['data'];
        // final saved = ProductModel.fromJson(raw['product']);
        return Right(ResponseData(data: {"isSaved": true}, message: ""));
      } else {
        /// add to queue
        _queueService.addToQueue(
          endpoint: MarketEndpoints.saveProduct.replaceFirst("{id}", productId),
          method: 'POST',
          hasHeaders: true,
        );
        return Right(
          ResponseData(data: {"isSaved": true}, message: res.message ?? ""),
        );
        // return Left(Failure(res.message ?? ""));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "ProductRepoImpl-- Unable to save product",
      );
      // return Left(Failure("Somthing went wrong, please try again later"));
      // /// add to queue
      _queueService.addToQueue(
        endpoint: MarketEndpoints.saveProduct.replaceFirst("{id}", productId),
        method: 'POST',
        hasHeaders: true,
      );
      return Right(ResponseData(data: {"isunSaved": true}, message: ""));
    }
  }

  @override
  FutureResponse<StringMap<bool>> unSaveProduct({
    required String productId,
  }) async {
    try {
      final res = await _apiService.deleteData(
        MarketEndpoints.unSaveProduct.replaceFirst("{id}", productId),
        hasHeader: true,
      );
      if (res.isSuccessful) {
        final raw = Map<String, dynamic>.from(res.data as Map);
        final result = Map<String, bool>.from(raw["data"] ?? {});
        return Right(ResponseData(data: result, message: ""));
      } else {
        // // /// add to queue
        _queueService.addToQueue(
          endpoint: MarketEndpoints.unSaveProduct.replaceFirst(
            "{id}",
            productId,
          ),
          method: 'DELETE',
          hasHeaders: true,
        );
        return Right(
          ResponseData(data: {"isSaved": false}, message: res.message ?? ""),
        );
        // return Left(Failure(res.message ?? ""));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "ProductRepoImpl-- Unable to unsave product",
      );
      // return Left(Failure("Somthing went wrong, please try again later"));

      // / add to queue
      _queueService.addToQueue(
        endpoint: MarketEndpoints.unSaveProduct.replaceFirst("{id}", productId),
        method: 'DELETE',
        hasHeaders: true,
      );
      return Right(ResponseData(data: {"isSaved": true}, message: ""));
    }
  }

  @override
  FutureResponse<PaginatedResponse<ProductModel>> getSavedProduct({
    required Map<String, dynamic> query,
  }) async {
    try {
      final res = await _apiService.getData(
        MarketEndpoints.getSavedProducts,
        queryParameters: query,
        hasHeader: true,
      );
      if (res.isSuccessful) {
        final raw = Map<String, dynamic>.from(res.data as Map)['data'];
        final result = await Isolate.run(() {
          final listValues = (raw['savedProducts'] as List).map(
            (e) => ProductModel.fromJson(e["product"]),
          );
          final pagination = raw['pagination'];
          final values = PaginatedResponse(
            dataList: listValues.toList(),
            limit: pagination['limit'] ?? 10,
            page: pagination['page'] ?? 1,
            total: pagination['total'] ?? 0,
            pages: pagination['totalPages'] ?? 1,
          );
          // final values = PaginatedResponse.fromJson(
          //   fieldName: "savedProducts",
          //   json: raw,
          //   paginationField: 'pagination',
          //   dataFromJson:
          //       (d) => SavedProductModel.fromJson( d as Map<String, dynamic> ),
          // );
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
            "productRepoProvider-- Unable to load saved products, please try again later",
      );
      return Left(Failure("Somthing went wrong, please try again later"));
    }
  }

  @override
  Stream<UploadEvent> onUploadProgress() {
    return _productImageUploadService.stream;
  }

  @override
  FutureResponse<bool> uploadProductImage({
    required List<String> images,
    required int productId,
    required int storeId,
  }) async {
    try {
      return await _productImageUploadService
          .enqueueUpload(
            HiveStorage.accessToken,
            PendingUpload(
              productId: productId.toString(),
              imagePaths: images,
              storeId: storeId,
            ),
          )
          .then((v) {
            return Right(ResponseData(data: true, message: ""));
          });
    } catch (e) {
      LoggerService.logError(
        error: e,
        reason: "ProductRepoImpl-- Unable to upload product image",
      );
      return Left(Failure("Somthing went wrong, please try again later"));
    }
  }
}
