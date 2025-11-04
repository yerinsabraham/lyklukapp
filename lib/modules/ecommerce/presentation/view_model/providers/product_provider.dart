import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/ecommerce/domain/repo/market_repositories.dart';
import 'package:lykluk/utils/mixins/async_mixins.dart';
import '../../../../../core/services/services.dart';
import '../../../data/repo_impl/market_repo_impls.dart';
import '../../../model/market_models.dart';
import '../notifers/product_notifier.dart';

final productProvider =
    AsyncNotifierProviderFamily<ProductNotifier, ProductModel, int>(
      ProductNotifier.new,
    );

class ProductNotifier extends FamilyAsyncNotifier<ProductModel, int>
    with AsyncMixins {
  late AnalyticsService analyticsService;
  late ProductRepository productRepository;
  @override
  FutureOr<ProductModel> build(arg) {
    analyticsService = ref.read(analyticsServiceProvider);
    productRepository = ref.read(productRepoProvider);
    onAuthStateChanged(
      initialData: ProductModel.empty(),
      onAuthenicated: () {
        ref.invalidateSelf();
      },
    );
    onProductUpdate();
    return loadData();
  }

  FutureOr<ProductModel> loadData() async {
    try {
      final res = await productRepository.getProduct(productId: arg);
      return res.fold(
        (l) {
          return Future.error(l.message);
          // return singleDemoproduct;
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

  /// listen product notifier and update the model if there is a change
  void onProductUpdate() {
    ref.listen(productNotifierProvider, (p, n) {
      n.maybeWhen(
        orElse: () {},
        saveProduct: (p) {
          if (p.id != arg) return;
          state = AsyncValue.data(p);
        },
        saveProductFailed: (m, p) {
          if (p.id != arg) return;
          state = AsyncValue.data(p);
        },
        unsaveProduct: (p){
          if (p.id != arg) return;
          state = AsyncValue.data(p);
        }
      );
    });
  }
}
