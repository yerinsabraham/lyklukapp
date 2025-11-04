import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/ecommerce/presentation/views/market/market_page.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/theme/texts.dart';

import '../../../../../core/shared/widgets/shared_widget.dart';
import '../../../../../utils/theme/app_colors.dart';
class MarketChoicePage extends HookConsumerWidget {
  final PageController controller;
  const MarketChoicePage({super.key, required this.controller});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedInterests = useState([]);
    void toggleSelection(String interest) {
      if (selectedInterests.value.contains(interest)) {
        selectedInterests.value.remove(interest);
        selectedInterests.value = [...selectedInterests.value];
      } else {
        selectedInterests.value.add(interest);
        selectedInterests.value = [...selectedInterests.value];
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w).copyWith(bottom: 30.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.sH,
          Text('What do you like to \nshop for?', style: context.title32),
          Text(
            'Pick a few to get started',
            style: context.body16Light.copyWith(
              color: context.colorScheme.onSecondary.withValues(alpha:.6),
            ),
          ),
          20.sH,
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                children:
                    shoppingInterests.map((interest) {
                      final isSelected = selectedInterests.value.contains(
                        interest,
                      );
                      return ChoiceChip(
                        showCheckmark: false,
                        label: AppText(
                          text: interest,
                          color:
                              isSelected
                                  ? Color(AppColors.white)
                                  : Color(AppColors.textColor2),
                          fontSize: 14.sp,
                        ),
                        selected: isSelected,
                        onSelected: (_) {
                          toggleSelection(interest);
                        },
                        backgroundColor: Colors.white,
                        selectedColor: Color(AppColors.primaryColor),
                        disabledColor: Colors.transparent,
                        labelPadding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        pressElevation: 1,
                        
                           elevation: 3,
                        shadowColor: context.colorScheme.onSecondary,
                      );
                    }).toList(),
              ),
            ),
          ),
          20.sH,
          Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                  height: 60.h,

                  color: Color(AppColors.lightGrey2Color),
                  textColor: context.colorScheme.primary,
                  borderColor: context.colorScheme.onSecondary.withValues(alpha:.2),
                  onTap: () {
                    controller.previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                  buttonText: 'Back',
                ),
              ),
              10.sW,
              Expanded(
                child: CustomElevatedButton(
                  height: 60.h,
                  isDisable: selectedInterests.value.isEmpty,
                  borderColor: context.colorScheme.primary,
                  onTap: () {
                    // context.pushNamed(Routes.marketPageRoute);
                    ref.read(showMarketController.notifier).state = true;
                  },
                  buttonText: 'Start buying',
                  textDisableColor: context.colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    //   bottomNavigationBar: Padding(
    //     padding:  EdgeInsets.symmetric(horizontal: 14.w).copyWith(bottom: 30.h),
    //     child:
    //   ),
    // );
  }
}

const List shoppingInterests = [
  "Cultural items",
  "Sneakers",
  "Wears",
  "Bags",
  "Video games",
  "Books",
  "Toys & hobbies",
  "Pottery and Ceramics",
  "Electronics",
  "Sports",
  "Music",
  "Accessories",
  "Home",
  "Drinks",
  "Food & snacks",
  "Groceries",
  "Beauty",
  "Kids",
  "Arts",
  "Antiques and Decor",
  "Trading cards",
  "Religions",
  "Fashion",
  "Lifestyles",
  "Marriage",
  "Architecture",
  "Food Practices",
  "Dance",
];


    // SliverAppBar(
          //   pinned: true,
          //   automaticallyImplyLeading: false,
          //   backgroundColor: context.colorScheme.surface,
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