import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/utils/theme/theme.dart';

/// Reusable analytics card widget for studio metrics
class AnalyticsCard extends StatelessWidget {
  final String title;
  final String value;
  final String? growthPercentage;
  final String? timePeriod;
  final Color? growthColor;
  final VoidCallback? onTap;

  const AnalyticsCard({
    super.key,
    required this.title,
    required this.value,
    this.growthPercentage,
    this.timePeriod,
    this.growthColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              SizedBox(
                width: 80.w,
                child: Opacity(
                  opacity: 0.80,
                  child: AppText(
                    text: title,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(AppColors.secondaryTextColor2),
                    fontFamily: 'Figtree',
                    height: 1.47,
                  ),
                ),
              ),
              SizedBox(height: 3.h),

              // Value
              AppText(
                text: value,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: const Color(AppColors.textColor3),
                fontFamily: 'Figtree',
                height: 1.43,
              ),
              SizedBox(height: 3.h),

              // Growth indicator with icon
              if (growthPercentage != null) ...[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 14.w,
                      height: 14.h,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: Icon(
                        growthColor == const Color(AppColors.errorColor)
                            ? Icons.arrow_circle_down_sharp
                            : Icons.arrow_circle_up_sharp,
                        size: 14.sp,
                        color: growthColor ?? const Color(AppColors.successColor),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Opacity(
                      opacity: 0.80,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: growthPercentage,
                              style: TextStyle(
                                color: growthColor ?? const Color(AppColors.successColor),
                                fontSize: 12.sp,
                                fontFamily: 'Figtree',
                                fontWeight: FontWeight.w500,
                                height: 1.47,
                              ),
                            ),
                            TextSpan(
                              text: '   ',
                              style: TextStyle(
                                color: const Color(AppColors.textColor3),
                                fontSize: 12.sp,
                                fontFamily: 'Figtree',
                                fontWeight: FontWeight.w500,
                                height: 1.47,
                              ),
                            ),
                            if (timePeriod != null)
                              TextSpan(
                                text: timePeriod,
                                style: TextStyle(
                                  color: const Color(AppColors.secondaryTextColor2),
                                  fontSize: 12.sp,
                                  fontFamily: 'Figtree',
                                  fontWeight: FontWeight.w500,
                                  height: 1.47,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),

          title == 'Likes'
              ? SizedBox()
              : Row(
                children: [SizedBox(width: 15.w), _buildStraightLine(context)],
              ),
        ],
      ),
    );
  }

  Widget _buildStraightLine(BuildContext context) {
    return Container(
      width: 1.w,
      height: 60.h,
      color: const Color(AppColors.dividerColor).withValues(alpha: 0.3),
    );
  }
}
