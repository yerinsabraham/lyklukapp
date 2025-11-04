import 'package:lykluk/modules/ecommerce/model/subscription_model.dart';

import '../../../../core/shared/resources/typedefs.dart';

abstract class SubscriptionRepository {

  FutureResponse<List<SubscriptionModel>> getAllSubscriptionPlans();
  /// update my subscription 
  FutureResponse<StringMap> updateSubscription({ required Map<String, dynamic> data });

  /// get usage analytics
  FutureResponse<StringMap> getUsageAnalytics();

  /// record feature usage
  FutureResponse<StringMap> recordFeatureUsage(String featureName);

  /// get current subscription plan for a store
  FutureResponse<SubscriptionModel> getCurrentSubscriptionPlan({ required int storeId });


}
