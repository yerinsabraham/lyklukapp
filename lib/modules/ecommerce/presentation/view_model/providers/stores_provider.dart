import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/ecommerce/data/ecommerce_services/upload_event.dart';
import 'package:lykluk/modules/ecommerce/domain/repo/market_repositories.dart';

import '../../../../../core/services/services.dart';
import '../../../../../utils/pagination/pagination.dart';
import '../../../data/repo_impl/market_repo_impls.dart';
import '../../../model/market_models.dart';
import '../../../model/order_model.dart';
import '../mixins/order_mixin.dart';
import '../mixins/product_mixins.dart';
import '../notifers/product_notifier.dart';
import '../notifers/store_notifier.dart';

final storesProvider =
    AsyncNotifierProvider<ProductsNotifier, PaginatedResponse<StoreModel>>(
      ProductsNotifier.new,
    );

class ProductsNotifier extends AsyncNotifier<PaginatedResponse<StoreModel>>
    with PaginationController<StoreModel> {
  late AnalyticsService analyticsService;
  late StoreRepository storeRepository;
  @override
  FutureOr<PaginatedResponse<StoreModel>> build() {
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

final myStoresProvider =
    AsyncNotifierProvider<MyStoresNotifier, PaginatedResponse<StoreModel>>(
      MyStoresNotifier.new,
    );

class MyStoresNotifier extends AsyncNotifier<PaginatedResponse<StoreModel>>
    with PaginationController<StoreModel> {
  late AnalyticsService analyticsService;
  late StoreRepository storeRepository;
  @override
  FutureOr<PaginatedResponse<StoreModel>> build() {
    analyticsService = ref.read(analyticsServiceProvider);
    storeRepository = ref.read(storeRepoProvider);
    onNetworkStateChanged();
    onAuthStateChanged( canRefreshSelf: true);
    onStoreUpdate();
    return loadData(PaginatedRequest());
  }

  @override
  FutureOr<PaginatedResponse<StoreModel>> loadData(
    PaginatedRequest request,
  ) async {
    try {
      final res = await storeRepository.getMyStores(query: request.toJson());
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

/// store products provider

final storeProductsProvider = AsyncNotifierProviderFamily<
  StoreProductsNotifier,
  PaginatedResponse<ProductModel>,
  int
>(StoreProductsNotifier.new);

class StoreProductsNotifier
    extends FamilyAsyncNotifier<PaginatedResponse<ProductModel>, int>
    with PaginationController<ProductModel>, ProductMixin {
  late AnalyticsService analyticsService;
  late StoreRepository storeRepository;
  late ProductRepository productRepository;
  @override
  FutureOr<PaginatedResponse<ProductModel>> build(arg) {
    productRepository = ref.read(productRepoProvider);
    analyticsService = ref.read(analyticsServiceProvider);
    storeRepository = ref.read(storeRepoProvider);
    onNetworkStateChanged();
    onAuthStateChanged();
    productImageUpdate();
    onProductUpdate();
    return loadData(PaginatedRequest(page: 1, limit: 20));
  }

  @override
  FutureOr<PaginatedResponse<ProductModel>> loadData(
    PaginatedRequest request,
  ) async {
    try {
      final res = await storeRepository.getStoreProducts(
        query: request.toJson(),
        storeId: arg,
      );
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

  void onProductUpdate() {
    ref.listen(productNotifierProvider, (p, n) {
      n.maybeWhen(
        orElse: () {},
        createdProduct: (product, message) {
          if (product.store?.id == arg) {
            addTop(product);
          }
        },
        saveProduct: (p) {
          if (p.store?.id == arg) {
            findAndReplace(model: p);
          }
        },
      );
    });
  }

  void productImageUpdate() {
    productRepository.onUploadProgress().listen((event) {
      if (event is UploadSuccess && event.storeId == arg) {
        findAndUpdate(
          where: (p) => p.id == int.parse(event.productId),
          update: (p) {
            return p.copyWith(images: event.imageUrls);
          },
        );
      }
    });
  }
}

/// store orders provider
final storeOrdersProvider = AsyncNotifierProviderFamily<
  StoreOrdersNotifier,
  PaginatedResponse<OrderModel>,
  int
>(StoreOrdersNotifier.new);

class StoreOrdersNotifier
    extends FamilyAsyncNotifier<PaginatedResponse<OrderModel>, int>
    with PaginationController<OrderModel>, OrderMixin {
  late AnalyticsService analyticsService;
  late StoreRepository storeRepository;
  @override
  FutureOr<PaginatedResponse<OrderModel>> build(arg) {
    analyticsService = ref.read(analyticsServiceProvider);
    storeRepository = ref.read(storeRepoProvider);
    onNetworkStateChanged();
    onAuthStateChanged();
    onOrderUpdate();
    return loadData(PaginatedRequest(page: 1, limit: 20));
  }

  @override
  FutureOr<PaginatedResponse<OrderModel>> loadData(
    PaginatedRequest request,
  ) async {
    try {
      final res = await storeRepository.getStoreOrders(
        query: request.toJson(),
        storeId: arg,
      );
      return res.fold(
        (l) {
          // return Future.error(l.message);
          return PaginatedResponse(
            dataList: List.filled(5, _orders),
            fieldName: "",
          );
        },
        (r) {
          // return r.data;
          return PaginatedResponse(
            dataList: List.filled(5, _orders),
            fieldName: "",
          );
        },
      );
    } catch (e, s) {
      log.e(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }
}

final _orders = OrderModel(
  id: '1',
  productName: 'Stanley cup',
  totalPrice: 500000,
  quantity: 10,
  status: 'pending',
);
