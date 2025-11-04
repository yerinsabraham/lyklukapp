import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/utils/theme/theme.dart';

class AgreementSheet extends StatelessWidget {
  final double? fontSize;
  const AgreementSheet({super.key, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: Color(AppColors.white),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                AppTextHelpers.textSpan(
                  'By tapping “Agree and continue”, you agree to our ',
                  fontSize: fontSize ?? 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(AppColors.textColor2),
                ),
                AppTextHelpers.textSpan(
                  'Terms of Service, ',
                  fontSize: fontSize ?? 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(AppColors.black),
                ),
                AppTextHelpers.textSpan(
                  'acknowledge our ',
                  fontSize: fontSize ?? 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(AppColors.textColor2),
                ),
                AppTextHelpers.textSpan(
                  'Privacy Policy, ',
                  fontSize: fontSize ?? 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(AppColors.black),
                ),
                AppTextHelpers.textSpan(
                  'and confirm that you’re over 18. ',
                  fontSize: fontSize ?? 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(AppColors.textColor2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
