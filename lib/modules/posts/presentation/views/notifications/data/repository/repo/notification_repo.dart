import 'package:lykluk/core/services/network/api_response.dart';

/// Contract for all Notification endpoints.
/// This interface defines all notification-related API operations
abstract class NotificationRepository {
  // ─────────────── NOTIFICATION MANAGEMENT ───────────────

  /// GET /notifications - Get user notifications with pagination and filtering
  /// Query parameters can include: page, limit, type, isRead, etc.
  Future<ApiResponse> getNotifications({Map<String, dynamic>? queryParameters});

  /// GET /notifications/{notificationId} - Get specific notification details
  Future<ApiResponse> getNotification({required String notificationId});

  /// PUT /notifications/{notificationId}/read - Mark notification as read
  Future<ApiResponse> markNotificationAsRead({required String notificationId});

  /// PUT /notifications/read-all - Mark all notifications as read
  Future<ApiResponse> markAllNotificationsAsRead();

  /// DELETE /notifications/{notificationId} - Delete a notification
  Future<ApiResponse> deleteNotification({required String notificationId});

  /// DELETE /notifications/clear-all - Clear all notifications
  Future<ApiResponse> clearAllNotifications();

  // ─────────────── NOTIFICATION SETTINGS ───────────────

  /// GET /notifications/settings - Get notification preferences/settings
  Future<ApiResponse> getNotificationSettings();

  /// PUT /notifications/settings - Update notification preferences
  Future<ApiResponse> updateNotificationSettings({
    required Map<String, dynamic> body,
  });

  // ─────────────── NOTIFICATION STATISTICS ───────────────

  /// GET /notifications/stats - Get notification statistics (unread count, etc.)
  Future<ApiResponse> getNotificationStats();

  /// GET /notifications/unread-count - Get unread notifications count
  Future<ApiResponse> getUnreadCount();
}
