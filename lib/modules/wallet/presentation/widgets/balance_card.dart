import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/core/shared/widgets/custom_button.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/theme/theme.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      width: 1.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            text: "Balance",
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Color(AppColors.textColor2),
          ),
          5.sH,

          AppText(
            text: "£ 5,000,000",
            fontSize: 24.sp,
            fontWeight: FontWeight.w500,
            color: Color(AppColors.black),
          ),
          10.sH,
          CustomElevatedButton(
            height: 45.h,

            borderColor: context.colorScheme.primary,
            radius: 10.r,
            onTap: () {
              // Navigate to Withdraw Page
            },
            buttonText: "Withdraw",
          ),
        ],
      ),
    );
  }
}
