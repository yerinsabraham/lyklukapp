import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/app_error_widget.dart';
import 'package:lykluk/modules/auth/data/models/user_interest_model.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/helpers/app_sheet.dart';
import 'package:lykluk/utils/router/app_router.dart';
import 'package:lykluk/utils/storage/local_storage.dart';
import 'package:lykluk/utils/theme/app_colors.dart';
import 'package:lykluk/utils/theme/buttons.dart';
import 'package:lykluk/utils/theme/texts.dart';

import '../../view_model/providers/interests_provider.dart';

class ChooseInterestScreen extends HookConsumerWidget {
  const ChooseInterestScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItems = ref.watch(interestProvider);
    final selectedInterests = useState<List<int>>([]);
    toggleSelection(UserInterestModel interest) {
      selectedInterests.value =
          selectedInterests.value.contains(interest.id)
              ? selectedInterests.value
                  .where((id) => id != interest.id)
                  .toList()
              : [...selectedInterests.value, interest.id];
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: 'Choose your interests',
                fontSize: 32.sp,
                fontWeight: FontWeight.w700,
                color: Color(AppColors.black),
              ),
              SizedBox(height: 8.h),
              AppText(
                text: 'Get tailored cultural video recommendations',
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: Color(AppColors.textColor2),
              ),
              SizedBox(height: 24.h),
              asyncItems.when(
                data: (d) {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 12.w,
                        runSpacing: 12.h,
                        children:
                            d.map((interest) {
                              final isSelected = selectedInterests.value
                                  .contains(interest.id);
                              return ChoiceChip(
                                showCheckmark: false,
                                label: AppText(
                                  text: interest.interest,
                                  color:
                                      isSelected
                                          ? Color(AppColors.white)
                                          : Color(AppColors.textColor2),
                                  fontSize: 14.sp,
                                ),
                                selected: isSelected,
                                onSelected: (_) => toggleSelection(interest),
                                backgroundColor: Colors.white,
                                selectedColor: Color(AppColors.primaryColor),
                                disabledColor: Colors.transparent,
                                labelPadding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 6.h,
                                ),
                                pressElevation: 1,
                                elevation: 3,
                              );
                            }).toList(),
                      ),
                    ),
                  );
                },
                error: (e, _) {
                  return Expanded(
                    child: AppErrorWidget(
                      errorText: e.toString(),
                      asyncValue: asyncItems,
                      onRetry: () {
                        ref.invalidate(interestProvider);
                      },
                    ),
                  );
                },
                loading: () => Expanded(child: Center(child: CircularProgressIndicator(color: context.colorScheme.primary,))),
              ),
              SizedBox(height: 14.h),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      isLoading: false,
                      isDisabled: false,
                      onPressed: () {
                          HiveStorage.interests = selectedInterests.value;
                        AppRouter.router.pushNamed(Routes.navBarRoute);
                      },
                      borderRadius: BorderRadius.circular(5.r),
                      backgroundColor: const Color(AppColors.buttonColor),
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            text: 'Skip',
                            fontSize: 14.sp,
                            color: Color(AppColors.primaryColor),
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: AppButton(
                      isLoading: false,
                      isDisabled: false,
                      onPressed: () {
                        HiveStorage.interests= selectedInterests.value;
                        AppSheet.showAgreementSheet(context);
                      },
                      borderRadius: BorderRadius.circular(5.r),
                      backgroundColor: const Color(AppColors.primaryColor),
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            text: 'Next',
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
