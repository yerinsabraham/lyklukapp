import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/ecommerce/presentation/widgets/shop_rating.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/helpers/show_sheet.dart';

import '../../../../../core/shared/widgets/shared_widget.dart';
import '../../../../../utils/router/app_router.dart';

const _tab = ["Order Summary", "Delivery & Payment"];

class OrderCheckoutPage extends HookConsumerWidget {
  const OrderCheckoutPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = useState(0);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        surfaceTintColor: context.colorScheme.surface,
        shadowColor: context.colorScheme.surface,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            ExitButton(
              child: Icon(
                Icons.keyboard_backspace_rounded,
                color: context.colorScheme.primary,
                size: 24.sp,
              ),
            ),
            20.sW,
            Text("Orders", style: context.title24),
          ],
        ),
        toolbarHeight: 100.h,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: OutlinedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  context.colorScheme.error.withValues(alpha: .1),
                ),
                padding: WidgetStatePropertyAll(EdgeInsets.all(4.r)),
              ),
              onPressed: () {},
              child: Text('Clear', style: context.body14.copyWith()),
            ),
          ),
        ],

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.h),
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 14.w,
            ).copyWith(bottom: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: context.colorScheme.onTertiaryFixed.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(_tab.length, (i) {
                return TabContainer(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 10.h,
                  ),
                  onTap: () {
                    selectedTab.value = i;
                  },
                  value: _tab[i],
                  selected: selectedTab.value == i,
                  inActiveColor: Colors.transparent,
                );
              }),

              // ],
            ),
          ),
        ),
      ),
      body: IndexedStack(
        index: selectedTab.value,
        children: [
          OrderSummary(
            onConfirm: (b) {
              if (b) selectedTab.value = 1;
            },
          ),
          DeliveryDetails(),
        ],
      ),
    );
  }
}

class OrderSummary extends HookConsumerWidget {
  final void Function(bool)? onConfirm;
  const OrderSummary({super.key, this.onConfirm});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        20.sH,
        Expanded(child: OrderItemList()),
        Text.rich(
          TextSpan(
            text: "By proceeding you agree to our ",
            style: context.body12,
            children: [
              TextSpan(
                text: "Terms of use",
                style: context.body12.copyWith(
                  color: context.colorScheme.primary,
                ),
              ),
              TextSpan(text: " and "),
              TextSpan(
                text: "Privacy Policy",
                style: context.body12.copyWith(
                  color: context.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        10.sH,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: CustomButton(
            onTap: () {
              onConfirm?.call(true);
            },
            buttonText: "Make payment",
          ),
        ),
        40.sH,
      ],
    );
  }
}

class OrderItemList extends StatelessWidget {
  final bool showCloseIndicator;
  const OrderItemList({super.key, this.showCloseIndicator = false});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: 4 + 1,
      itemBuilder: (c, i) {
        if (i == 0) {
          return SellerDetails(showCloseIndicator: showCloseIndicator);
        } else {
          return CheckoutTile();
        }
      },
    );
  }
}

class SellerDetails extends StatelessWidget {
  final bool showCloseIndicator;
  final String? title;
  const SellerDetails({super.key, this.showCloseIndicator = false, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w).copyWith(bottom: 10.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          10.sH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title ?? "Your Order", style: context.body14Bold),
              Visibility(
                visible: showCloseIndicator,
                child: GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Icon(
                    Icons.close_outlined,
                    size: 24.sp,
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 23.r,
              backgroundImage: AssetImage(ImageAssets.post2mage),
            ),

            title: Text(
              'Global Roots 🌍🌳 ',
              style: context.body16Bold,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: ShopRating(),
          ),
        ],
      ),
    );
  }
}

