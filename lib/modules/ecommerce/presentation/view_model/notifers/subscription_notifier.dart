import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/ecommerce/data/repo_impl/subscription_repo_impl.dart';
import 'package:lykluk/modules/ecommerce/domain/repo/market_repositories.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/state/subscription_state.dart';

import '../../../../../core/services/logger_service.dart';

final subscriptionNotifierProvider =NotifierProvider<SubscriptionNotifier, SubscriptionState>( SubscriptionNotifier.new);

class SubscriptionNotifier extends Notifier<SubscriptionState> {
 late  final  SubscriptionRepository _subscriptionRepository;
  @override
   build() {
    _subscriptionRepository =  ref.read(subscriptionRepoProvider);
     return SubscriptionState.initial();
  }

  void  updateMyPlan(String plan)async{
     try {
      state = SubscriptionState.updatingSubscription();

      final result = await _subscriptionRepository.updateSubscription(data:{'plan': plan});
      result.fold(
        (l) {
          state = SubscriptionState.updatingSubscriptionFailed( l.message);
        },
        (r) async {
          state = SubscriptionState.updatedSubscription(subscription: r.data, message: r.message);
        },
      );
    } catch (e) {
      log.e(e.toString());
      state = SubscriptionState.updatingSubscriptionFailed( e.toString());
    }
  }

}