import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lykluk/core/services/services.dart';
import 'package:lykluk/core/shared/resources/typedefs.dart';
import 'package:lykluk/modules/ecommerce/model/subscription_model.dart';
import '../market_contants.dart/market_endpoints.dart';
import '../../../../core/shared/resources/failure.dart';
import '../../../../core/shared/resources/response_data.dart';
import '../../domain/repo/subscription_repository.dart';

final subscriptionRepoProvider = Provider<SubscriptionRepository>(
    (ref) => SubscriptionRepoImpl(ref.read(apiServiceProvider))); 

class SubscriptionRepoImpl implements SubscriptionRepository {
  final ApiService _apiService;
  const SubscriptionRepoImpl(this._apiService);
  @override
  FutureResponse<List<SubscriptionModel>> getAllSubscriptionPlans() async{
    try {
      final res = await _apiService.getData(
        MarketEndpoints.getSubscriptions,
        hasHeader: true,
      );
      if (res.isSuccessful) {
        final raw = Map<String, dynamic>.from(res.data as Map)['data'];
        final list =
            (raw as List)
                .map((e) => SubscriptionModel.fromJson(e))
                .toList();
        return Right(ResponseData(data: list, message: res.message ?? ""));
      } else {
        return Left(Failure(res.message ?? ""));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "subscriptionRepoImpl-- Unable to load subscription plans, please try again later",
      );
      return Left(Failure("Somthing went wrong, please try again later"));
    }
  }

  @override
  FutureResponse<StringMap> getUsageAnalytics() {
    // TODO: implement getUsageAnalytics
    throw UnimplementedError();
  }

  @override
  FutureResponse<StringMap> recordFeatureUsage(String featureName) {
    // TODO: implement recordFeatureUsage
    throw UnimplementedError();
  }

  @override
  FutureResponse<StringMap> updateSubscription({required Map<String, dynamic> data})async {
      try {
      final res = await _apiService.postData(
        MarketEndpoints.updateSubscription,
        hasHeader: true,
      );
      if (res.isSuccessful) {
        final raw = Map<String, dynamic>.from(res.data as Map);
        final  strMap= Map<String, dynamic>.from(raw['data']);
        return Right(ResponseData(data: strMap, message: res.message ?? ""));
      } else {
        return Left(Failure(res.message ?? ""));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "subscriptionRepoImpl-- Unable to update subscription, please try again later",
      );
      return Left(Failure("Somthing went wrong, please try again later"));
    }
  }
  
  @override
  FutureResponse<SubscriptionModel> getCurrentSubscriptionPlan({required int storeId})async {
      try {
      final res = await _apiService.getData(
        MarketEndpoints.getMySubscriptions,
        hasHeader: true,
      );
      if (res.isSuccessful) {
        final raw = Map<String, dynamic>.from(res.data as Map)['data'];
        final  strMap= SubscriptionModel.fromJson(raw);
        return Right(ResponseData(data: strMap, message: res.message ?? ""));
      } else {
        return Left(Failure(res.message ?? ""));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "subscriptionRepoImpl-- Unable to update subscription, please try again later",
      );
      return Left(Failure("Somthing went wrong, please try again later"));
    }
  }

}
