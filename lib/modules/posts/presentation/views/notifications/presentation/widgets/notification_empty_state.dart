import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/domain/notification_constants.dart';
import 'package:lykluk/utils/constant/font_constant.dart';
import 'package:lykluk/utils/constant/image_path.dart';
import 'package:lykluk/utils/theme/texts.dart';

/// Empty state widget for notifications screen
/// Displays when there are no notifications to show
class NotificationEmptyState extends StatelessWidget {
  final String? customTitle;
  final String? customSubtitle;

  const NotificationEmptyState({
    super.key,
    this.customTitle,
    this.customSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Empty state icon
          SizedBox(
            width: 92.w,
            height: 92.h,
            child: Center(
              child: SvgPicture.asset(
                width: 92.w,
                height: 92.h,
                ImagePath.notificationIcon,
                fit: BoxFit.cover,
                alignment: Alignment.center,
                theme: SvgTheme(
                  currentColor: const Color(
                    NotificationConstants.activeFilterColor,
                  ).withValues(alpha: 0.6),
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          // Title text
          SizedBox(
            width: 208.w,
            child: Opacity(
              opacity: 0.80,
              child: AppText(
                text: customTitle ?? NotificationConstants.emptyStateTitle,
                textAlign: TextAlign.center,
                color: const Color(NotificationConstants.primaryTextColor),
                fontSize: NotificationConstants.emptyStateFontSize.sp,
                fontWeight: FontWeight.w500,
                fontFamily: FontConstant.bricolage,
                height: 1.50,
              ),
            ),
          ),
          if (customSubtitle != null) ...[
            SizedBox(height: 8.h),
            SizedBox(
              width: 240.w,
              child: Opacity(
                opacity: 0.60,
                child: AppText(
                  text: customSubtitle!,
                  textAlign: TextAlign.center,
                  color: const Color(NotificationConstants.primaryTextColor),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontConstant.bricolage,
                  height: 1.43,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}


