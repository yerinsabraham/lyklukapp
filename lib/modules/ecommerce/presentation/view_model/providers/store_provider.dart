import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/ecommerce/domain/repo/market_repositories.dart';
import 'package:lykluk/utils/mixins/async_mixins.dart';

import '../../../../../core/services/services.dart';
import '../../../model/market_models.dart';
import '../../../data/repo_impl/market_repo_impls.dart';

final storeProvider =
    AsyncNotifierProviderFamily<StoreNotifier, StoreModel, int>(
      StoreNotifier.new,
    );

class StoreNotifier extends FamilyAsyncNotifier<StoreModel, int>
    with AsyncMixins {
  late AnalyticsService analyticsService;
  late StoreRepository storeRepository;
  @override
  FutureOr<StoreModel> build(arg) {
    analyticsService = ref.read(analyticsServiceProvider);
    storeRepository = ref.read(storeRepoProvider);
    onNetworkStatusChange();
    onAuthStateChanged(initialData: StoreModel.empty());
    return loadData();
  }

  FutureOr<StoreModel> loadData() async {
    try {
      final res = await storeRepository.getStoreById(storeId: arg);
      return res.fold(
        (l) {
          return Future.error(l.message);
          // return demoStoreModel;
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
