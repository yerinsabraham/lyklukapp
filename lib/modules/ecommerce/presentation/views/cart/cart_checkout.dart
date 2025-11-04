import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/ecommerce/model/address_model.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/providers/cart_provider.dart';
import 'package:lykluk/modules/ecommerce/presentation/views/cart/cart_tile.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

import '../../../../../core/shared/widgets/shared_widget.dart';
import '../../../../../utils/assets_manager.dart';
import '../../../../../utils/router/app_router.dart';
import '../order/order_checkout_page.dart';

class CartCheckoutPage extends HookConsumerWidget {
  const CartCheckoutPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPaymentMethod = useState<String?>("Wallet");
    // final 
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            pinned: false,
            automaticallyImplyLeading: false,
            scrolledUnderElevation: 0,
            elevation: 0,
            surfaceTintColor: context.colorScheme.surface,
            shadowColor: context.colorScheme.surface,
            backgroundColor: context.colorScheme.surface,
            title: Row(
              children: [
                ExitButton(
                  size: 32,
                  color: context.colorScheme.onSecondary.withValues(alpha: 0.1),
                  child: Icon(
                    Icons.keyboard_backspace_rounded,
                    color: context.colorScheme.inversePrimary,
                    size: 24.sp,
                  ),
                ),
                20.sW,
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: context.width * 0.43),
                  child: Text("Checkout", style: context.title24),
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  10.sH,
                  DeliveryDetailSection(),
                  10.sH,
                  ShoppingList(),
                  10.sH,
                  Consumer(
                    builder: (_, WidgetRef ref, __) {
                       final totals = ref.watch(
                        cartProvider.select((v) => v.requireValue.totals),
                      );
                      return PaymentSection(
                        paymentMethod: selectedPaymentMethod.value,
                        subTotal:  double.tryParse( totals.subtotal)?? 0.0,
                        itemsCount: totals.itemCount,
                        totalAmount: double.tryParse(totals.subtotal) ?? 0.0,
                        // totalAmount: ,
                      );
                    },
                  ),
                  10.sH,
                  PaymentMethodsWidget(
                    onSelect: (v) {
                      selectedPaymentMethod.value = v;
                    },
                  ),
                  20.sH,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: CustomButton(
                      onTap: () {},
                      buttonText: "Proceed to Payment",
                    ),
                  ),
                  40.sH,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DeliveryDetailSection extends HookConsumerWidget {
  const DeliveryDetailSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAddress = useState<AddressModel?>(null);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border(
          bottom: BorderSide(
            color: context.colorScheme.onSecondary.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Delivery details', style: context.body14Bold),
          ListTile(
            onTap: () async {
              final res =
                  await context.pushNamed(Routes.selectAddressRoute)
                      as AddressModel?;
              debugPrint(res.toString());
              if (res != null) {
                selectedAddress.value = res;
              }
            },
            leading: CircleIcon(
              color: context.colorScheme.onSecondary.withValues(alpha: .1),
              child: SvgPicture.asset(
                IconAssets.locationIcon,
                colorFilter: ColorFilter.mode(
                  context.colorScheme.inversePrimary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            title: Text(
              selectedAddress.value != null
                  ? selectedAddress.value?.address ?? ""
                  : 'Enter delivery address',
              style: context.body12,
            ),
            subtitle: Text(
              'Change delivery address',
              style: context.body10.copyWith(
                color: context.colorScheme.primary,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: context.colorScheme.onSecondary,
              size: 16.r,
            ),
          ),
          ListTile(
            leading: CircleIcon(
              color: context.colorScheme.onSecondary.withValues(alpha: .1),
              child: SvgPicture.asset(
                IconAssets.shopIcon,
                colorFilter: ColorFilter.mode(
                  context.colorScheme.inversePrimary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            title: Text(
              'Please be careful with the packages',
              style: context.body12,
            ),
            subtitle: Text(
              'Edit Note',
              style: context.body10.copyWith(
                color: context.colorScheme.primary,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: context.colorScheme.onSecondary,
              size: 16.r,
            ),
          ),
          ListTile(
            leading: CircleIcon(
              color: context.colorScheme.onSecondary.withValues(alpha: .1),
              child: SvgPicture.asset(IconAssets.deliveryCarIcon),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 6.r,
                  backgroundImage: AssetImage(ImageAssets.boltImage),
                ),
                5.sW,

                Text('Bolt Delivery', style: context.body12),
              ],
            ),
            subtitle: Text(
              'Logistics',
              style: context.body10.copyWith(
                color: context.colorScheme.primary,
              ),
            ),

            trailing: Icon(
              Icons.arrow_forward_ios,
              color: context.colorScheme.onSecondary,
              size: 16.r,
            ),
          ),
        ],
      ),
    );
  }
}

class ShoppingList extends HookConsumerWidget {
  const ShoppingList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(cartProvider.select((v) => v.requireValue.items));
    return Container(
      padding: EdgeInsets.symmetric(
        // horizontal: 14.w,
        vertical: 15.h,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border(
          bottom: BorderSide(
            color: context.colorScheme.onSecondary.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Text('Shopping List', style: context.body14Bold),
          ),
          //  CheckoutTile(),
          ...List.generate(items.length, (index) {
            final item = items[index];
            return CartTile(showAction: false, item: item);
          }),
          Center(
            child: TextButton(
              onPressed: () {
                context.pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    IconAssets.editPenIcon,
                    color: context.colorScheme.primary,
                  ),
                  10.sW,
                  Text(
                    'Modifiy cart',
                    style: context.body14Bold.copyWith(
                      color: context.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
