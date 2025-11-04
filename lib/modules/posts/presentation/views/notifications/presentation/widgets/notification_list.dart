import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/data/models/notification_model.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/domain/notification_constants.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/presentation/widgets/notification_empty_state.dart';
import 'package:lykluk/utils/constant/font_constant.dart';
import 'package:lykluk/utils/theme/theme.dart';

/// Notification list widget that displays notifications or empty state
/// This widget will be used when notifications are available
class NotificationList extends StatelessWidget {
  final String selectedFilter;
  final List<NotificationModel>? notifications;
  final VoidCallback? onRefresh;
  final Function(NotificationModel)? onNotificationTap;

  const NotificationList({
    super.key,
    required this.selectedFilter,
    this.notifications,
    this.onRefresh,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    // If no notifications, show empty state
    if (notifications == null || notifications!.isEmpty) {
      return NotificationEmptyState(customSubtitle: _getEmptyStateMessage());
    }

    // Future implementation: Show notification list
    return RefreshIndicator(
      onRefresh: () async {
        onRefresh?.call();
      },
      child: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: notifications!.length,
        itemBuilder: (context, index) {
          return _buildNotificationItem(context, index);
        },
      ),
    );
  }

  /// Returns appropriate empty state message based on selected filter
  String _getEmptyStateMessage() {
    switch (selectedFilter) {
      case NotificationConstants.filterRequests:
        return 'No connection requests at the moment';
      case NotificationConstants.filterComments:
        return 'No new comments on your posts';
      case NotificationConstants.filterMentions:
        return 'No one has mentioned you recently';
      case NotificationConstants.filterCommunity:
        return 'No community updates right now';
      case NotificationConstants.filterPodcasts:
        return 'No podcast notifications available';
      default:
        return 'When you receive notifications, they\'ll appear here';
    }
  }

  /// Builds individual notification item
  Widget _buildNotificationItem(BuildContext context, int index) {
    final notification = notifications![index];

    return GestureDetector(
      onTap: () => onNotificationTap?.call(notification),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: notification.isRead ? const Color(AppColors.white) : const Color(AppColors.white),
          borderRadius: BorderRadius.circular(12.r),
          border:
              notification.isRead
                  ? null
                  : Border.all(
                    color: const Color(
                      NotificationConstants.activeFilterColor,
                    ).withValues(alpha: 0.2),
                    width: 1.w,
                  ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar or notification type icon
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: _getNotificationTypeColor(notification.type),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(
                _getNotificationTypeIcon(notification.type),
                size: 20.w,
                color: const Color(AppColors.white),
              ),
            ),
            SizedBox(width: 12.w),
            // Notification content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: AppText(
                          text: notification.title,
                          fontSize: 14.sp,
                          fontWeight:
                              notification.isRead
                                  ? FontWeight.w400
                                  : FontWeight.w500,
                          color: const Color(
                            NotificationConstants.primaryTextColor,
                          ),
                          fontFamily: FontConstant.bricolage,
                        ),
                      ),
                      if (!notification.isRead)
                        Container(
                          width: 8.w,
                          height: 8.h,
                          decoration: BoxDecoration(
                            color: const Color(
                              NotificationConstants.activeFilterColor,
                            ),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  AppText(
                    text: notification.message,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(
                      NotificationConstants.primaryTextColor,
                    ).withValues(alpha: 0.7),
                    fontFamily: FontConstant.bricolage,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  AppText(
                    text: notification.timeAgo,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(
                      NotificationConstants.primaryTextColor,
                    ).withValues(alpha: 0.5),
                    fontFamily: FontConstant.bricolage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Returns color for notification type
  Color _getNotificationTypeColor(NotificationType type) {
    switch (type) {
      case NotificationType.request:
        return const Color(AppColors.successColor); // Green
      case NotificationType.comment:
        return const Color(AppColors.blueColor); // Blue
      case NotificationType.suggestion:
        return const Color(AppColors.orangeColor); // Orange
      case NotificationType.mention:
        return const Color(AppColors.purpleColor); // Purple
      case NotificationType.community:
        return const Color(AppColors.cyanColor); // Cyan
      case NotificationType.podcast:
        return const Color(AppColors.pinkColor); // Pink
      case NotificationType.other:
        return const Color(NotificationConstants.activeFilterColor);
    }
  }

  /// Returns icon for notification type
  IconData _getNotificationTypeIcon(NotificationType type) {
    switch (type) {
      case NotificationType.request:
        return Icons.person_add;
      case NotificationType.comment:
        return Icons.comment;
      case NotificationType.suggestion:
        return Icons.lightbulb;
      case NotificationType.mention:
        return Icons.alternate_email;
      case NotificationType.community:
        return Icons.group;
      case NotificationType.podcast:
        return Icons.mic;
      case NotificationType.other:
        return Icons.notifications;
    }
  }
}


