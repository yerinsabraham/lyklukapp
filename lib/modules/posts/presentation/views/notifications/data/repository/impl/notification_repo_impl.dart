import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/services/network/api_response.dart';
import 'package:lykluk/core/services/network/api_service.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/data/repository/repo/notification_repo.dart';
import 'package:lykluk/core/services/network/endpoints.dart';

/// Provider for NotificationRepository
final notificationRepoProvider = Provider<NotificationRepository>(
  (ref) => NotificationRepositoryImpl(ref.read(apiServiceProvider)),
);

/// Implementation of NotificationRepository
/// Handles all notification-related API calls using the centralized ApiService
class NotificationRepositoryImpl implements NotificationRepository {
  final ApiService _apiService;

  NotificationRepositoryImpl(this._apiService);

  // ─────────────── NOTIFICATION MANAGEMENT ───────────────

  @override
  Future<ApiResponse> getNotifications({
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _apiService.getData(
      Endpoints.notifications,
      queryParameters: queryParameters,
      hasHeader: true,
    );
  }

  @override
  Future<ApiResponse> getNotification({required String notificationId}) async {
    return await _apiService.getData(
      '${Endpoints.notifications}/$notificationId',
      hasHeader: true,
    );
  }

  @override
  Future<ApiResponse> markNotificationAsRead({
    required String notificationId,
  }) async {
    return await _apiService.putData(
      '${Endpoints.notifications}/$notificationId/read',
      hasHeader: true,
    );
  }

  @override
  Future<ApiResponse> markAllNotificationsAsRead() async {
    return await _apiService.putData(
      '${Endpoints.notifications}/read-all',
      hasHeader: true,
    );
  }

  @override
  Future<ApiResponse> deleteNotification({
    required String notificationId,
  }) async {
    return await _apiService.deleteData(
      '${Endpoints.notifications}/$notificationId',
      hasHeader: true,
    );
  }

  @override
  Future<ApiResponse> clearAllNotifications() async {
    return await _apiService.deleteData(
      '${Endpoints.notifications}/clear-all',
      hasHeader: true,
    );
  }

  // ─────────────── NOTIFICATION SETTINGS ───────────────

  @override
  Future<ApiResponse> getNotificationSettings() async {
    return await _apiService.getData(
      Endpoints.notificationSettings,
      hasHeader: true,
    );
  }

  @override
  Future<ApiResponse> updateNotificationSettings({
    required Map<String, dynamic> body,
  }) async {
    return await _apiService.putData(
      Endpoints.notificationSettings,
      body: body,
      hasHeader: true,
    );
  }

  // ─────────────── NOTIFICATION STATISTICS ───────────────

  @override
  Future<ApiResponse> getNotificationStats() async {
    return await _apiService.getData(
      Endpoints.notificationStats,
      hasHeader: true,
    );
  }

  @override
  Future<ApiResponse> getUnreadCount() async {
    return await _apiService.getData(
      Endpoints.notificationUnreadCount,
      hasHeader: true,
    );
  }
}
