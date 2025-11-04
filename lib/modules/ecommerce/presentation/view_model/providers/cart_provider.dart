import 'dart:async';

import 'package:lykluk/modules/ecommerce/model/market_models.dart';
import 'package:lykluk/modules/ecommerce/data/repo_impl/market_repo_impls.dart';
// import 'package:lykluk/modules/ecommerce/domain/repo/market_repositories.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/notifers/cart_notifier.dart';
import 'package:lykluk/utils/mixins/async_mixins.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../../core/services/services.dart';

final cartProvider =AsyncNotifierProvider<CartNotifier, CartModel>( CartNotifier.new);

class CartNotifier extends AsyncNotifier<CartModel> with AsyncMixins {
  // late final CartRepository cartRepository;
  @override
  Future<CartModel> build() async {
    // cartRepository = ref.read(cartRepoProvider);
    onAuthStateChanged(
      initialData: CartModel.empty(),
      onAuthenicated: () {
        // ref.invalidateSelf();
      },
    );
    onCartChange();
    return load();
  }

  FutureOr<CartModel> load() async {
    try {
      final result = await ref.read(cartRepoProvider).getCart();
      return result.fold(
        (l) {
          return Future.error(l.message);
        },
        (r) {
          return r.data;
        },
      );
    } catch (e) {
      log.e(e);
      return Future.error(e.toString());
    }
  }

  void onCartChange() {
    ref.listen(cartNotifierProvider, (p, n) {
      n.maybeWhen(
        orElse: () {},
        addedToCart: (cart) {
          state = AsyncData(cart);
        },
        removedFromCart: (cart) {
          state = AsyncData(cart);
        },
        updatedCart: (cart) {
          state = AsyncData(cart);
        },
      );
    });
  }
}
