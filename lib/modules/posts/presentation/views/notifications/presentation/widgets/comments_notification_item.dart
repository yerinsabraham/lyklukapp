import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/notifications.dart';
import 'package:lykluk/utils/constant/font_constant.dart';
import 'package:lykluk/utils/theme/theme.dart';

/// Specialized notification item for user comments with reply action
/// Displays user avatar and comment content
class CommentsNotificationItem extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback? onTap;
  final VoidCallback? onConnect;
  final EdgeInsets? padding;
  final bool showBorder;

  const CommentsNotificationItem({
    super.key,
    required this.notification,
    this.onTap,
    this.onConnect,
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
            // User avatar and message content
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // User avatar
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
                  // Message content
                  Expanded(child: _buildMessageContent(context)),
                ],
              ),
            ),
            SizedBox(width: 22.w),
            // Connect button
            _buildConnectButton(),
          ],
        ),
      ),
    );
  }

  /// Builds the message content with rich text formatting
  Widget _buildMessageContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'You might know ',
                style: TextStyle(
                  color: const Color(NotificationConstants.primaryTextColor),
                  fontSize: 14.sp,
                  fontFamily: FontConstant.bricolage,
                  fontWeight: FontWeight.w400,
                  height: 1.22,
                ),
              ),
              TextSpan(
                text: notification.userName ?? 'Someone',
                style: TextStyle(
                  color: const Color(NotificationConstants.primaryTextColor),
                  fontSize: 13.5.sp,
                  fontFamily: FontConstant.bricolage,
                  fontWeight: FontWeight.w700,
                  height: 1.79,
                ),
              ),
              TextSpan(
                text: '. ',
                style: TextStyle(
                  color: const Color(NotificationConstants.primaryTextColor),
                  fontSize: 14.sp,
                  fontFamily: FontConstant.bricolage,
                  fontWeight: FontWeight.w400,
                  height: 1.22,
                ),
              ),
              TextSpan(
                text: notification.timeAgo,
                style: TextStyle(
                  color: const Color(AppColors.secondaryTextColor2),
                  fontSize: 14.sp,
                  fontFamily: FontConstant.bricolage,
                  fontWeight: FontWeight.w400,
                  height: 1.22,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds the connect button
  Widget _buildConnectButton() {
    // Check if already connected
    final isConnected = notification.metadata?['status'] == 'connected';

    if (isConnected) {
      return Container(
        width: 86.w,
        height: 35.h,
        padding: EdgeInsets.all(10.w),
        decoration: ShapeDecoration(
          color: const Color(AppColors.dividerColor2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.r),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppText(
              text: 'Connected',
              style: TextStyle(
                color: const Color(NotificationConstants.primaryTextColor),
                fontSize: 12.sp,
                fontFamily: FontConstant.bricolage,
                fontWeight: FontWeight.w400,
                height: 1.32,
              ),
            ),
          ],
        ),
      );
    }

    // Show Connect button for suggested users
    return GestureDetector(
      onTap: onConnect,
      child: Container(
        width: 86.w,
        height: 35.h,
        padding: EdgeInsets.all(10.w),
        decoration: ShapeDecoration(
          color: const Color(NotificationConstants.connectedButtonColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.r),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppText(
              text: 'Connect',
              style: TextStyle(
                color: const Color(NotificationConstants.activeFilterColor),
                fontSize: 12.sp,
                fontFamily: FontConstant.bricolage,
                fontWeight: FontWeight.w400,
                height: 1.32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
