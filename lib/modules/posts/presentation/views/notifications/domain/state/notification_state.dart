import 'package:lykluk/core/services/network/api_response.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/data/models/notification_model.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/data/models/notification_api_models.dart';

class NotificationViewState {
  final bool isLoadingNotifications;
  final bool isMarkingAsRead;
  final bool isDeleting;
  final bool isLoadingSettings;
  final bool isUpdatingSettings;
  final bool isRefreshing;

  final List<NotificationModel> notifications;
  final NotificationSettings? settings;
  final NotificationStats? stats;
  final int unreadCount;
  final String selectedFilter;
  final int currentPage;
  final bool hasNextPage;

  final ApiResponse? notificationsResponse;
  final ApiResponse? settingsResponse;
  final ApiResponse? statsResponse;
  final ApiResponse? markAsReadResponse;
  final ApiResponse? deleteResponse;

  final String? errorMessage;

  const NotificationViewState({
    this.isLoadingNotifications = false,
    this.isMarkingAsRead = false,
    this.isDeleting = false,
    this.isLoadingSettings = false,
    this.isUpdatingSettings = false,
    this.isRefreshing = false,

    this.notifications = const [],
    this.settings,
    this.stats,
    this.unreadCount = 0,
    this.selectedFilter = 'All',
    this.currentPage = 1,
    this.hasNextPage = false,

    this.notificationsResponse,
    this.settingsResponse,
    this.statsResponse,
    this.markAsReadResponse,
    this.deleteResponse,

    this.errorMessage,
  });

  NotificationViewState copyWith({
    bool? isLoadingNotifications,
    bool? isMarkingAsRead,
    bool? isDeleting,
    bool? isLoadingSettings,
    bool? isUpdatingSettings,
    bool? isRefreshing,

    List<NotificationModel>? notifications,
    NotificationSettings? settings,
    NotificationStats? stats,
    int? unreadCount,
    String? selectedFilter,
    int? currentPage,
    bool? hasNextPage,

    ApiResponse? notificationsResponse,
    ApiResponse? settingsResponse,
    ApiResponse? statsResponse,
    ApiResponse? markAsReadResponse,
    ApiResponse? deleteResponse,

    String? errorMessage,
  }) {
    return NotificationViewState(
      isLoadingNotifications:
          isLoadingNotifications ?? this.isLoadingNotifications,
      isMarkingAsRead: isMarkingAsRead ?? this.isMarkingAsRead,
      isDeleting: isDeleting ?? this.isDeleting,
      isLoadingSettings: isLoadingSettings ?? this.isLoadingSettings,
      isUpdatingSettings: isUpdatingSettings ?? this.isUpdatingSettings,
      isRefreshing: isRefreshing ?? this.isRefreshing,

      notifications: notifications ?? this.notifications,
      settings: settings ?? this.settings,
      stats: stats ?? this.stats,
      unreadCount: unreadCount ?? this.unreadCount,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      currentPage: currentPage ?? this.currentPage,
      hasNextPage: hasNextPage ?? this.hasNextPage,

      notificationsResponse:
          notificationsResponse ?? this.notificationsResponse,
      settingsResponse: settingsResponse ?? this.settingsResponse,
      statsResponse: statsResponse ?? this.statsResponse,
      markAsReadResponse: markAsReadResponse ?? this.markAsReadResponse,
      deleteResponse: deleteResponse ?? this.deleteResponse,

      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  List<NotificationModel> get filteredNotifications {
    if (selectedFilter == 'All') {
      return notifications;
    }

    final filterType = NotificationType.values.firstWhere(
      (type) => type.filterName == selectedFilter,
      orElse: () => NotificationType.other,
    );

    return notifications
        .where((notification) => notification.type == filterType)
        .toList();
  }

  List<NotificationModel> get unreadNotifications {
    return notifications.where((notification) => !notification.isRead).toList();
  }

  int get filteredUnreadCount {
    return filteredNotifications
        .where((notification) => !notification.isRead)
        .length;
  }

  bool get isLoading {
    return isLoadingNotifications ||
        isMarkingAsRead ||
        isDeleting ||
        isLoadingSettings ||
        isUpdatingSettings ||
        isRefreshing;
  }

  bool get hasNotifications {
    return notifications.isNotEmpty;
  }

  bool get hasFilteredNotifications {
    return filteredNotifications.isNotEmpty;
  }
}
