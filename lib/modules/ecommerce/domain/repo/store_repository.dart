import 'package:lykluk/core/shared/resources/typedefs.dart';
import 'package:lykluk/utils/pagination/pagination.dart';

import '../../../chats/data/models/user_model.dart';
import '../../model/market_models.dart';
import '../../model/order_model.dart';
import '../../model/store_analytics_model.dart';

abstract class StoreRepository {
  /// create store
  FutureResponse<StoreModel> createStore({required Map<String, dynamic> data});

  /// get store by id

  FutureResponse<StoreModel> getStoreById({required int storeId});

  /// get my store
  FutureResponse<PaginatedResponse<StoreModel>> getMyStores({
    required Map<String, dynamic> query,
  });

  /// get stores
  FutureResponse<PaginatedResponse<StoreModel>> getStores({
    required Map<String, dynamic> query,
  });

  /// update store
  FutureResponse<StoreModel> updateStore({required Map<String, dynamic> data});

  /// update store setting
  FutureResponse<StoreModel> updateStoreSetting({
    required Map<String, dynamic> data,
  });

  /// set preffered logistics carrier for store
  FutureResponse<StringMap> setStoreCarriers({
    required Map<String, dynamic> data,
    required int storeId,
  });

  /// verify store indentity
  FutureResponse<StringMap> verifyStoreIndentity({
    required Map<String, dynamic> data,
  });

  /// verify store
  FutureResponse<StoreModel> verifyStore({
    required Map<String, dynamic> data,
    required int storeId,
  });

  /// reject store
  FutureResponse<StoreModel> rejectStore({
    required Map<String, dynamic> data,
    required int storeId,
  });

  ///  upload store documents
  FutureResponse<String> uploadStoreDocument({
    required Map<String, dynamic> data,
    required Function(double) onProgress,
  });

  /// get store products
  FutureResponse<PaginatedResponse<ProductModel>> getStoreProducts({
    required int storeId,
    required Map<String, dynamic> query,
  });

  /// get store orders
  FutureResponse<PaginatedResponse<OrderModel>> getStoreOrders({
    required int storeId,
    required Map<String, dynamic> query,
  });

  /// get store analytics
  FutureResponse<StoreAnalyticsModel> getStoreAnalytics({
    required int storeId,
    required Map<String, dynamic> query,
  });

  /// follow store
  FutureResponse<StringMap> followStore({required int storeId});

  /// unfollow store
  FutureResponse<StringMap> unfollowStore({required int storeId});

  /// get store followers
  FutureResponse<PaginatedResponse<UserModel>> getStoreFollowers({
    required int storeId,
    required Map<String, dynamic> query,
  });
}