class CheckoutTile extends HookConsumerWidget {
  const CheckoutTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantityValue = useState(1);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: context.colorScheme.onSecondary.withValues(alpha: .1),
          width: 0.5,
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          height: 45.h,
          width: 45.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            image: DecorationImage(
              image: AssetImage(ImageAssets.post2mage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          'Monjaro Djembe x${quantityValue.value}',
          style: context.body14.copyWith(
            color: context.colorScheme.inversePrimary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text('₦ 500K', style: context.body12),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                if (quantityValue.value > 1) {
                  quantityValue.value--;
                }
              },
              child: Container(
                height: 29.h,
                width: 29.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: context.colorScheme.onSecondaryContainer.withValues(
                    alpha: 0.02,
                  ),
                  border: Border.all(
                    color: context.colorScheme.onSecondary.withValues(
                      alpha: .1,
                    ),
                  ),
                ),
                child: Center(child: Text('-', style: context.body16)),
              ),
            ),
            10.sW,
            Text('${quantityValue.value}', style: context.body12),
            10.sW,
            GestureDetector(
              onTap: () {
                quantityValue.value++;
              },
              child: Container(
                height: 29.h,
                width: 29.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: context.colorScheme.onSecondaryContainer.withValues(
                    alpha: 0.02,
                  ),
                  border: Border.all(
                    color: context.colorScheme.onSecondary.withValues(
                      alpha: .1,
                    ),
                  ),
                ),
                child: Center(child: Text('+', style: context.body16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DeliveryDetails extends HookConsumerWidget {
  const DeliveryDetails({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          10.sH,
          DeliverySection(),
          10.sH,
          PaymentSection(),
          10.sH,
          PaymentMethodsWidget(),
          30.sH,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: CustomButton(
              onTap: () {
                showAppDialog(context, child: _successDialog(context));
              },
              buttonText: "Checkout",
            ),
          ),
          30.sH,
        ],
      ),
    );
  }

  Widget _successDialog(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(15.r),
      child: SizedBox(
        width: context.width * 0.95,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              25.sH,
              SvgPicture.asset(IconAssets.greenCheckIcon),
              25.sH,
              Text('Checkout Successful', style: context.title32),
              Text(
                'Your order has been sent to seller successfully. Track order status.',
                textAlign: TextAlign.center,
                style: context.body14,
              ),
              20.sH,
              CustomButton(
                onTap: () {
                  context.pop();
                  context.pushNamed(Routes.buyerOrderViewRoute);
                },
                buttonText: "Track order",
              ),
              30.sH,
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentMethodsWidget extends HookConsumerWidget {
  final Function(String?)? onSelect;
  const PaymentMethodsWidget({super.key, this.onSelect});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMethod = useState(0);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border(
          bottom: BorderSide(
            color: context.colorScheme.onSecondary.withValues(alpha: .2),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Payment Methods', style: context.body14Bold),
          ListTile(
            leading: CircleIcon(
              color: context.colorScheme.onSecondary.withValues(alpha: .1),
              child: SvgPicture.asset(IconAssets.wallet2Icon),
            ),
            title: Text(
              ' ₦ 3M',
              style: context.body14.copyWith(
                color: context.colorScheme.inversePrimary,
              ),
            ),
            subtitle: Text('Wallet', style: context.body12),
            trailing: CustomRadio(
              value: 0,
              groupValue: selectedMethod.value,
              onTap: (v) {
                selectedMethod.value = v;
                onSelect?.call('Wallet');
              },
            ),
          ),
          ListTile(
            leading: CircleIcon(
              color: context.colorScheme.onSecondary.withValues(alpha: .1),
              child: SvgPicture.asset(IconAssets.lukcoinIcon),
            ),
            title: Text(
              ' L 3M',
              style: context.body14.copyWith(
                color: context.colorScheme.inversePrimary,
              ),
            ),
            subtitle: Text('LykCoins', style: context.body12),
            trailing: CustomRadio(
              value: 1,
              groupValue: selectedMethod.value,
              onTap: (v) {
                selectedMethod.value = v;
                onSelect?.call('LykCoins');
              },
            ),
          ),
          ListTile(
            leading: CircleIcon(
              color: context.colorScheme.onSecondary.withValues(alpha: .1),
              child: SvgPicture.asset(IconAssets.masterCardIcon),
            ),
            title: Text(
              '********2345',
              style: context.body14.copyWith(
                color: context.colorScheme.inversePrimary,
              ),
            ),

            trailing: CustomRadio(
              value: 2,
              groupValue: selectedMethod.value,
              onTap: (v) {
                selectedMethod.value = v;
                onSelect?.call('Mastercard');
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentSection extends StatelessWidget {
  final String? paymentMethod;
  final double totalAmount;
  final int itemsCount ;
  final double serviceFee;
  final double deliveryFee;
  final double subTotal;
  const PaymentSection({super.key, this.paymentMethod, this.totalAmount=0.0, this.itemsCount=0, this.serviceFee=0.0, this.deliveryFee=0.0, this.subTotal=0.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border(
          bottom: BorderSide(
            color: context.colorScheme.onSecondary.withValues(alpha: .2),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Payment summary', style: context.body14Bold),
              // GestureDetector(
              //   onTap: () {
              //     showAppDialog(
              //       context,
              //       child: Material(
              //         borderRadius: BorderRadius.circular(15.r),
              //         child: OrderItemList(showCloseIndicator: true),
              //       ),
              //     );
              //   },
              //   child: Chip(
              //     side: BorderSide.none,
              //     padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              //     backgroundColor: context.colorScheme.primary.withValues(
              //       alpha: .2,
              //     ),
              //     label: Text(
              //       "View items",
              //       style: context.body14.copyWith(
              //         color: context.colorScheme.primary,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
          ListTile(
            title: Text('Sub-total (${itemsCount.pluralize("item", "items")})', style: context.body14),
            trailing: Text('₦ ${subTotal.toCurrency}', style: context.body14),
          ),
          Container(
            height: 1.h,
            width: double.infinity,
            color: context.colorScheme.onSecondary.withValues(alpha: .1),
          ),
          ListTile(
            title: Text("Delivery fees", style: context.body14),
            trailing: Text('₦ ${deliveryFee.toCurrency}', style: context.body14),
          ),
          Container(
            height: 1.h,
            width: double.infinity,
            color: context.colorScheme.onSecondary.withValues(alpha: .1),
          ),
          ListTile(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: context.colorScheme.onSecondary),
            ),
            title: Text.rich(
              TextSpan(
                text: 'Service fee ',
                style: context.body14,
                children: [
                  WidgetSpan(
                    child: SvgPicture.asset(
                      IconAssets.warningIcon,
                      colorFilter: ColorFilter.mode(
                        context.colorScheme.onSecondary.withValues(alpha: .4),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            trailing: Text('₦ ${serviceFee.toCurrency}', style: context.body14),
          ),
          Container(
            height: 1.h,
            width: double.infinity,
            color: context.colorScheme.onSecondary.withValues(alpha: .1),
          ),
          ListTile(
            title: Text('Total', style: context.body16Bold),
            trailing: Text('₦ ${totalAmount.toCurrency}', style: context.body16Bold),
          ),
          Container(
            height: 1.h,
            width: double.infinity,
            color: context.colorScheme.onSecondary.withValues(alpha: .1),
          ),
          Visibility(
            visible: paymentMethod != null,
            child: ListTile(
              title: Text('Payment method', style: context.body16Bold),
              trailing: Text(
                paymentMethod ?? 'Select payment method',
                style: context.body14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DeliverySection extends StatelessWidget {
  const DeliverySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border(
          bottom: BorderSide(
            color: context.colorScheme.onSecondary.withValues(alpha: .2),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Delivery details', style: context.body14Bold),
          ListTile(
            leading: CircleIcon(
              color: context.colorScheme.onSecondary.withValues(alpha: .1),
              child: SvgPicture.asset(IconAssets.locationIcon),
            ),
            title: Text('Lekki Lagos', style: context.body14),
            subtitle: Text(
              'Delivery address',
              style: context.body14.copyWith(
                color: context.colorScheme.primary,
              ),
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
              style: context.body14,
            ),
            subtitle: Text(
              'Edit Note',
              style: context.body14.copyWith(
                color: context.colorScheme.primary,
              ),
            ),
          ),
          ListTile(
            leading: CircleIcon(
              color: context.colorScheme.onSecondary.withValues(alpha: .1),
              child: SvgPicture.asset(IconAssets.deliveryCarIcon),
            ),
            title: Text('Bolt Delivery', style: context.body14),
            subtitle: Text(
              'Logistics',
              style: context.body14.copyWith(
                color: context.colorScheme.primary,
              ),
            ),
            trailing: CircleAvatar(
              backgroundImage: AssetImage(ImageAssets.boltImage),
            ),
          ),
        ],
      ),
    );
  }
}
