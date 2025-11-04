import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/services/services.dart';
import 'package:lykluk/core/shared/resources/typedefs.dart';
import 'package:lykluk/modules/ecommerce/model/carrier_model.dart';
import 'package:lykluk/modules/ecommerce/domain/repo/market_repositories.dart';

import '../../../../core/shared/resources/failure.dart';
import '../../../../core/shared/resources/response_data.dart';
import '../../../../utils/assets_manager.dart';
import '../market_contants.dart/market_endpoints.dart';

final logisticsRepoRepoProvider = Provider<LogisticsRepository>((ref){
  final apiService= ref.read(apiServiceProvider);
  return LogisticsRepoImpl(apiService);
});

class LogisticsRepoImpl implements LogisticsRepository {
  final ApiService _apiService;
  const LogisticsRepoImpl(this._apiService);
  @override
  FutureResponse<List<CarrierModel>> getAvailableCarriers({
    required Map<String, dynamic> query,
  }) async {
    try {
      final res = await _apiService.getData(
        MarketEndpoints.getAvailableCarriers,
        queryParameters: query,
        hasHeader: true,
      );
      if (res.isSuccessful) {
        final raw = Map<String, dynamic>.from(res.data as Map)['data'];
        final rawList = raw['carriers'] as List;
        final carriers = rawList.map((e) => CarrierModel.fromJson(e)).toList();
        return Right(ResponseData(data: carriers, message: ""));
      } else {
        return Left(Failure(res.message ?? ""));
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason:
            "StoreRepo-- Unable to load available carriers, please try again later",
      );
      return Left(Failure("Somthing went wrong, please try again later"));
    }
  }
}
// ignore: unused_element
const _logistics = [
  ImageAssets.absLogisticsImage,
  ImageAssets.boltImage,
  ImageAssets.kiwkLogisticsImage,
  ImageAssets.gigLogisticsImage,
  ImageAssets.dhlLogisticsImage,
  ImageAssets.upsLogisticsImage,
  ImageAssets.sltLogisticsImage,
];

