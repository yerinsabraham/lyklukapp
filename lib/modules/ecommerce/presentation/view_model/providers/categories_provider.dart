import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/ecommerce/domain/repo/market_repositories.dart';
import 'package:lykluk/modules/ecommerce/model/category_model.dart';
import 'package:lykluk/utils/mixins/async_mixins.dart';

import '../../../../../core/services/services.dart';
import '../../../data/repo_impl/market_repo_impls.dart';

final categoriesProvider =
    AsyncNotifierProvider<CategoriesNotifier, List<CategoryModel>>(
      CategoriesNotifier.new,
    );

class CategoriesNotifier extends AsyncNotifier<List<CategoryModel>>
    with AsyncMixins {
  late AnalyticsService analyticsService;
  late CategoriesRepository categoriesRepository;
  @override
  FutureOr<List<CategoryModel>> build() {
    analyticsService = ref.read(analyticsServiceProvider);
    categoriesRepository = ref.read(categoriesRepoProvider);
    onNetworkStatusChange();
    onAuthStateChanged(
      initialData: [],
      onAuthenicated: () {
        // if (!state.hasValue) {
          ref.invalidateSelf();
        // }
      },
    );
    return loadData();
  }

  FutureOr<List<CategoryModel>> loadData() async {
    try {
      final res = await categoriesRepository.getRootCategories();
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

}
