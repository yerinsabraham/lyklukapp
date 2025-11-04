import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/data/models/notification_model.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/data/models/notification_api_models.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/domain/notification_vm.dart';
import 'package:lykluk/utils/storage/local_storage.dart';
import 'package:lykluk/core/services/logger_service.dart';

final notificationDataServiceProvider = Provider<NotificationDataService>(
  (ref) => NotificationDataService(ref),
);

class NotificationDataService {
  final Ref ref;

  NotificationDataService(this.ref);

  Future<List<NotificationModel>> getNotifications({
    String? filter,
    int? page,
    int? limit,
  }) async {
    if (!HiveStorage.isLoggedIn) {
      log.w('Notifications API call attempted without authentication.');
      throw Exception('User not authenticated');
    }

    try {
      final notificationVM = ref.read(notificationViewModelProvider.notifier);
      await notificationVM.getNotifications(
        filter: filter,
        page: page,
        limit: limit,
      );

      final state = ref.read(notificationViewModelProvider);
      log.i('✅ Notifications API call successful');
      return state.filteredNotifications;
    } catch (e) {
      log.e('Notifications API call error: $e');
      rethrow;
    }
  }

  Future<void> markNotificationAsRead(String notificationId) async {
    final notificationVM = ref.read(notificationViewModelProvider.notifier);
    await notificationVM.markNotificationAsRead(notificationId);
  }

  Future<void> markAllNotificationsAsRead() async {
    final notificationVM = ref.read(notificationViewModelProvider.notifier);
    await notificationVM.markAllNotificationsAsRead();
  }

  Future<void> deleteNotification(String notificationId) async {
    final notificationVM = ref.read(notificationViewModelProvider.notifier);
    await notificationVM.deleteNotification(notificationId);
  }

  Future<void> clearAllNotifications() async {
    final notificationVM = ref.read(notificationViewModelProvider.notifier);
    await notificationVM.clearAllNotifications();
  }

  Future<int> getUnreadCount({String? filter}) async {
    final notificationVM = ref.read(notificationViewModelProvider.notifier);
    await notificationVM.getNotificationStats();

    final state = ref.read(notificationViewModelProvider);
    return filter != null ? state.filteredUnreadCount : state.unreadCount;
  }

  Future<NotificationSettings> getNotificationSettings() async {
    final notificationVM = ref.read(notificationViewModelProvider.notifier);
    await notificationVM.getNotificationSettings();

    final state = ref.read(notificationViewModelProvider);
    return state.settings ?? _getDefaultSettings();
  }

  Future<void> updateNotificationSettings(
    NotificationSettingsRequest request,
  ) async {
    final notificationVM = ref.read(notificationViewModelProvider.notifier);
    await notificationVM.updateNotificationSettings(request);
  }

  Future<NotificationStats> getNotificationStats() async {
    final notificationVM = ref.read(notificationViewModelProvider.notifier);
    await notificationVM.getNotificationStats();

    final state = ref.read(notificationViewModelProvider);
    return state.stats ?? _getDefaultStats();
  }

  Future<void> changeFilter(String filter) async {
    final notificationVM = ref.read(notificationViewModelProvider.notifier);
    await notificationVM.changeFilter(filter);
  }

  Future<void> refreshNotifications() async {
    final notificationVM = ref.read(notificationViewModelProvider.notifier);
    await notificationVM.refreshNotifications();
  }

  NotificationSettings _getDefaultSettings() {
    return const NotificationSettings(
      pushNotifications: true,
      emailNotifications: true,
      followNotifications: true,
      commentNotifications: true,
      likeNotifications: true,
      mentionNotifications: true,
    );
  }

  NotificationStats _getDefaultStats() {
    return const NotificationStats(
      totalNotifications: 0,
      unreadCount: 0,
      countByType: {},
    );
  }
}
