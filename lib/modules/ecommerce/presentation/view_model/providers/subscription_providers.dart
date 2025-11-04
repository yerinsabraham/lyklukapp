import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/ecommerce/data/repo_impl/subscription_repo_impl.dart';
import 'package:lykluk/modules/ecommerce/domain/repo/subscription_repository.dart';
import 'package:lykluk/modules/ecommerce/model/subscription_model.dart';
import 'package:lykluk/utils/mixins/async_mixins.dart';

/// current store subscription provider
final currentStoreSubscriptionProvider = AsyncNotifierProviderFamily<CurrentStoreSubscriptionNotifier, SubscriptionModel,int>(CurrentStoreSubscriptionNotifier.new);

class CurrentStoreSubscriptionNotifier
    extends FamilyAsyncNotifier<SubscriptionModel, int>
    with AsyncMixins {
  late SubscriptionRepository _subscriptionRepository;
  @override
  FutureOr<SubscriptionModel> build(arg) {
    _subscriptionRepository = ref.read(subscriptionRepoProvider);
    onAuthStateChanged(
      initialData: SubscriptionModel.empty(),
      onAuthenicated: () {
        ref.invalidateSelf();
      },
    );
    return fetchSubscription();
  }

  FutureOr<SubscriptionModel> fetchSubscription() async {
    try {
      final response = await _subscriptionRepository.getCurrentSubscriptionPlan(
        storeId: arg,
      );
      return response.fold(
        (l) {
          return Future.error(l.message);
        },
        (r) {
          return r.data;
        },
      );
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
final allSubscriptionsProvider = AsyncNotifierProvider<
  AllSubscriptionsNotifier, List<SubscriptionModel>>(
      AllSubscriptionsNotifier.new);

class AllSubscriptionsNotifier
    extends AsyncNotifier<List<SubscriptionModel>>
    with AsyncMixins {
  late SubscriptionRepository _subscriptionRepository;
  @override
  FutureOr<List<SubscriptionModel>> build() {
    _subscriptionRepository = ref.read(subscriptionRepoProvider);
    onAuthStateChanged(
      initialData: [],
      onAuthenicated: () {
        ref.invalidateSelf();
      },
    );
    return fetchSubscriptions();
  }

  FutureOr<List<SubscriptionModel>> fetchSubscriptions() async {
    try {
      final response = await _subscriptionRepository.getAllSubscriptionPlans();
      return response.fold(
        (l) {
          return Future.error(l.message);
        },
        (r) {
          return r.data;
        },
      );
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
