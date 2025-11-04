import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/theme/theme.dart';

class WithdrawPage extends HookConsumerWidget {
  const WithdrawPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: context.colorScheme.outline.withValues(alpha: .2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText(
                text: "Withdrawal account",
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Color(AppColors.black),
              ),
              5.sW,
              SvgPicture.asset(IconAssets.infoIcon),
            ],
          ),
          12.sH,

          Row(
            children: [
              /// Mastercard logo (use your asset here)
              SvgPicture.asset(
                IconAssets.masterCardIcon,
                height: 32.h,
                width: 32.w,
              ),
              12.sW,

              /// Card details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: "Master Card ****1234",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(AppColors.black),
                    ),
                    4.sH,
                    AppText(
                      text: "01/30",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(AppColors.textColor2),
                    ),
                  ],
                ),
              ),

              /// More menu
              GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(IconAssets.moreHorizIcon),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
