import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/ecommerce/domain/repo/market_repositories.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/mixins/product_mixins.dart';

import '../../../../../core/services/services.dart';
import '../../../../../utils/pagination/pagination.dart';
import '../../../data/repo_impl/market_repo_impls.dart';
import '../../../model/market_models.dart';
import '../notifers/product_notifier.dart';

final myProductsProvider =
    AsyncNotifierProvider<MyProductsNotifier, PaginatedResponse<ProductModel>>(
      MyProductsNotifier.new,
    );

class MyProductsNotifier extends AsyncNotifier<PaginatedResponse<ProductModel>>
    with PaginationController<ProductModel>, ProductMixin {
  late AnalyticsService analyticsService;
  late ProductRepository productRepository;
  @override
  FutureOr<PaginatedResponse<ProductModel>> build() {
    analyticsService = ref.read(analyticsServiceProvider);
    productRepository = ref.read(productRepoProvider);
    onNetworkStateChanged();
    onAuthStateChanged();
    onProductUpdate();
    return loadData(PaginatedRequest());
  }

  @override
  FutureOr<PaginatedResponse<ProductModel>> loadData(
    PaginatedRequest request,
  ) async {
    try {
      final res = await productRepository.getMyProducts(
        query: request.toJson(),
      );
      return res.fold(
        (l) {
          return Future.error(l.message);
          // return Future.value(PaginatedResponse(dataList: [ProductModel(id: 0, status: '')], fieldName: 'data'));
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

  void filter({String? categoryId}) async {
    state = await AsyncValue.guard(() async {
      return await loadData(
        PaginatedRequest(
          page: 1,
          limit: 20,
          filter: {"categoryId": categoryId},
        ),
      );
    });
  }

  void onProductUpdate() {
    ref.listen(productNotifierProvider, (p, n) {
      n.maybeWhen(
        orElse: () {},
        saveProduct: (p) {
          findAndReplace(model: p);
        },
        unsaveProduct: (p) {
          findAndReplace(model: p,);
        },
        saveProductFailed: (m, p) {
          findAndReplace(model: p);
        }
      );
    });
  }
}
