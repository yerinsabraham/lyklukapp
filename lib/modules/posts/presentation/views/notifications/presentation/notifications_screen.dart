import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/notifications.dart';
import 'package:lykluk/utils/helpers/toast_notification.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  final String? initialFilter;

  const NotificationsScreen({super.key, this.initialFilter});

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  bool _isLoading = false;
  late String selectedFilter;
  Map<String, List<NotificationModel>> _notificationsByTime = {};

  @override
  void initState() {
    super.initState();
    selectedFilter = widget.initialFilter ?? NotificationConstants.filterAll;
    _loadNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(NotificationConstants.backgroundColor),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: [
            NotificationHeader(
              selectedFilter: selectedFilter,
              onFilterChanged: _onFilterChanged,
            ),
            Expanded(child: _buildContent()),
          ],
        ),
      ),
    );
  }

  void _onFilterChanged(String filter) {
    setState(() {
      selectedFilter = filter;
    });
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final notificationDataService = ref.read(notificationDataServiceProvider);

      final notifications = await notificationDataService.getNotifications(
        filter: selectedFilter,
      );

      _notificationsByTime = _groupNotificationsByTimePeriod(
        notifications,
        selectedFilter,
      );

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ToastNotification.showCustomNotification(
          title: 'Error',
          subtitle: 'Failed to load notifications',
          isSuccess: false,
        );
      }
    }
  }

  Map<String, List<NotificationModel>> _groupNotificationsByTimePeriod(
    List<NotificationModel> notifications,
    String filter,
  ) {
    final now = DateTime.now();
    Map<String, List<NotificationModel>> grouped = {};

    switch (filter) {
      case NotificationConstants.filterRequests:
        grouped = {
          'New': [],
          'Last 7 days': [],
          'Last 30 days': [],
          'Suggested for you': [],
        };
        break;
      case NotificationConstants.filterSuggestions:
        grouped = {'Today': [], 'This Week': [], 'Earlier': []};
        break;
      case NotificationConstants.filterMentions:
        grouped = {'New': [], 'Last 7 days': []};
        break;
      default:
        grouped = {
          'New': [],
          'Last 7 days': [],
          'Last 30 days': [],
          'Earlier': [],
        };
        break;
    }

    for (final notification in notifications) {
      final difference = now.difference(notification.createdAt);

      if (filter == NotificationConstants.filterRequests) {
        if (difference.inHours < 24) {
          grouped['New']!.add(notification);
        } else if (difference.inDays <= 7) {
          grouped['Last 7 days']!.add(notification);
        } else if (difference.inDays <= 30) {
          grouped['Last 30 days']!.add(notification);
        } else {
          grouped['Suggested for you']!.add(notification);
        }
      } else if (filter == NotificationConstants.filterSuggestions) {
        if (difference.inHours < 24) {
          grouped['Today']!.add(notification);
        } else if (difference.inDays <= 7) {
          grouped['This Week']!.add(notification);
        } else {
          grouped['Earlier']!.add(notification);
        }
      } else if (filter == NotificationConstants.filterMentions) {
        if (difference.inHours < 24) {
          grouped['New']!.add(notification);
        } else if (difference.inDays <= 7) {
          grouped['Last 7 days']!.add(notification);
        }
      } else {
        if (difference.inHours < 24) {
          grouped['New']!.add(notification);
        } else if (difference.inDays <= 7) {
          grouped['Last 7 days']!.add(notification);
        } else if (difference.inDays <= 30) {
          grouped['Last 30 days']!.add(notification);
        } else {
          grouped['Earlier']!.add(notification);
        }
      }
    }

    grouped.removeWhere((key, value) => value.isEmpty);
    return grouped;
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(NotificationConstants.activeFilterColor),
        ),
      );
    }

    final hasNotifications = _notificationsByTime.values.any(
      (notifications) => notifications.isNotEmpty,
    );

    if (!hasNotifications) {
      return RefreshIndicator(
        onRefresh: _loadNotifications,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: NotificationEmptyState(
              customTitle: _getEmptyStateTitle(),
              customSubtitle: _getEmptyStateSubtitle(),
            ),
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadNotifications,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 12.h),
            ..._buildNotificationSections(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildNotificationSections() {
    if (selectedFilter == NotificationConstants.filterSuggestions) {
      return _notificationsByTime.entries.map((entry) {
        return CustomNotificationSection(
          title: '   People',
          notifications: entry.value,
          itemBuilder: (notification) => _buildNotificationItem(notification),
        );
      }).toList();
    } else if (_shouldUseCustomSections()) {
      return _notificationsByTime.entries.map((entry) {
        return CustomNotificationSection(
          title: '   ${entry.key}',
          notifications: entry.value,
          itemBuilder: (notification) => _buildNotificationItem(notification),
        );
      }).toList();
    } else {
      return _notificationsByTime.entries.map((entry) {
        return NotificationSection(
          title: entry.key,
          notifications: entry.value,
        );
      }).toList();
    }
  }

  bool _shouldUseCustomSections() {
    return selectedFilter != NotificationConstants.filterAll;
  }

  Widget _buildNotificationItem(NotificationModel notification) {
    switch (notification.type) {
      case NotificationType.request:
        return ConnectionRequestNotificationItem(
          notification: notification,
          onTap: () => _handleNotificationTap(notification),
          onConnect: () => _handleConnect(notification),
          onDecline: () => _handleDecline(notification),
          showBorder: true,
        );
      case NotificationType.suggestion:
        return SuggestionNotificationItem(
          notification: notification,
          onTap: () => _handleNotificationTap(notification),
          onConnect: () => _handleConnect(notification),
          onRemove: () => _handleRemoveSuggestion(notification),
          onBlock: () => _handleBlockUser(notification),
          showBorder: true,
        );
      case NotificationType.mention:
        return MentionNotificationItem(
          notification: notification,
          onTap: () => _handleNotificationTap(notification),
          showBorder: true,
        );
      case NotificationType.comment:
        return CommentsNotificationItem(
          notification: notification,
          onTap: () => _handleNotificationTap(notification),
          showBorder: true,
        );
      case NotificationType.community:
        return CommentsNotificationItem(
          notification: notification,
          onTap: () => _handleNotificationTap(notification),
          showBorder: true,
        );
      case NotificationType.podcast:
        return CommentsNotificationItem(
          notification: notification,
          onTap: () => _handleNotificationTap(notification),
          showBorder: true,
        );
      default:
        return NotificationItem(
          notification: notification,
          onTap: () => _handleNotificationTap(notification),
        );
    }
  }

  void _handleNotificationTap(NotificationModel notification) {
    final notificationDataService = ref.read(notificationDataServiceProvider);
    notificationDataService.markNotificationAsRead(notification.id);

    ToastNotification.showCustomNotification(
      title: 'Notification opened',
      subtitle: 'Navigating to ${notification.type.value}...',
      isSuccess: true,
    );

    _loadNotifications();
  }

  void _handleConnect(NotificationModel notification) {
    final action =
        notification.type == NotificationType.request
            ? 'Connected'
            : 'Connected';
    ToastNotification.showCustomNotification(
      title: '$action!',
      subtitle: 'You are now connected with ${notification.userName}',
      isSuccess: true,
    );

    _loadNotifications();
  }

  void _handleDecline(NotificationModel notification) {
    final notificationDataService = ref.read(notificationDataServiceProvider);
    notificationDataService.deleteNotification(notification.id);

    ToastNotification.showCustomNotification(
      title: 'Declined',
      subtitle: 'Connection request declined',
      isSuccess: true,
    );

    _loadNotifications();
  }

  void _handleRemoveSuggestion(NotificationModel notification) {
    final notificationDataService = ref.read(notificationDataServiceProvider);
    notificationDataService.deleteNotification(notification.id);

    ToastNotification.showCustomNotification(
      title: 'Removed',
      subtitle: 'Suggestion removed from your feed',
      isSuccess: true,
    );

    _loadNotifications();
  }

  void _handleBlockUser(NotificationModel notification) {
    final notificationDataService = ref.read(notificationDataServiceProvider);
    notificationDataService.deleteNotification(notification.id);

    ToastNotification.showCustomNotification(
      title: 'User blocked',
      subtitle: '${notification.userName} has been blocked',
      isSuccess: true,
    );

    _loadNotifications();
  }

  String _getEmptyStateTitle() {
    switch (selectedFilter) {
      case NotificationConstants.filterRequests:
        return 'No connection requests';
      case NotificationConstants.filterComments:
        return 'No comments yet';
      case NotificationConstants.filterSuggestions:
        return 'No suggestions yet';
      case NotificationConstants.filterMentions:
        return 'No mentions yet';
      case NotificationConstants.filterCommunity:
        return 'No community updates';
      case NotificationConstants.filterPodcasts:
        return 'No podcast notifications';
      default:
        return NotificationConstants.emptyStateTitle;
    }
  }

  String _getEmptyStateSubtitle() {
    switch (selectedFilter) {
      case NotificationConstants.filterRequests:
        return 'When someone sends you a connection request, it will appear here';
      case NotificationConstants.filterComments:
        return 'When someone comments on your posts, you\'ll see them here';
      case NotificationConstants.filterSuggestions:
        return 'We\'ll suggest people you might know based on your connections';
      case NotificationConstants.filterMentions:
        return 'When someone mentions you in a post or comment, it will appear here';
      case NotificationConstants.filterCommunity:
        return 'Community updates and posts will appear here';
      case NotificationConstants.filterPodcasts:
        return 'Podcast notifications and updates will appear here';
      default:
        return NotificationConstants.emptyStateSubtitle;
    }
  }
}
