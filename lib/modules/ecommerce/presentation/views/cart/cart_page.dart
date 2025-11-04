import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/ecommerce/model/market_models.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/providers/cart_provider.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/state/cart_state.dart';
import 'package:lykluk/modules/ecommerce/presentation/views/cart/cart_tile.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/helpers/toast_notification.dart';

import '../../../../../core/shared/widgets/shared_widget.dart';
import '../../../../../utils/assets_manager.dart';
import '../../../../../utils/router/app_router.dart';
import '../../view_model/notifers/cart_notifier.dart';

class CartPage extends HookConsumerWidget {
  const CartPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItem = ref.watch(cartProvider);
    ref.listen(cartNotifierProvider, (previous, current) {
      current.maybeWhen(
        orElse: () {},
        removingFromCartFailed: (message) {
          ToastNotification.alertError(message);
        },
        updatingCartFailed: (message) {
          ToastNotification.alertError(message);
        },
        validatedCart: (cartmap) {
          context.pushNamed(Routes.cartCheckoutRoute);
          ToastNotification.alertSuccess('cart validated');

        },
        validingCartFailed: (msg, errors) {
          if (errors.isNotEmpty) {
            ToastNotification.alertError(errors.join('\n'));
          } else {
            ToastNotification.alertError(msg);
          }
        },
      );
    });
    return Scaffold(
      appBar: CustomTileAppbar(
        backgroundColor: context.colorScheme.surface,
        leadingWidget: ExitButton(
          color: context.colorScheme.onSecondary.withValues(alpha: 0.08),
          size: 32.r,
          child: Icon(
            Icons.keyboard_backspace,
            size: 20.r,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Cart',
          style: context.title24.copyWith(fontWeight: FontWeight.w700),
        ),
      ),

      body: asyncItem.when(
        loading: () {
          // return Center(child: CircularProgressIndicator( color: context.colorScheme.primary,));
          return ShimmerList(child: CartTile(item: CartItem.empty()));
        },
        error: (e, s) {
          return Center(
            child: AppErrorWidget(
              errorText: e.toString(),
              asyncValue: asyncItem,
              onRetry: () {
                ref.invalidate(cartProvider);
              },
            ),
          );
        },
        data: (cart) {
          return Column(
            children: [
              10.sH,
              Visibility(
                visible: cart.items.isNotEmpty,
                replacement: Expanded(child: Center(child: EmptyCart())),
                child: Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      return ref.refresh(cartProvider.future);
                    },
                    child: ListView.separated(
                      separatorBuilder: (c, i) => 10.sH,
                      itemCount: cart.items.length,
                      itemBuilder: (c, i) {
                        return CartTile(item: cart.items[i]);
                      },
                    ),
                  ),
                ),
              ),
              20.sH,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: CustomButton(
                  isLoading:
                      ref.watch(cartNotifierProvider) is CartValidingCart,
                  onTap: () {
                    ref.read(cartNotifierProvider.notifier).validate();
                  },
                  buttonText:
                      'Checkout (₦${double.parse(cart.totals.subtotal).toCurrency})',
                ),
              ),
              20.sH,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),

                child: CustomButton(
                  color: context.colorScheme.onSecondary.withValues(
                    alpha: 0.05,
                  ),
                  onTap: () {
                    context.pop();
                  },
                  buttonText: 'Continue shopping',
                  textColor: Colors.black,
                ),
              ),
              50.sH,
            ],
          );
        },
      ),
    );
  }
}

class EmptyCart extends HookConsumerWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(IconAssets.emptyShopIcons),
        Text(
          'Your Cart is Empty',
          style: context.title24.copyWith(fontWeight: FontWeight.w700),
        ),
        Text(
          'Looks like you haven’t added anything to your cart yet',
          style: context.body14,
        ),
        20.sH,
        CustomElevatedButton(
          onTap: () {
            // ref.read(navbarIndex.notifier).update((bd) => );
            context.pushNamed(Routes.navBarRoute);
          },
          buttonText: "Start shopping",
        ),
      ],
    );
  }
}
