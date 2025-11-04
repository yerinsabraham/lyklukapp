import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/ecommerce/presentation/views/order/order_checkout_page.dart'
    show PaymentSection;
import 'package:lykluk/modules/ecommerce/presentation/widgets/order_rating_sheet.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/helpers/show_sheet.dart';

import '../../../../../core/shared/widgets/shared_widget.dart';

class BuyerOrderView extends HookConsumerWidget {
  const BuyerOrderView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: context.width * 0.43,
                  ),
                  child: Text("Orders #189993", style: context.title24)),
              ],
            ),
            actions: [
              OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    context.colorScheme.primary.withValues(alpha: .1),
                  ),
                  padding: WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 10.sp, vertical: 2.sp),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(
                      Icons.refresh_outlined,
                      color: context.colorScheme.primary,
                    ),
                    Text(
                      "Repeat order",
                      style: context.body12.copyWith(
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    20.sH,
                    GestureDetector(
                      onTap: () {
                        showSheet(
                          context,
                          child: OrderRatingSheet(),
                          maxHeight: context.height * 0.7,
                          isScrollControlled: true,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.sp,
                          horizontal: 14.w,
                        ),
                        decoration: BoxDecoration(
                          color: context.colorScheme.surface,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 22.r,
                            backgroundImage: AssetImage(ImageAssets.post2mage),
                          ),
                          title: Text(
                            "Global Roots ",
                            style: context.body14.copyWith(
                              color: context.colorScheme.inversePrimary,
                            ),
                          ),
                          subtitle: Text(
                            "Rate your experience",
                            style: context.body14.copyWith(
                              color: context.colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    10.sH,
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 15.h,
                      ),
                      decoration: BoxDecoration(
                        color: context.colorScheme.surface,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border(
                          bottom: BorderSide(
                            color: context.colorScheme.onSecondary.withValues(
                              alpha: 0.2,
                            ),
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: CircleIcon(
                              color: context.colorScheme.onSecondary.withValues(
                                alpha: .1,
                              ),
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
                              color: context.colorScheme.onSecondary.withValues(
                                alpha: .1,
                              ),
                              child: SvgPicture.asset(
                                IconAssets.deliveryCarIcon,
                              ),
                            ),
                            title: Text('Bolt Delivery', style: context.body14),
                            subtitle: Text(
                              'Logistics',
                              style: context.body14.copyWith(
                                color: context.colorScheme.primary,
                              ),
                            ),
                            trailing: CircleAvatar(
                              backgroundImage: AssetImage(
                                ImageAssets.boltImage,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  radius: 10.r,
                                  backgroundColor: Colors.green,
                                ),
                                title: Text(
                                  "Blenco - Lekki, Lekki Penninsula II.",
                                  style: context.body14,
                                ),
                                subtitle: Text(
                                  "8:14 pm",
                                  style: context.body14,
                                ),
                                trailing: Text(
                                  "Thu, 31st Jul, 2025",
                                  style: context.body14,
                                ),
                              ),
                              IntrinsicHeight(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                  ),
                                  child: VerticalDivider(color: Colors.black),
                                ),
                              ),
                              ListTile(
                                leading: CircleIcon(
                                  child: SvgPicture.asset(
                                    IconAssets.locationIcon,
                                  ),
                                ),
                                title: Text(
                                  "Blenco - Lekki, Lekki Penninsula II.",
                                  style: context.body14,
                                ),
                                subtitle: Text(
                                  "8:14 pm",
                                  style: context.body14,
                                ),
                                trailing: Text(
                                  "Thu, 31st Jul, 2025",
                                  style: context.body14,
                                ),
                              ),
                            ],
                          ),
                          10.sH,
                          CustomButton(
                            color: context.colorScheme.onTertiaryFixed
                                .withValues(alpha: .5),
                            textColor: context.colorScheme.onSecondary
                                .withValues(alpha: .3),
                            onTap: () {},
                            buttonText: "Report issue",
                          ),
                        ],
                      ),
                    ),
                    10.sH,
                    PaymentSection(paymentMethod: 'Wallet'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
