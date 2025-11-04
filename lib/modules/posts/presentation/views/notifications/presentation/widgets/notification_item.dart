import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/data/models/notification_model.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/domain/notification_constants.dart';
import 'package:lykluk/utils/constant/font_constant.dart';
import 'package:lykluk/utils/theme/theme.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final bool showBorder;

  const NotificationItem({
    super.key,
    required this.notification,
    this.onTap,
    this.padding,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 14.w, vertical: 15.h),
        decoration: ShapeDecoration(
          color: const Color(AppColors.white),
          shape: RoundedRectangleBorder(
            side:
                showBorder
                    ? BorderSide(
                      width: 1,
                      color: const Color(NotificationConstants.borderColor),
                    )
                    : BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 44.w,
              height: 44.h,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                image:
                    notification.userAvatar != null
                        ? DecorationImage(
                          image: NetworkImage(notification.userAvatar!),
                          fit: BoxFit.cover,
                        )
                        : const DecorationImage(
                          image: NetworkImage(
                            "https://unsplash.com/photos/RgplfXbxLFs/download?ixid=M3wxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNzU0MDg3MDI2fA&force=true&w=640",
                          ),
                          fit: BoxFit.cover,
                        ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: _buildNotificationText(),
                    fontSize: 14.sp,
                    fontWeight:
                        notification.isRead ? FontWeight.w400 : FontWeight.w500,
                    color: const Color(NotificationConstants.primaryTextColor),
                    fontFamily: FontConstant.bricolage,
                    height: 1.43,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  AppText(
                    text: notification.timeAgo,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(
                      NotificationConstants.primaryTextColor,
                    ).withValues(alpha: 0.6),
                    fontFamily: FontConstant.bricolage,
                  ),
                ],
              ),
            ),
            if (!notification.isRead) ...[
              SizedBox(width: 8.w),
              Container(
                width: 8.w,
                height: 8.h,
                decoration: BoxDecoration(
                  color: const Color(NotificationConstants.activeFilterColor),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _buildNotificationText() {
    if (notification.userName != null) {
      switch (notification.type) {
        case NotificationType.request:
          return '${notification.userName} wants to connect with you';
        case NotificationType.comment:
          return '${notification.userName} commented on your post: "${notification.message}"';
        case NotificationType.mention:
          return '${notification.userName} mentioned you in a comment';
        case NotificationType.suggestion:
          return '${notification.userName} suggested you connect with someone';
        case NotificationType.community:
          return '${notification.userName} shared something in a community you follow';
        case NotificationType.podcast:
          return '${notification.userName} shared a new podcast episode';
        default:
          return notification.message;
      }
    }
    return notification.message;
  }
}
