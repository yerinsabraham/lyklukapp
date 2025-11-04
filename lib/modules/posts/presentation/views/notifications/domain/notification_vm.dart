import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/services/logger_service.dart';
import 'package:lykluk/core/services/app_analytics.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/data/models/notification_model.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/data/models/notification_api_models.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/data/repository/impl/notification_repo_impl.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/data/repository/repo/notification_repo.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/domain/state/notification_state.dart';
import 'package:lykluk/utils/helpers/toast_notification.dart';

final notificationViewModelProvider =
    NotifierProvider<NotificationViewModel, NotificationViewState>(
      NotificationViewModel.new,
    );

class NotificationViewModel extends Notifier<NotificationViewState> {
  @override
  NotificationViewState build() => const NotificationViewState();

  NotificationRepository get _repo => ref.read(notificationRepoProvider);

  void _set(NotificationViewState s) => state = s;

  void _toast(String message, {bool isSuccess = true}) {
    ToastNotification.showCustomNotification(
      title: isSuccess ? 'Success' : 'Alert',
      subtitle: message,
      isSuccess: isSuccess,
    );
  }

  void _log(String name) =>
      AppAnalytics.logEvent(name: name, parameters: {'status': 'success'});

  void _handleError(String message) {
    log.e(message);
    _set(state.copyWith(errorMessage: message));
    _toast(message, isSuccess: false);
  }

  Future<void> getNotifications({
    String? filter,
    int? page,
    int? limit,
    bool isLoadMore = false,
  }) async {
    if (!isLoadMore) {
      _set(state.copyWith(isLoadingNotifications: true, errorMessage: null));
    }

    try {
      final queryParams = <String, dynamic>{
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        if (filter != null && filter != 'All')
          'type': _getTypeValueFromFilter(filter),
      };

      final res = await _repo.getNotifications(queryParameters: queryParams);

      if (res.isSuccessful) {
        final notificationListResponse = NotificationListResponse.fromJson(
          res.data,
        );

        List<NotificationModel> newNotifications;
        if (isLoadMore && page != null && page > 1) {
          newNotifications = [
            ...state.notifications,
            ...notificationListResponse.notifications,
          ];
        } else {
          newNotifications = notificationListResponse.notifications;
        }

        _set(
          state.copyWith(
            notificationsResponse: res,
            notifications: newNotifications,
            currentPage: notificationListResponse.currentPage,
            hasNextPage: notificationListResponse.hasNextPage,
            selectedFilter: filter ?? state.selectedFilter,
            isLoadingNotifications: false,
          ),
        );

        await _updateUnreadCount();

        _log('getNotifications');
      } else {
        _handleError(res.message ?? 'Failed to load notifications');
        _set(state.copyWith(isLoadingNotifications: false));
      }
    } catch (e) {
      _handleError('Error loading notifications: $e');
      _set(state.copyWith(isLoadingNotifications: false));
    }
  }

  Future<void> markNotificationAsRead(String notificationId) async {
    _set(state.copyWith(isMarkingAsRead: true, errorMessage: null));

    try {
      final res = await _repo.markNotificationAsRead(
        notificationId: notificationId,
      );

      if (res.isSuccessful) {
        final updatedNotifications =
            state.notifications.map((notification) {
              if (notification.id == notificationId) {
                return notification.copyWith(isRead: true);
              }
              return notification;
            }).toList();

        _set(
          state.copyWith(
            markAsReadResponse: res,
            notifications: updatedNotifications,
            isMarkingAsRead: false,
          ),
        );

        await _updateUnreadCount();

        _log('markNotificationAsRead');
      } else {
        _handleError(res.message ?? 'Failed to mark notification as read');
        _set(state.copyWith(isMarkingAsRead: false));
      }
    } catch (e) {
      _handleError('Error marking notification as read: $e');
      _set(state.copyWith(isMarkingAsRead: false));
    }
  }

