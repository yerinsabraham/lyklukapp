import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/data/models/notification_model.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/domain/notification_constants.dart';
import 'package:lykluk/utils/constant/font_constant.dart';
import 'package:lykluk/utils/theme/theme.dart';

/// Specialized notification item for user suggestions with connect actions
/// Handles "People you might know" suggestion notifications with connect functionality
class SuggestionNotificationItem extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback? onTap;
  final VoidCallback? onConnect;
  final VoidCallback? onRemove;
  final VoidCallback? onBlock;
  final EdgeInsets? padding;
  final bool showBorder;

  const SuggestionNotificationItem({
    super.key,
    required this.notification,
    this.onTap,
    this.onConnect,
    this.onRemove,
    this.onBlock,
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
                    ? BorderSide(width: 1, color: const Color(NotificationConstants.borderColor))
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
            SizedBox(width: 13.w),
            // Action button
            _buildActionButton(),
            SizedBox(width: 13.w),
            // more options icon with tap functionality
            GestureDetector(
              onTap: () => _showOptionsMenu(context),
              child: Container(
                width: 24.w, // Increased for better touch target
                height: 24.h,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child: const Icon(
                  Icons.more_horiz,
                  size: 16,
                  color: Color(AppColors.secondaryTextColor2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the message content with suggestion text
  Widget _buildMessageContent(BuildContext context) {
    final mutualCount = notification.metadata?['mutualCount'] ?? 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // User name
        AppText(
          text: notification.userName ?? 'Someone',
          style: TextStyle(
            color: const Color(NotificationConstants.inactiveFilterColor),
            fontSize: 14.sp,
            fontFamily: FontConstant.bricolage,
            fontWeight: FontWeight.w700,
            height: 1.79,
          ),
        ),
        SizedBox(height: 2.h),
        // Mutual connections info
        AppText(
          text: '$mutualCount of your connections are mutuals',
          style: TextStyle(
            color: const Color(AppColors.secondaryTextColor2),
            fontSize: 12.sp,
            fontFamily: FontConstant.bricolage,
            fontWeight: FontWeight.w400,
            height: 1.32,
          ),
        ),
      ],
    );
  }

  /// Builds the connect action button
  Widget _buildActionButton() {
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
                color: const Color(NotificationConstants.inactiveFilterColor),
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

    // Show Connect button
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

  /// Shows options menu when more icon is tapped
  void _showOptionsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(AppColors.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder:
          (context) => Container(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle bar
                Container(
                  width: 40.w,
                  height: 4.h,
                  margin: EdgeInsets.only(bottom: 20.h),
                  decoration: BoxDecoration(
                    color: const Color(NotificationConstants.showOptionsColor),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                // Options
                _buildOptionItem(
                  'Remove suggestion',
                  Icons.visibility_off,
                  const Color(AppColors.secondaryTextColor2),
                  () {
                    Navigator.pop(context);
                    if (onRemove != null) onRemove!();
                  },
                ),
                _buildOptionItem(
                  'Block user',
                  Icons.block,
                  const Color(NotificationConstants.buildItemColor),
                  () {
                    Navigator.pop(context);
                    if (onBlock != null) onBlock!();
                  },
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
    );
  }

  /// Builds an option item for the bottom sheet menu
  Widget _buildOptionItem(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: color, size: 24.sp),
      title: AppText(
        text: title,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: color,
        fontFamily: FontConstant.bricolage,
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 4.h),
    );
  }
}
