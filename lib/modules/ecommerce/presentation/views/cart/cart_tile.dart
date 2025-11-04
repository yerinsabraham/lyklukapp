import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/image_container.dart';
import 'package:lykluk/modules/ecommerce/model/market_models.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/state/cart_state.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/helpers/debounce.dart';

import '../../../../../utils/assets_manager.dart';
import '../../../../../utils/router/app_router.dart';
import '../../../model/cart_model.dart';
import '../../view_model/notifers/cart_notifier.dart';

class CartTile extends HookConsumerWidget {
  final bool showAction;
  final CartItem item;
  const CartTile({super.key, this.showAction = true, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantity = useState(item.quantity);
    final price = double.tryParse(item.product?.price ?? "0.0") ?? 0.0;
    final deboucer = useState(Debounce(duration: 1500));
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.productDetailsRoute, extra: item.product?.id);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 15.h),

        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          // borderRadius: BorderRadius.circular(10.r),
          border: Border(
            bottom: BorderSide(
              color: context.colorScheme.onSecondary.withValues(alpha: .1),
              width: 1.w,
            ),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                ImageContainer(
                  height: 70.h,
                  width: 70.w,
                  radius: 10.r,
                  url: (item.product?.imageUrls.isEmpty?? true)? null :  item.product?.imageUrls.first,
                ),
                // Container(
                //   height: 70.h,
                //   width: 70.w,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10.r),

                //     image: DecorationImage(
                //       image: AssetImage(ImageAssets.post1mage),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                //   // backgroundImage: AssetImage(ImageAssets.userImage),
                // ),
                10.sW,
                Column(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // "Amara cream Amara cream Amara cream ",
                      item.product?.name ?? "",
                      style: context.body12,
                    ),
                    20.sH,

                   
                    Text(
                      "₦ ${quantity.value * price}",
                      style: context.body14Light,
                    ),
                  ],
                ),
              ],
            ),
            10.sH,
            if (showAction)
              Row(
                children: [
                  Consumer(
                    builder: (_, WidgetRef ref, __) {
                      final state = ref.watch(cartNotifierProvider);
                      final isLoading =
                          state is CartRemovingFromCart &&
                          state.productId == item.product?.id;
                      return  OutlinedButton.icon(
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              backgroundColor: WidgetStateProperty.all(
                                context.colorScheme.error.withValues(
                                  alpha: 0.05,
                                ),
                              ),
                            ),
                            onPressed: () {
                              ref
                                  .read(cartNotifierProvider.notifier)
                                  .remove(itemId: item.id);
                            },
                            label: Text(
                              'Remove',
                              style: context.body10.copyWith(
                                color: context.colorScheme.error,
                              ),
                            ),
                            icon: isLoading
                                ? Center(
                                  child: CircularProgressIndicator(
                                    color: context.colorScheme.primary,
                                  ),
                                )
                                : SvgPicture.asset(
                              IconAssets.deleteIcon,
                              height: 14.h,
                              width: 14.w,

                              color: context.colorScheme.error,
                            ),
                          );
                    },
                  ),
                  Spacer(),
                  MaterialButton(
                    elevation: 0,
                    minWidth: 50.w,
                    height: 50.h,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),

                    color: Colors.grey.withValues(alpha: 0.05),

                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: context.colorScheme.onSecondary.withValues(
                          alpha: 0.3,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    onPressed: () {
                      if (quantity.value <= 0) return;
                      quantity.value = (quantity.value - 1);
                      deboucer.value.run(() {
                        ref
                            .read(cartNotifierProvider.notifier)
                            .update(
                              itemId: item.id,
                              quantity: quantity.value,
                            );
                      });
                    },
                    child: Text(
                      '-',
                      style: context.body16.copyWith(color: Colors.black),
                    ),
                  ),
                  10.sW,
                  Text(quantity.value.toString(), style: context.body16Bold),
                  10.sW,
                  MaterialButton(
                    elevation: 0,
                    minWidth: 50.w,
                    height: 50.h,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    color: context.colorScheme.primary,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    onPressed: () {
                      quantity.value = (quantity.value + 1);
                      deboucer.value.run(() {
                        ref
                            .read(cartNotifierProvider.notifier)
                            .update(
                              itemId: item.id,
                              quantity: quantity.value,
                            );
                      });
                    },
                    child: Text(
                      '+',
                      style: context.body16.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),

            // 10.sH,
          ],
        ),
      ),
    );
  }
}
