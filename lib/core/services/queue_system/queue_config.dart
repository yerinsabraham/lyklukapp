// models/queue_config.dart
import 'dart:math' as math;

import 'package:uuid/uuid.dart';

class QueueConfig {
  final int maxRetries;
  final Duration initialRetryDelay;
  final Duration maxRetryDelay;
  final double retryBackoffFactor;
  final int maxQueueSize;
  final Duration cleanupThreshold;
  final bool persistToStorage;
  final List<int> retryableStatusCodes;

  const QueueConfig({
    this.maxRetries = 5,
    this.initialRetryDelay = const Duration(seconds: 5),
    this.maxRetryDelay = const Duration(minutes: 5),
    this.retryBackoffFactor = 2.0,
    this.maxQueueSize = 1000,
    this.cleanupThreshold = const Duration(days: 7),
    this.persistToStorage = true,
    this.retryableStatusCodes = const [
      408, // Request Timeout
      429, // Too Many Requests
      500, // Internal Server Error
      502, // Bad Gateway
      503, // Service Unavailable
      504, // Gateway Timeout
    ],
  });

  Duration getRetryDelay(int retryCount) {
    final delay = initialRetryDelay * math.pow(retryBackoffFactor, retryCount);
    return delay < maxRetryDelay ? delay : maxRetryDelay;
  }

  bool shouldRetryBasedOnStatusCode(int statusCode) {
    return retryableStatusCodes.contains(statusCode);
  }
}


// models/api_action.dart
enum ActionPriority {
  low, // Background sync, non-urgent
  normal, // Regular user actions
  high, // Critical actions that need immediate retry
}

class ApiAction {
  final String id;
  final String endpoint;
  final String method; // GET, POST, PUT, DELETE, etc.
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? body;
  final Map<String, dynamic>? queryParameters;
  final ActionPriority priority;
  final DateTime createdAt;
  final int retryCount;
  final String? failureReason;
  final DateTime? lastAttemptedAt;
  final Map<String, dynamic> customData;
  final bool hasHeaders;

  ApiAction({
    required this.endpoint,
    required this.method,
    this.headers,
    this.body,
    this.queryParameters,
    this.priority = ActionPriority.normal,
    String? id,
    DateTime? createdAt,
    this.retryCount = 0,
    this.failureReason,
    this.lastAttemptedAt,
    this.customData = const {},
    this.hasHeaders = true,

  }) : id = id ?? _generateId(),
       createdAt = createdAt ?? DateTime.now();

  static String _generateId() {
    return '${DateTime.now().microsecondsSinceEpoch}_${Uuid().v4().substring(0, 8)}';
  }

  ApiAction copyWith({
    int? retryCount,
    String? failureReason,
    DateTime? lastAttemptedAt,
    Map<String, dynamic>? customData,
    
  }) {
    return ApiAction(
      id: id,
      endpoint: endpoint,
      method: method,
      headers: headers,
      body: body,
      queryParameters: queryParameters,
      priority: priority,
      createdAt: createdAt,
      retryCount: retryCount ?? this.retryCount,
      failureReason: failureReason ?? this.failureReason,
      lastAttemptedAt: lastAttemptedAt ?? this.lastAttemptedAt,
      customData: customData ?? this.customData,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'endpoint': endpoint,
      'method': method,
      'headers': headers,
      'body': body,
      'queryParameters': queryParameters,
      'priority': priority.index,
      'createdAt': createdAt.toIso8601String(),
      'retryCount': retryCount,
      'failureReason': failureReason,
      'lastAttemptedAt': lastAttemptedAt?.toIso8601String(),
      'customData': customData,
    };
  }

  factory ApiAction.fromJson(Map<String, dynamic> json) {
    return ApiAction(
      id: json['id'],
      endpoint: json['endpoint'],
      method: json['method'],
      headers: Map<String, dynamic>.from(json['headers'] ?? {}),
      body: Map<String, dynamic>.from(json['body'] ?? {}),
      queryParameters: Map<String, dynamic>.from(json['queryParameters'] ?? {}),
      priority: ActionPriority.values[json['priority'] ?? 1],
      createdAt: DateTime.parse(json['createdAt']),
      retryCount: json['retryCount'] ?? 0,
      failureReason: json['failureReason'],
      lastAttemptedAt:
          json['lastAttemptedAt'] != null
              ? DateTime.parse(json['lastAttemptedAt'])
              : null,
      customData: Map<String, dynamic>.from(json['customData'] ?? {}),
    );
  }

  @override
  String toString() {
    return 'ApiAction($method $endpoint, retry: $retryCount, priority: $priority)';
  }
}


