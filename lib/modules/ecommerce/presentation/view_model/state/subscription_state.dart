import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/shared/resources/typedefs.dart';

part 'subscription_state.freezed.dart';

@freezed
class SubscriptionState with _$SubscriptionState {
  const factory SubscriptionState.initial() = SubscriptionInitial;


  /// updating Subscription
  const factory SubscriptionState.updatingSubscription() = SubscriptionUpdating;
  const factory SubscriptionState.updatedSubscription({required StringMap subscription, required String message}) =
      SubscriptionUpdated;
  const factory SubscriptionState.updatingSubscriptionFailed(String message) =  SubscriptionUpdatingFailed;
}
