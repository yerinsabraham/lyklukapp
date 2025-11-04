import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/data/models/notification_model.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/domain/notification_constants.dart';
import 'package:lykluk/utils/constant/font_constant.dart';
import 'package:lykluk/utils/theme/theme.dart';

/// Specialized notification item for mention notifications
/// Handles mentions with highlighted @username text and proper formatting
class MentionNotificationItem extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final bool showBorder;

  const MentionNotificationItem({
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
            padding ?? EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: ShapeDecoration(
          color: Colors.white,
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
            SizedBox(width: 38.w),
            // Post preview thumbnail (optional)
            _buildPostThumbnail(),
          ],
        ),
      ),
    );
  }

  /// Builds the message content with mention highlighting
  Widget _buildMessageContent(BuildContext context) {
    final postText = notification.metadata?['postText'] ?? '';
    final mention = notification.metadata?['mention'] ?? '@realculture';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              // Username
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
              // Spacing (matching design)
              TextSpan(
                text: '         ',
                style: TextStyle(
                  color: const Color(NotificationConstants.primaryTextColor),
                  fontSize: 14.sp,
                  fontFamily: FontConstant.bricolage,
                  fontWeight: FontWeight.w500,
                  height: 1.24,
                ),
              ),
              // Action text
              TextSpan(
                text: 'mentioned you on a post: "',
                style: TextStyle(
                  color: const Color(NotificationConstants.primaryTextColor),
                  fontSize: 14.sp,
                  fontFamily: FontConstant.bricolage,
                  fontWeight: FontWeight.w400,
                  height: 1.22,
                ),
              ),
              // Highlighted mention
              TextSpan(
                text: mention,
                style: TextStyle(
                  color: const Color(NotificationConstants.activeFilterColor),
                  fontSize: 14.sp,
                  fontFamily: FontConstant.bricolage,
                  fontWeight: FontWeight.w400,
                  height: 1.22,
                ),
              ),
              // Rest of post text
              TextSpan(
                text: _getPostTextAfterMention(postText, mention),
                style: TextStyle(
                  color: const Color(NotificationConstants.primaryTextColor),
                  fontSize: 14.sp,
                  fontFamily: FontConstant.bricolage,
                  fontWeight: FontWeight.w400,
                  height: 1.22,
                ),
              ),
              // Closing quote and time
              TextSpan(
                text: '" ',
                style: TextStyle(
                  color: const Color(NotificationConstants.primaryTextColor),
                  fontSize: 14.sp,
                  fontFamily: FontConstant.bricolage,
                  fontWeight: FontWeight.w400,
                  height: 1.22,
                ),
              ),
              // Time ago
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

  /// Builds the post thumbnail preview (placeholder)
  Widget _buildPostThumbnail() {
    return Container(
      width: 42.w,
      height: 66.h,
      decoration: ShapeDecoration(
        color: const Color(AppColors.dividerColor2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
      ),
      child: const Icon(Icons.image, size: 24, color: Color(AppColors.secondaryTextColor2)),
    );
  }

  /// Extracts the post text after the mention
  String _getPostTextAfterMention(String postText, String mention) {
    if (postText.isEmpty) return ' Honoured to wit...';

    final mentionIndex = postText.indexOf(mention);
    if (mentionIndex == -1) return ' $postText';

    final afterMention = postText.substring(mentionIndex + mention.length);
    return afterMention.isNotEmpty ? afterMention : ' Honoured to wit...';
  }
}


