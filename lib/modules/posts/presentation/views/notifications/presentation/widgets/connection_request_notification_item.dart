import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/data/models/notification_model.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/domain/notification_constants.dart';
import 'package:lykluk/utils/constant/font_constant.dart';
import 'package:lykluk/utils/theme/theme.dart';

class ConnectionRequestNotificationItem extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback? onTap;
  final VoidCallback? onConnect;
  final VoidCallback? onDecline;
  final EdgeInsets? padding;
  final bool showBorder;

  const ConnectionRequestNotificationItem({
    super.key,
    required this.notification,
    this.onTap,
    this.onConnect,
    this.onDecline,
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
          color: Colors.white,
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
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
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
                  Expanded(child: _buildMessageContent(context)),
                ],
              ),
            ),
            SizedBox(width: 22.w),
            _buildActionButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: notification.userName ?? 'Someone',
                style: TextStyle(
                  color: const Color(NotificationConstants.primaryTextColor),
                  fontSize: 14.sp,
                  fontFamily: FontConstant.bricolage,
                  fontWeight: FontWeight.w700,
                  height: 1.79,
                ),
              ),
              TextSpan(
                text: ' sent you a connection request. ',
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

  Widget _buildActionButton() {
    final isAccepted = notification.metadata?['status'] == 'accepted';

    if (isAccepted) {
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
              text: 'Mutuals',
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
