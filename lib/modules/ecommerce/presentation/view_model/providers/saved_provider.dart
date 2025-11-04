import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/ecommerce/domain/repo/market_repositories.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/mixins/product_mixins.dart';

import '../../../../../core/services/services.dart';
import '../../../../../utils/pagination/pagination.dart';
import '../../../data/repo_impl/market_repo_impls.dart';
import '../../../model/product_model.dart';
import '../notifers/product_notifier.dart';

final savedProductsProvider = AsyncNotifierProvider<
  SavedProductsNotifier,
  PaginatedResponse<ProductModel>
>(SavedProductsNotifier.new);

class SavedProductsNotifier
    extends AsyncNotifier<PaginatedResponse<ProductModel>>
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
    return loadData(PaginatedRequest(page: 1, limit: 20));
  }

  @override
  FutureOr<PaginatedResponse<ProductModel>> loadData(
    PaginatedRequest request,
  ) async {
    try {
      final res = await productRepository.getSavedProduct(
        query: request.toJson(),
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
        saveProduct: (p) {
          addTop(p);
        },
        unsaveProduct: (p) {
          findAndDelete(p.id.toString(), (s) => s.id == p.id);
        },
        saveProductFailed: (msg, p) {
          if (p.featured) {
            addTop(p);
          } else {
            findAndDelete(p.id.toString(), (s) => s.id == p.id);
          }
        },
      );
    });
  }
}
