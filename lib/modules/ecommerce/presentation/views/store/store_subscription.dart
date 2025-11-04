import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/app_error_widget.dart';
import 'package:lykluk/modules/ecommerce/model/subscription_model.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/notifers/subscription_notifier.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/providers/subscription_providers.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/helpers/toast_notification.dart';
import 'package:lykluk/utils/router/app_router.dart';

import '../../../../../core/shared/widgets/loading_with_text.dart';
import '../../../../../core/shared/widgets/shared_widget.dart'
    show CustomButton, CustomRadio, ExitButton;
import '../../widgets/agreement_checker.dart';

class StoreSubscriptionPage extends HookConsumerWidget {
  final int storeId;
  const StoreSubscriptionPage({super.key, required this.storeId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subs = ref.watch(allSubscriptionsProvider);

    final planTabIndex = useState(0);
    final formKey = useState(GlobalKey<FormState>());
    final isAgreed = useState(false);
    final selectedPlan = useState<String?>(null);
    ref.listen(subscriptionNotifierProvider, (previous, current) {
      current.maybeWhen(
        orElse: () {},
        updatedSubscription: (subscription, message) {
          context.goNamed(Routes.navBarRoute);
        },
        updatingSubscriptionFailed: (message) {
          ToastNotification.alertError(message);
        },
      );
    });
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: context.colorScheme.surface,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        title: Row(children: [ExitButton()]),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Chip(
              side: BorderSide.none,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              label: Text(
                'Step 4/4',
                style: context.body16.copyWith(
                  color: context.colorScheme.primary,
                ),
              ),
              backgroundColor: context.colorScheme.primary.withValues(
                alpha: .2,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: formKey.value,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // 20.sH,
                Text('Subscription', style: context.title32),
                Text(
                  'Select preferred subscription plan',
                  style: context.body14Light,
                ),
                20.sH,
                subs.when(
                  error: (e, s) {
                    return Center(
                      child: AppErrorWidget(
                        errorText: e.toString(),
                        asyncValue: subs,
                        onRetry: () {
                          ref.invalidate(allSubscriptionsProvider);
                        },
                      ),
                    );
                  },
                  loading: () {
                    return Center(
                      child: LoadingWithText(text: 'Loading subscriptions...'),
                    );
                  },
                  data: (d) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomRadio(
                                  groupValue: planTabIndex.value,
                                  onTap: (v) {
                                    planTabIndex.value = 0;
                                  },
                                  value: 0,
                                  radius: 20.r,
                                ),
                                5.sW,
                                Text('Free plan'),
                              ],
                            ),
                            40.sW,
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomRadio(
                                  groupValue: planTabIndex.value,
                                  onTap: (v) {
                                    planTabIndex.value = 1;
                                  },
                                  value: 1,
                                  radius: 20.r,
                                ),
                                5.sW,
                                Text('Paid plan'),
                              ],
                            ),
                          ],
                        ),
                        20.sH,
                        switch (planTabIndex.value) {
                          0 => StoreSubscriptionCard(
                            onSelect: (v) {
                              selectedPlan.value = v;
                            },
                            selected: selectedPlan.value,
                            storeId: storeId,
                            sub: d.firstWhere(
                              (e) => e.plan.toLowerCase() == 'free',
                            ),
                          ),
                          1 => PaidPlans(
                             selectedPlan: selectedPlan.value,
                            onSelect: (v) {
                              selectedPlan.value = v;
                            },
                            storeId: storeId,
                            subs:
                                d
                                    .where(
                                      (e) => e.plan.toLowerCase() != 'free',
                                    )
                                    .toList(),
                          ),
                          _ => Container(),
                        },
                        // IndexedStack(
                        //   index: planTabIndex.value,
                        //   children: [
                        //     StoreSubscriptionCard(
                        //       storeId: storeId,
                        //       sub: d.firstWhere(
                        //         (e) => e.plan.toLowerCase() == 'free',
                        //       ),
                        //     ),
                        //     PaidPlans(
                        //       storeId: storeId,
                        //       subs:
                        //           d
                        //               .where(
                        //                 (e) =>
                        //                     e.plan.toLowerCase() != 'free',
                        //               )
                        //               .toList(),
                        //     ),
                        //   ],
                        // ),
                      ],
                    );
                  },
                ),

                20.sH,
                Text(
                  "People are way more likely to follow verified profiles, it just shows you're legit.",
                  style: context.body14DarkLight,
                ),
                20.sH,
                AgreementChecker(
                  style: context.body14DarkLight,
                  iAgree: isAgreed,
                  highlightedcolor: context.colorScheme.primary,
                ),
                20.sH,
                CustomButton(
                  isDisable: !isAgreed.value || selectedPlan.value == null,
                  onTap: () {
                    ref
                        .read(subscriptionNotifierProvider.notifier)
                        .updateMyPlan(selectedPlan.value!);
                  },
                  buttonText: 'Submit',
                ),
                50.sH,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PlanFeatureTIle extends StatelessWidget {
  final String title;
  const PlanFeatureTIle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 10.r,
          backgroundColor: context.colorScheme.primary,
          child: Icon(
            Icons.check,
            color: context.colorScheme.surface,
            size: 15.r,
          ),
        ),
        15.sW,
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 200.w),
          child: Text(title, style: context.body14),
        ),
      ],
    );
  }
}

