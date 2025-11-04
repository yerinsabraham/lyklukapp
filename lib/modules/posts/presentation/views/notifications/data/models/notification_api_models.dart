import 'package:lykluk/modules/posts/presentation/views/notifications/data/models/notification_model.dart';

/// API models for notification endpoints
/// These models handle API request/response data structures

/// Request model for updating notification settings
class NotificationSettingsRequest {
  final bool? pushNotifications;
  final bool? emailNotifications;
  final bool? followNotifications;
  final bool? commentNotifications;
  final bool? likeNotifications;
  final bool? mentionNotifications;
  final Map<String, dynamic>? additionalSettings;

  const NotificationSettingsRequest({
    this.pushNotifications,
    this.emailNotifications,
    this.followNotifications,
    this.commentNotifications,
    this.likeNotifications,
    this.mentionNotifications,
    this.additionalSettings,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};

    if (pushNotifications != null) {
      json['pushNotifications'] = pushNotifications;
    }
    if (emailNotifications != null) {
      json['emailNotifications'] = emailNotifications;
    }
    if (followNotifications != null) {
      json['followNotifications'] = followNotifications;
    }
    if (commentNotifications != null) {
      json['commentNotifications'] = commentNotifications;
    }
    if (likeNotifications != null) {
      json['likeNotifications'] = likeNotifications;
    }
    if (mentionNotifications != null) {
      json['mentionNotifications'] = mentionNotifications;
    }
    if (additionalSettings != null) json.addAll(additionalSettings!);

    return json;
  }
}

/// Response model for notification settings
class NotificationSettings {
  final bool pushNotifications;
  final bool emailNotifications;
  final bool followNotifications;
  final bool commentNotifications;
  final bool likeNotifications;
  final bool mentionNotifications;
  final Map<String, dynamic>? additionalSettings;

  const NotificationSettings({
    required this.pushNotifications,
    required this.emailNotifications,
    required this.followNotifications,
    required this.commentNotifications,
    required this.likeNotifications,
    required this.mentionNotifications,
    this.additionalSettings,
  });

  factory NotificationSettings.fromJson(Map<String, dynamic> json) {
    return NotificationSettings(
      pushNotifications: json['pushNotifications'] ?? true,
      emailNotifications: json['emailNotifications'] ?? true,
      followNotifications: json['followNotifications'] ?? true,
      commentNotifications: json['commentNotifications'] ?? true,
      likeNotifications: json['likeNotifications'] ?? true,
      mentionNotifications: json['mentionNotifications'] ?? true,
      additionalSettings: json['additionalSettings'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pushNotifications': pushNotifications,
      'emailNotifications': emailNotifications,
      'followNotifications': followNotifications,
      'commentNotifications': commentNotifications,
      'likeNotifications': likeNotifications,
      'mentionNotifications': mentionNotifications,
      if (additionalSettings != null) ...additionalSettings!,
    };
  }

  NotificationSettings copyWith({
    bool? pushNotifications,
    bool? emailNotifications,
    bool? followNotifications,
    bool? commentNotifications,
    bool? likeNotifications,
    bool? mentionNotifications,
    Map<String, dynamic>? additionalSettings,
  }) {
    return NotificationSettings(
      pushNotifications: pushNotifications ?? this.pushNotifications,
      emailNotifications: emailNotifications ?? this.emailNotifications,
      followNotifications: followNotifications ?? this.followNotifications,
      commentNotifications: commentNotifications ?? this.commentNotifications,
      likeNotifications: likeNotifications ?? this.likeNotifications,
      mentionNotifications: mentionNotifications ?? this.mentionNotifications,
      additionalSettings: additionalSettings ?? this.additionalSettings,
    );
  }
}

/// Response model for notification statistics
class NotificationStats {
  final int totalNotifications;
  final int unreadCount;
  final Map<String, int> countByType;
  final DateTime? lastNotificationAt;

  const NotificationStats({
    required this.totalNotifications,
    required this.unreadCount,
    required this.countByType,
    this.lastNotificationAt,
  });

  factory NotificationStats.fromJson(Map<String, dynamic> json) {
    return NotificationStats(
      totalNotifications: json['totalNotifications'] ?? 0,
      unreadCount: json['unreadCount'] ?? 0,
      countByType: Map<String, int>.from(json['countByType'] ?? {}),
      lastNotificationAt:
          json['lastNotificationAt'] != null
              ? DateTime.parse(json['lastNotificationAt'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalNotifications': totalNotifications,
      'unreadCount': unreadCount,
      'countByType': countByType,
      'lastNotificationAt': lastNotificationAt?.toIso8601String(),
    };
  }
}

/// Response model for paginated notifications
class NotificationListResponse {
  final List<NotificationModel> notifications;
  final int totalCount;
  final int currentPage;
  final int totalPages;
  final bool hasNextPage;
  final bool hasPreviousPage;

  const NotificationListResponse({
    required this.notifications,
    required this.totalCount,
    required this.currentPage,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  factory NotificationListResponse.fromJson(Map<String, dynamic> json) {
    return NotificationListResponse(
      notifications:
          (json['data'] as List?)
              ?.map((item) => NotificationModel.fromJson(item))
              .toList() ??
          [],
      totalCount: json['totalCount'] ?? 0,
      currentPage: json['currentPage'] ?? 1,
      totalPages: json['totalPages'] ?? 1,
      hasNextPage: json['hasNextPage'] ?? false,
      hasPreviousPage: json['hasPreviousPage'] ?? false,
    );
  }
}

/// Enhanced NotificationModel for API compatibility
/// Extends the existing NotificationModel with additional API fields
extension NotificationModelApi on NotificationModel {
  /// Create NotificationModel from API response
  static NotificationModel fromApiJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? json['_id'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? json['body'] ?? '',
      type: NotificationType.fromString(json['type'] ?? 'other'),
      createdAt: DateTime.parse(
        json['createdAt'] ??
            json['timestamp'] ??
            DateTime.now().toIso8601String(),
      ),
      isRead: json['isRead'] ?? json['read'] ?? false,
      userId: json['userId'] ?? json['fromUserId'],
      userName: json['userName'] ?? json['fromUserName'],
      userAvatar: json['userAvatar'] ?? json['fromUserAvatar'],
      metadata: json['metadata'] ?? json['data'],
    );
  }

  /// Convert to API format
  Map<String, dynamic> toApiJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'body': message, // API might use 'body' instead of 'message'
      'type': type.value,
      'createdAt': createdAt.toIso8601String(),
      'timestamp': createdAt.toIso8601String(), // API might use 'timestamp'
      'isRead': isRead,
      'read': isRead, // API might use 'read' instead of 'isRead'
      'userId': userId,
      'fromUserId': userId, // API might use 'fromUserId'
      'userName': userName,
      'fromUserName': userName, // API might use 'fromUserName'
      'userAvatar': userAvatar,
      'fromUserAvatar': userAvatar, // API might use 'fromUserAvatar'
      'metadata': metadata,
      'data': metadata, // API might use 'data' instead of 'metadata'
    };
  }
}
