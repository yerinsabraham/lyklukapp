import 'package:fpdart/fpdart.dart';
import 'package:lykluk/core/shared/resources/typedefs.dart';

import 'package:lykluk/modules/ecommerce/model/category_model.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../core/services/logger_service.dart';
import '../../../../core/services/network/api_service.dart';

import '../../../../core/shared/resources/failure.dart';
import '../../../../core/shared/resources/response_data.dart';
import '../../domain/repo/categories_repository.dart';
import '../market_contants.dart/market_endpoints.dart';

final categoriesRepoProvider = Provider((ref) {
  final api = ref.read(apiServiceProvider);
  return CategoriesRepoImpl(api);
});

class CategoriesRepoImpl implements CategoriesRepository {
  final ApiService _apiService;

  const CategoriesRepoImpl(this._apiService);

  @override
  FutureResponse<List<CategoryModel>> getAllCategories() async {
    try {
      final res = await _apiService.getData(
        MarketEndpoints.getAllCategories,
        hasHeader: true,
      );
      if (res.isSuccessful) {
        final raw = Map<String, dynamic>.from(res.data as Map)['data'];
        final list =
            (raw['categories'] as List)
                .map((e) => CategoryModel.fromJson(e))
                .toList();
        return Right(ResponseData(data: list, message: res.message ?? ""));
      } else {
        return Left(Failure(res.message ?? ""));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason:
            "CategoriesRepoImpl-- Unable to load categories, please try again later",
      );
      return Left(Failure("Somthing went wrong, please try again later"));
    }
  }

  @override
  FutureResponse<CategoryModel> getCategoriesId({required int id}) async {
    try {
      final res = await _apiService.getData(
        MarketEndpoints.getCategory.replaceFirst('id', id.toString()),
        hasHeader: true,
      );
      if (res.isSuccessful) {
        final raw = Map<String, dynamic>.from(res.data as Map)['data'];
        final v = CategoryModel.fromJson(raw['category']);

        return Right(ResponseData(data: v, message: res.message ?? ""));
      } else {
        return Left(Failure(res.message ?? ""));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason:
            "CategoriesRepoImpl-- Unable to load category, please try again later",
      );
      return Left(Failure("Somthing went wrong, please try again later"));
    }
  }

  @override
  FutureResponse<List<CategoryModel>> getRootCategories() async {
    try {
      final res = await _apiService.getData(
        MarketEndpoints.getRootCategories,

        hasHeader: true,
      );
      if (res.isSuccessful) {
        final raw = Map<String, dynamic>.from(res.data as Map)['data'];
        final list =
            (raw['categories'] as List)
                .map((e) => CategoryModel.fromJson(e))
                .toList();
        return Right(ResponseData(data: list, message: res.message ?? ""));
      } else {
        return Left(Failure(res.message ?? ""));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "-- Unable to load  root categories, please try again later",
      );
      return Left(Failure("Somthing went wrong, please try again later"));
    }
  }
}