class StoreSubscriptionCard extends HookConsumerWidget {
  final SubscriptionModel sub;
  final int storeId;
  final Function(String)? onSelect;
  final String? selected;
  const StoreSubscriptionCard({
    super.key,
    required this.sub,
    required this.storeId,
    this.onSelect,
    this.selected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSub =
        ref.watch(currentStoreSubscriptionProvider(storeId)).valueOrNull;
    final isAnnually = useState(false);
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: selected == sub.plan?  context.colorScheme.primary:context.colorScheme.onSecondary.withValues(alpha: 0.1),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // height: 100.h,
            // width: 100.w,
            padding: EdgeInsets.symmetric(vertical: 20.h),
            decoration: BoxDecoration(
              color: sub.getColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            child: Center(
              child: Text(
                "${sub.plan.toLowerCase().capitalize} Plan",
                style: context.title32,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: isAnnually.value? "\$${sub.price?.annual.toStringAsFixed(2)}" :'\$${sub.price?.monthly.toStringAsFixed(2)}',
                      style: context.title32,
                      children: [
                        TextSpan(text:  isAnnually.value? "/year":'/month', style: context.body14Light),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 40.w,
                      height: 22.h,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Switch(
                          value: isAnnually.value,
                          onChanged: (v) {
                            isAnnually.value = v;
                          },
                          inactiveTrackColor:Colors.grey,
                          thumbColor: WidgetStatePropertyAll(
                            context.colorScheme.surface,
                          ),
                        ),
                      ),
                    ),
                     Visibility(
                      visible: isAnnually.value,
                      replacement: Text('Monthly'),
                      child: Text('Annually'),
                      ),
                  ],
                ),
                20.sH,
                ...List.generate(sub.features.length, (i) {
                  final feature = sub.features[i];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: PlanFeatureTIle(title: feature),
                  );
                }),
                10.sH,
                Center(
                  child: Visibility(
                    visible:
                        currentSub?.plan.toLowerCase() ==
                        sub.plan.toLowerCase(),
                    replacement: CustomButton(
                      color: context.colorScheme.primaryFixed,
                      textColor: context.colorScheme.primary,

                      onTap: () {
                        onSelect?.call(sub.plan);
                      },
                      buttonText: "Select plan",
                    ),
                    child: CustomButton(
                      color: context.colorScheme.onSecondary.withValues(
                        alpha: 0.05,
                      ),
                      borderColor: context.colorScheme.onSecondary.withValues(
                        alpha: 0.2,
                      ),
                      textColor: context.colorScheme.inversePrimary,
                      onTap: () {},
                      buttonText: "Current plan",
                    ),
                  ),
                ),
                20.sH,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PaidPlans extends StatelessWidget {
  final int storeId;
  final String? selectedPlan;
  final List<SubscriptionModel> subs;
  final Function(String)? onSelect;
  const PaidPlans({
    super.key,
    required this.subs,
    required this.storeId,
    this.onSelect,
    this.selectedPlan,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(subs.length, (i) {
        return Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: StoreSubscriptionCard(
            selected: selectedPlan,
            sub: subs[i],
            storeId: storeId,
            onSelect: onSelect,
          ),
        );
      }),
    );
  }
}
