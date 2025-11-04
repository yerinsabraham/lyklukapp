import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/ecommerce/domain/repo/market_repositories.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/mixins/product_mixins.dart';
import '../../../../../core/services/services.dart';
import '../../../../../utils/pagination/pagination.dart';
import '../../../data/repo_impl/market_repo_impls.dart';
import '../../../model/market_models.dart';
import '../notifers/product_notifier.dart';


final fypProductsProvider =
    AsyncNotifierProvider<FypProductsNotifier, PaginatedResponse<ProductModel>>(
      FypProductsNotifier.new,
    );

class FypProductsNotifier extends AsyncNotifier<PaginatedResponse<ProductModel>>
    with PaginationController<ProductModel>, ProductMixin {
  late AnalyticsService analyticsService;
  late ProductRecommendationRepository productRecommendationRepository;
  @override
  FutureOr<PaginatedResponse<ProductModel>> build() {
    analyticsService = ref.read(analyticsServiceProvider);
    productRecommendationRepository = ref.read(
      productRecommendationRepoProvider,
    );
    onNetworkStateChanged();
  onAuthStateChanged(canRefreshSelf: true);
    onProductUpdate();
    return loadData(
      PaginatedRequest(page: 1, limit: 20, filter: {"excludeViewed": true}),
    );
  }

  @override
  FutureOr<PaginatedResponse<ProductModel>> loadData(
    PaginatedRequest request,
  ) async {
    try {
      final res = await productRecommendationRepository.getFypRecommendations(
        query: request.toJson(),
      );
      return res.fold(
        (l) {
          return Future.error(l.message);
         
        },
        (r) {
          //  return PaginatedResponse(
          //   dataList: List.filled(10, singleDemoproduct),
          //   fieldName: "",
          // );
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
        saveProduct: (p) {
          findAndReplace(model: p, );
        },
          unsaveProduct: (p) {
          findAndReplace(model: p);
        },
        saveProductFailed: (m, p) {
          findAndReplace(model: p);
        }
      );
    });
  }

}

final trendingProductsProvider = AsyncNotifierProvider<
  TrendingProductsNotifier,
  PaginatedResponse<ProductModel>
>(TrendingProductsNotifier.new);

class TrendingProductsNotifier
    extends AsyncNotifier<PaginatedResponse<ProductModel>>
    with PaginationController<ProductModel>, ProductMixin {
  late AnalyticsService analyticsService;
  late ProductRecommendationRepository productRecommendationRepository;
  @override
  FutureOr<PaginatedResponse<ProductModel>> build() {
    analyticsService = ref.read(analyticsServiceProvider);
    productRecommendationRepository = ref.read(
      productRecommendationRepoProvider,
    );
    onNetworkStateChanged();
onAuthStateChanged(canRefreshSelf: true);
    onProductUpdate();
    return loadData(PaginatedRequest(page: 1, limit: 20));
  }

  @override
  FutureOr<PaginatedResponse<ProductModel>> loadData(
    PaginatedRequest request,
  ) async {
    try {
      final res = await productRecommendationRepository
          .getTrendingRecommendations(query: request.toJson());
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
        saveProduct: (p) {
          findAndReplace(model: p, );
        },
         unsaveProduct: (p) {
          findAndReplace(model: p);
        },
        saveProductFailed: (m,p){
           findAndReplace(model: p);
        }
      );
    });
  }

}

final popularProductsProvider = AsyncNotifierProvider<
  PopularProductsNotifier,
  PaginatedResponse<ProductModel>
>(PopularProductsNotifier.new);

class PopularProductsNotifier
    extends AsyncNotifier<PaginatedResponse<ProductModel>>
    with PaginationController<ProductModel>, ProductMixin {
  late AnalyticsService analyticsService;
  late ProductRecommendationRepository productRecommendationRepository;
  @override
  FutureOr<PaginatedResponse<ProductModel>> build() {
    analyticsService = ref.read(analyticsServiceProvider);
    productRecommendationRepository = ref.read(
      productRecommendationRepoProvider,
    );
    onNetworkStateChanged();
   onAuthStateChanged(canRefreshSelf: true);
    onProductUpdate();
    return loadData(PaginatedRequest(page: 1, limit: 20));
  }

  @override
  FutureOr<PaginatedResponse<ProductModel>> loadData(
    PaginatedRequest request,
  ) async {
    try {
      final res = await productRecommendationRepository
          .getPopularRecommendations(query: request.toJson());
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
        saveProduct: (p) {
          findAndReplace(model: p, );
        },
          unsaveProduct: (p) {
          findAndReplace(model: p);
        },
        saveProductFailed: (m, p) {
          findAndReplace(model: p);
        }
      );
    });
  }

}

final followingsProductsProvider = AsyncNotifierProvider<
  FollowingsProductsNotifier,
  PaginatedResponse<ProductModel>
>(FollowingsProductsNotifier.new);

class FollowingsProductsNotifier
    extends AsyncNotifier<PaginatedResponse<ProductModel>>
    with PaginationController<ProductModel>, ProductMixin {
  late AnalyticsService analyticsService;
  late ProductRecommendationRepository productRecommendationRepository;
  @override
  FutureOr<PaginatedResponse<ProductModel>> build() {
    analyticsService = ref.read(analyticsServiceProvider);
    productRecommendationRepository = ref.read(
      productRecommendationRepoProvider,
    );
    onNetworkStateChanged();
    onAuthStateChanged( canRefreshSelf: true);
    onProductUpdate();
    return loadData(PaginatedRequest(page: 1, limit: 20));
  }

  @override
  FutureOr<PaginatedResponse<ProductModel>> loadData(
    PaginatedRequest request,
  ) async {
    try {
      final res = await productRecommendationRepository
          .getFollowingStoreRecommendations(query: request.toJson());
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
        saveProduct: (p) {
          findAndReplace(model: p);
        },
          unsaveProduct: (p) {
          findAndReplace(model: p);
        },
        saveProductFailed: (m, p) {
          findAndReplace(model: p);
        }
      );
    });
  }

 
}
