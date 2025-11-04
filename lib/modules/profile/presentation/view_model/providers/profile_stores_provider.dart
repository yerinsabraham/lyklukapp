import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/ecommerce/domain/repo/market_repositories.dart';

import '../../../../../core/services/services.dart';
import '../../../../../utils/pagination/pagination.dart';
import '../../../../ecommerce/data/repo_impl/market_repo_impls.dart';
import '../../../../ecommerce/model/store_model.dart';
import '../../../../ecommerce/presentation/view_model/notifers/store_notifier.dart';


final profilestoresProvider =
    AsyncNotifierProviderFamily<ProfileStoreNotifier, PaginatedResponse<StoreModel>, String>(
      ProfileStoreNotifier.new,
    );

class ProfileStoreNotifier extends FamilyAsyncNotifier<PaginatedResponse<StoreModel>, String>
    with PaginationController<StoreModel> {
  late AnalyticsService analyticsService;
  late StoreRepository storeRepository;
  @override
  FutureOr<PaginatedResponse<StoreModel>> build(arg) {
    analyticsService = ref.read(analyticsServiceProvider);
    storeRepository = ref.read(storeRepoProvider);
    onNetworkStateChanged();
    onAuthStateChanged();
    onStoreUpdate();
    return loadData(PaginatedRequest());
  }

  @override
  FutureOr<PaginatedResponse<StoreModel>> loadData(
    PaginatedRequest request,
  ) async {
    try {
      final res = await storeRepository.getStores(query: request.toJson());
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

  void onStoreUpdate() {
    ref.listen(storeNotifierProvider, (p, n) {
      n.maybeWhen(
        orElse: () {},
        storeCreated: (store, msg) {
          addTop(store);
        },
        storeUpdated: (store, msg) {
          findAndReplace(model: store);
        },
        settingCarriersSuccess: (msg, data) {},
      );
    });
  }
}
