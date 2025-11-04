import 'dart:isolate';

import 'package:fpdart/fpdart.dart';
import 'package:lykluk/core/services/services.dart';
import 'package:lykluk/core/shared/resources/failure.dart';
import 'package:lykluk/core/shared/resources/typedefs.dart';
import 'package:lykluk/modules/ecommerce/domain/repo/market_repositories.dart';
import 'package:lykluk/modules/ecommerce/model/product_model.dart';
import 'package:lykluk/utils/pagination/pagination.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../core/shared/resources/response_data.dart';
import '../market_contants.dart/market_endpoints.dart';

final productRecommendationRepoProvider = Provider<ProductRecommendationRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return ProductRecommendationRepoImpl(apiService);
});

class ProductRecommendationRepoImpl   implements ProductRecommendationRepository{
  final ApiService _apiService;
  const ProductRecommendationRepoImpl(this._apiService);
  @override
  FutureResponse<PaginatedResponse<ProductModel>> getFollowingStoreRecommendations({
    required Map<String, dynamic> query,
  })async {
     try {
      final res = await _apiService.getData(
        MarketEndpoints.getFollowingStoreRecommendations,
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
            "UtilsRepo-- Unable to load my following store recommended products, please try again later",
      );
      return Left(Failure("Somthing went wrong, please try again later"));
    }
  }

  @override
  FutureResponse<PaginatedResponse<ProductModel>> getFypRecommendations({
    required Map<String, dynamic> query,
  })async {
     try {
      final res = await _apiService.getData(
        MarketEndpoints.getFYRecommendations,
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
            "UtilsRepo-- Unable to load my fyp recommended products, please try again later",
      );
      return Left(Failure("Somthing went wrong, please try again later"));
    }
  }

  @override
  FutureResponse<PaginatedResponse<ProductModel>> getPopularRecommendations({
    required Map<String, dynamic> query,
  })async {
    try {
      final res = await _apiService.getData(
        MarketEndpoints.getPopularProducts,
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
            "UtilsRepo-- Unable to load popular products, please try again later",
      );
      return Left(Failure("Somthing went wrong, please try again later"));
    }
  }

  @override
  FutureResponse<PaginatedResponse<ProductModel>> getTrendingRecommendations({
    required Map<String, dynamic> query,
  })async {
   try {
      final res = await _apiService.getData(
        MarketEndpoints.getTrendingProducts,
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
            "UtilsRepo-- Unable to load trending products, please try again later",
      );
      return Left(Failure("Somthing went wrong, please try again later"));
    }
  }

}