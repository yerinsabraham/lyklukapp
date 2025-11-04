import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

import '../../../../../core/shared/widgets/shared_widget.dart';
import '../../../../../utils/theme/app_colors.dart';

class MarketGenderPage extends HookConsumerWidget {
  final PageController controller;
  const MarketGenderPage({super.key, required this.controller});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genderValue = useState<String?>(null);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.sH,
          Text('What’s your gender', style: context.title32),
          Text(
            'This allows us to suggest more \nrelevant categories!',
            style: context.body16Light.copyWith(
              color: context.colorScheme.onSecondary.withValues(alpha: .6),
            ),
          ),
          20.sH,
          CustomButton(
            height: 60.h,
            color:
                genderValue.value == "male"
                    ? context.colorScheme.primary
                    : Color(AppColors.lightGrey2Color),
            textColor:
                genderValue.value == "male"
                    ? context.colorScheme.surface
                    : context.colorScheme.primary,
            borderColor: context.colorScheme.primary,
            onTap: () {
              genderValue.value = "male";
            },
            buttonText: 'Male',
          ),
          10.sH,
          CustomButton(
            height: 60.h,
            onTap: () {
              genderValue.value = "female";
            },
            color:
                genderValue.value == "female"
                    ? context.colorScheme.primary
                    : Color(AppColors.lightGrey2Color),
            textColor:
                genderValue.value == "female"
                    ? context.colorScheme.surface
                    : context.colorScheme.primary,
            borderColor: context.colorScheme.primary,
            buttonText: 'Famale',
          ),
          10.sH,
          CustomButton(
            height: 60.h,

            onTap: () {
              genderValue.value = "non-binary";
            },
            color:
                genderValue.value == "non-binary"
                    ? context.colorScheme.primary
                    : Color(AppColors.lightGrey2Color),
            textColor:
                genderValue.value == "non-binary"
                    ? context.colorScheme.surface
                    : context.colorScheme.primary,
            borderColor: context.colorScheme.primary,
            buttonText: 'Non-binary',
          ),
          Spacer(flex: 4),
          CustomButton(
            isDisable: genderValue.value == null,
            onTap: () {
              // context.pushNamed(Routes.marketChoiceRoute);
              controller.nextPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
              );
            },
            buttonText: 'Continue',
          ),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}


  // SliverAppBar(
          //   pinned: true,
          //   backgroundColor: context.colorScheme.surface,
          //   automaticallyImplyLeading: false,
          //   scrolledUnderElevation: 0,
          //   expandedHeight: 80.h,
          //   flexibleSpace: FlexibleSpaceBar(
          //     background: Padding(
          //       padding: EdgeInsets.only(top: 60.h),
          //       child: HomeTab(
          //         backgroundColor: context.colorScheme.surface,
          //         activeIndicator: context.colorScheme.primary,
          //         inactiveIndicator: context.colorScheme.surface,
          //       ),
          //     ),
          //   ),
          // ),