import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lykluk/modules/ecommerce/model/carrier_model.dart';
import 'package:lykluk/modules/ecommerce/domain/repo/logistics_repository.dart';
import 'package:lykluk/utils/mixins/async_mixins.dart';

import '../../../../../core/services/services.dart';
import '../../../data/repo_impl/market_repo_impls.dart';

final availableCarriersProvider =
    AsyncNotifierProvider<AvailableCarriersNotifier, List<CarrierModel>>(
      AvailableCarriersNotifier.new,
    );

class AvailableCarriersNotifier extends AsyncNotifier<List<CarrierModel>>
    with AsyncMixins {
  late final LogisticsRepository logisticsRepository;  
  @override
  FutureOr<List<CarrierModel>> build() {
    logisticsRepository = ref.read(logisticsRepoRepoProvider);
    onNetworkStatusChange();
    onAuthStateChanged(
      initialData: [],
      onAuthenicated: () {
        ref.invalidateSelf();
      },
    );
    return loadData(query: {});
  }

  FutureOr<List<CarrierModel>> loadData({
    required Map<String, dynamic> query,
  }) async {
    try {
      final res = await logisticsRepository.getAvailableCarriers(query: query);
      return res.fold(
        (l) {
          return Future.error(l.message);
        },
        (r) {
          return r.data;
        },
      );
    } catch (e, s) {
      log.e(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }
}
