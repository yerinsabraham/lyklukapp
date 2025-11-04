import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/theme/theme.dart';

class PerformanceSection extends StatelessWidget {
  const PerformanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.sp),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: "Performance",
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Color(AppColors.black),
              ),
              AppText(
                text: "1 Nov - 31 Nov",
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Color(AppColors.textColor2),
              ),
            ],
          ),
          10.sH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildMetric("Qualified Views", "325k"),
              Container(
                height: 50.h,
                width: 1.w,
                decoration: BoxDecoration(
                  color: Color(AppColors.dividerColor).withValues(alpha: .5),
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              _buildMetric("Est. Earnings", "N6.5M"),
              Container(
                height: 50.h,
                width: 1.w,
                decoration: BoxDecoration(
                  color: Color(AppColors.dividerColor).withValues(alpha: .5),
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              _buildMetric("RPM", "N100k"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: title,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: Color(AppColors.textColor2),
        ),
        5.sH,
        AppText(
          text: value,
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          color: Color(AppColors.black),
        ),
      ],
    );
  }
}
