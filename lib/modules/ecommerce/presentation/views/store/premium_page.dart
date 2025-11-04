import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/shared_widget.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/notifers/subscription_notifier.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/helpers/toast_notification.dart';

import '../../../../../utils/router/app_router.dart';
import '../../view_model/state/subscription_state.dart';

class PremiumPage extends HookConsumerWidget {
  const PremiumPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(subscriptionNotifierProvider, (previous, current) {
      current.maybeWhen(
        orElse: () {},
        updatedSubscription: (subscription, message) {
          // ref.read(navbarIndex.notifier).state = 4;
          // context.pushNamed(Routes.navBarRoute);
          context.pushNamed(Routes.createStoreRoute);
        },
        updatingSubscriptionFailed: (message) {
          ToastNotification.alertError(message);
        },
      );
    });

    return Scaffold(
      backgroundColor: context.colorScheme.primary,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: context.height * 0.55,
                  width: context.width,
                  decoration: BoxDecoration(color: context.colorScheme.primary),
                ),
                Container(
                  height: context.height * 0.45,
                  width: context.width,
                  decoration: BoxDecoration(color: context.colorScheme.surface),
                ),
              ],
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    20.sH,
                    Center(child: SvgPicture.asset(IconAssets.logo)),
                    20.sH,
                    Chip(
                      backgroundColor: context.colorScheme.primary.withValues(
                        alpha: 0.8,
                      ),
                      side: BorderSide.none,
                      label: Text(
                        "SUBSCRIBE FOR PREMIUM",
                        style: context.body14.copyWith(
                          color: context.colorScheme.surface,
                        ),
                      ),
                    ),
                    20.sH,
                    Text(
                      'Subscribe for more access',
                      style: context.title24.copyWith(
                        color: context.colorScheme.surface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    10.sH,
                    Text(
                      'Dive into a vibrant community where \nwe bring cultural stories to life.',
                      textAlign: TextAlign.center,
                      style: context.body14Light.copyWith(
                        color: context.colorScheme.surface,
                      ),
                    ),
                    20.sH,
                    Container(
                      width: context.width,
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: BoxDecoration(
                        color: context.colorScheme.surface,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(
                              color: context.colorScheme.onSecondary.withValues(
                                alpha: .1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'MOST POPULAR',
                                style: context.body14.copyWith(
                                  color: context.colorScheme.inversePrimary,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                          ),
                          20.sH,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Premium Shop',
                                  style: context.title32.copyWith(height: 1.2),
                                ),
                                Text(
                                  'Pricing that works for you',
                                  style: context.body16Light,
                                ),
                                10.sH,
                                Text.rich(
                                  TextSpan(
                                    text: '₦500K',
                                    style: context.title32,
                                    children: [
                                      TextSpan(
                                        text: '  /',
                                        style: context.body16Light.copyWith(
                                          color: context.colorScheme.onSecondary
                                              .withValues(alpha: .5),
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'month',
                                        style: context.body16Light.copyWith(
                                          color: context.colorScheme.onSecondary
                                              .withValues(alpha: .5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                10.sH,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(
                                      radius: 15.r,
                                      child: SvgPicture.asset(
                                        IconAssets.greenCheckIcon,
                                      ),
                                    ),
                                    15.sW,
                                    Text(
                                      "Add up to 50 products",
                                      style: context.body16,
                                    ),
                                  ],
                                ),
                                5.sH,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(
                                      radius: 15.r,
                                      child: SvgPicture.asset(
                                        IconAssets.greenCheckIcon,
                                      ),
                                    ),
                                    15.sW,
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth: 250.w,
                                      ),
                                      child: Text(
                                        "Up to 5 preferred delivery companies",
                                        style: context.body16,
                                      ),
                                    ),
                                  ],
                                ),
                                5.sH,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(
                                      radius: 15.r,
                                      child: SvgPicture.asset(
                                        IconAssets.greenCheckIcon,
                                      ),
                                    ),
                                    15.sW,
                                    Text(
                                      "Generated Ads for store page",
                                      style: context.body16,
                                    ),
                                  ],
                                ),
                                5.sH,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(
                                      radius: 15.r,
                                      child: SvgPicture.asset(
                                        IconAssets.greenCheckIcon,
                                      ),
                                    ),
                                    15.sW,
                                    Text(
                                      "Unlimited Support",
                                      style: context.body16,
                                    ),
                                  ],
                                ),
                                30.sH,
                                CustomButton(
                                  isLoading:
                                      ref.watch(subscriptionNotifierProvider)
                                          is SubscriptionUpdating,
                                  onTap: () {
                                    ref
                                        .read(
                                          subscriptionNotifierProvider.notifier,
                                        )
                                        .updateMyPlan("FREE");
                                  },
                                  buttonText: "Get Started",
                                ),
                                5.sH,
                                GestureDetector(
                                  onTap: () {
                                    ref
                                        .read(subscriptionNotifierProvider.notifier)
                                        .updateMyPlan("FREE");
                                    //   ref.read(navbarIndex.notifier).state = 4;
                                    // context.pushNamed(Routes.navBarRoute);
                                  },
                                  child: Center(
                                    child: Text(
                                      "Continue with Free Trial",
                                      style: context.bodySmall18.copyWith(
                                        color: context.colorScheme.primary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