  Future<void> markAllNotificationsAsRead() async {
    _set(state.copyWith(isMarkingAsRead: true, errorMessage: null));

    try {
      final res = await _repo.markAllNotificationsAsRead();

      if (res.isSuccessful) {
        final updatedNotifications =
            state.notifications.map((notification) {
              return notification.copyWith(isRead: true);
            }).toList();

        _set(
          state.copyWith(
            markAsReadResponse: res,
            notifications: updatedNotifications,
            unreadCount: 0,
            isMarkingAsRead: false,
          ),
        );

        _toast(res.message ?? 'All notifications marked as read');
        _log('markAllNotificationsAsRead');
      } else {
        _handleError(res.message ?? 'Failed to mark all notifications as read');
        _set(state.copyWith(isMarkingAsRead: false));
      }
    } catch (e) {
      _handleError('Error marking all notifications as read: $e');
      _set(state.copyWith(isMarkingAsRead: false));
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    _set(state.copyWith(isDeleting: true, errorMessage: null));

    try {
      final res = await _repo.deleteNotification(
        notificationId: notificationId,
      );

      if (res.isSuccessful) {
        final updatedNotifications =
            state.notifications
                .where((notification) => notification.id != notificationId)
                .toList();

        _set(
          state.copyWith(
            deleteResponse: res,
            notifications: updatedNotifications,
            isDeleting: false,
          ),
        );

        await _updateUnreadCount();

        _toast(res.message ?? 'Notification deleted');
        _log('deleteNotification');
      } else {
        _handleError(res.message ?? 'Failed to delete notification');
        _set(state.copyWith(isDeleting: false));
      }
    } catch (e) {
      _handleError('Error deleting notification: $e');
      _set(state.copyWith(isDeleting: false));
    }
  }

  Future<void> clearAllNotifications() async {
    _set(state.copyWith(isDeleting: true, errorMessage: null));

    try {
      final res = await _repo.clearAllNotifications();

      if (res.isSuccessful) {
        _set(
          state.copyWith(
            deleteResponse: res,
            notifications: [],
            unreadCount: 0,
            isDeleting: false,
          ),
        );

        _toast(res.message ?? 'All notifications cleared');
        _log('clearAllNotifications');
      } else {
        _handleError(res.message ?? 'Failed to clear notifications');
        _set(state.copyWith(isDeleting: false));
      }
    } catch (e) {
      _handleError('Error clearing notifications: $e');
      _set(state.copyWith(isDeleting: false));
    }
  }

  Future<void> getNotificationSettings() async {
    _set(state.copyWith(isLoadingSettings: true, errorMessage: null));

    try {
      final res = await _repo.getNotificationSettings();

      if (res.isSuccessful) {
        final settings = NotificationSettings.fromJson(res.data);
        _set(
          state.copyWith(
            settingsResponse: res,
            settings: settings,
            isLoadingSettings: false,
          ),
        );

        _log('getNotificationSettings');
      } else {
        _handleError(res.message ?? 'Failed to load notification settings');
        _set(state.copyWith(isLoadingSettings: false));
      }
    } catch (e) {
      _handleError('Error loading notification settings: $e');
      _set(state.copyWith(isLoadingSettings: false));
    }
  }

  Future<void> updateNotificationSettings(
    NotificationSettingsRequest request,
  ) async {
    _set(state.copyWith(isUpdatingSettings: true, errorMessage: null));

    try {
      final res = await _repo.updateNotificationSettings(
        body: request.toJson(),
      );

      if (res.isSuccessful) {
        await getNotificationSettings();

        _toast(res.message ?? 'Settings updated successfully');
        _log('updateNotificationSettings');
      } else {
        _handleError(res.message ?? 'Failed to update settings');
        _set(state.copyWith(isUpdatingSettings: false));
      }
    } catch (e) {
      _handleError('Error updating settings: $e');
      _set(state.copyWith(isUpdatingSettings: false));
    }
  }

  Future<void> getNotificationStats() async {
    try {
      final res = await _repo.getNotificationStats();

      if (res.isSuccessful) {
        final stats = NotificationStats.fromJson(res.data);
        _set(
          state.copyWith(
            statsResponse: res,
            stats: stats,
            unreadCount: stats.unreadCount,
          ),
        );

        _log('getNotificationStats');
      } else {
        log.w('Failed to load notification stats: ${res.message}');
      }
    } catch (e) {
      log.w('Error loading notification stats: $e');
    }
  }

  Future<void> _updateUnreadCount() async {
    try {
      final res = await _repo.getUnreadCount();

      if (res.isSuccessful) {
        final unreadCount = res.data['unreadCount'] ?? 0;
        _set(state.copyWith(unreadCount: unreadCount));
      }
    } catch (e) {
      log.w('Error updating unread count: $e');
    }
  }

  Future<void> changeFilter(String filter) async {
    if (state.selectedFilter == filter) return;

    await getNotifications(filter: filter, page: 1);
  }

  Future<void> loadMoreNotifications() async {
    if (state.isLoadingNotifications || !state.hasNextPage) return;

    await getNotifications(
      filter: state.selectedFilter,
      page: state.currentPage + 1,
      isLoadMore: true,
    );
  }

  Future<void> refreshNotifications() async {
    _set(state.copyWith(isRefreshing: true));

    try {
      await Future.wait([
        getNotifications(filter: state.selectedFilter, page: 1),
        getNotificationStats(),
      ]);
    } finally {
      _set(state.copyWith(isRefreshing: false));
    }
  }

  void clearError() {
    _set(state.copyWith(errorMessage: null));
  }

  void resetState() {
    state = const NotificationViewState();
  }

  String? _getTypeValueFromFilter(String filter) {
    final type = NotificationType.values.firstWhere(
      (type) => type.filterName == filter,
      orElse: () => NotificationType.other,
    );
    return type == NotificationType.other ? null : type.value;
  }
}
