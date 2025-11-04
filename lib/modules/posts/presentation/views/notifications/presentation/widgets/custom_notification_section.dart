import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/data/models/notification_model.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/domain/notification_constants.dart';
import 'package:lykluk/utils/constant/font_constant.dart';
import 'package:lykluk/utils/theme/app_colors.dart';
import 'package:lykluk/utils/theme/texts.dart';

/// Custom notification section widget for requests screen
/// Allows custom item builder for specialized notification types
class CustomNotificationSection extends StatelessWidget {
  final String title;
  final List<NotificationModel> notifications;
  final Widget Function(NotificationModel) itemBuilder;
  final EdgeInsets? padding;

  const CustomNotificationSection({
    super.key,
    required this.title,
    required this.notifications,
    required this.itemBuilder,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    if (notifications.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: padding ?? EdgeInsets.only(top: 20.h),
      decoration: const BoxDecoration(color: Color(AppColors.white)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: AppText(
              text: title,
              color: const Color(NotificationConstants.primaryTextColor),
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              fontFamily: FontConstant.bricolage,
              height: 1.40,
            ),
          ),
          // Notifications list
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:
                  notifications.map((notification) {
                    return itemBuilder(notification);
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}


