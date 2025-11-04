// services/queue_service.dart
import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/services/services.dart';
import 'package:lykluk/core/services/queue_system/queue_config.dart';

final  queueServiceProvider= Provider((ref)=> QueueService(apiClient: ref.read(apiServiceProvider)));

class QueueService {
  final QueueConfig config;
  final ApiService apiClient;
  // final QueueStorage? storage;

  final List<ApiAction> _pendingActions = [];
  final StreamController<List<ApiAction>> _queueController =
      StreamController<List<ApiAction>>.broadcast();

  bool _isProcessing = false;
  bool _isPaused = false;
  Timer? _cleanupTimer;

  QueueService({required this.apiClient,  QueueConfig? config})
    : config = config ?? const QueueConfig() {
    _initialize();
  }

  Future<void> _initialize() async {
   

    // Start processing if there are pending actions
    if (_pendingActions.isNotEmpty) {
      _processQueue();
    }
  }

  // Public API

  Stream<List<ApiAction>> get queueStream => _queueController.stream;

  List<ApiAction> get pendingActions => List.from(_pendingActions);
  int get queueSize => _pendingActions.length;
  bool get isProcessing => _isProcessing;
  bool get isPaused => _isPaused;

  Future<void> addToQueue({
    required String endpoint,
    required String method,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    ActionPriority priority = ActionPriority.normal,
    Map<String, dynamic> customData = const {},
    bool hasHeaders = true,
  }) async {
    final action = ApiAction(
      endpoint: endpoint,
      method: method,
      headers: headers,
      body: body,
      queryParameters: queryParameters,
      priority: priority,
      customData: customData,
      hasHeaders: hasHeaders,
    );

    return addActionToQueue(action);
  }

  Future<void> addActionToQueue(ApiAction action) async {
    if (_pendingActions.length >= config.maxQueueSize) {
      throw Exception('Queue is full. Max size: ${config.maxQueueSize}');
    }

    // Insert based on priority (high priority first, then by creation time)
    final index = _pendingActions.indexWhere(
      (existing) => existing.priority.index < action.priority.index,
    );

    if (index == -1) {
      _pendingActions.add(action);
    } else {
      _pendingActions.insert(index, action);
    }

    _notifyQueueChanged();

    if (!_isPaused) {
      _processQueue();
    }
  }

  Future<void> retryAction(String actionId) async {
    final actionIndex = _pendingActions.indexWhere(
      (action) => action.id == actionId,
    );
    if (actionIndex == -1) return;

    final action = _pendingActions[actionIndex];
    final updatedAction = action.copyWith(
      retryCount: 0,
      failureReason: null,
      lastAttemptedAt: DateTime.now(),
    );

    _pendingActions[actionIndex] = updatedAction;
    _notifyQueueChanged();

    if (!_isPaused) {
      _processQueue();
    }
  }

  Future<void> removeAction(String actionId) async {
    _pendingActions.removeWhere((action) => action.id == actionId);
    _notifyQueueChanged();
  }

  Future<void> clearQueue() async {
    _pendingActions.clear();
    _notifyQueueChanged();
  }

  void pause() {
    _isPaused = true;
  }

  void resume() {
    _isPaused = false;
    _processQueue();
  }

  // Queue processing

  Future<void> _processQueue() async {
    if (_isProcessing || _isPaused || _pendingActions.isEmpty) return;

    _isProcessing = true;

    while (_pendingActions.isNotEmpty && !_isPaused) {
      final action = _pendingActions.first;

      try {
        final response = await apiClient.execute(action);

        if (response.isSuccessful ||
            !config.shouldRetryBasedOnStatusCode(response.statusCode?? 500) ||
            action.retryCount >= config.maxRetries) {
          // Action completed or reached max retries
          _pendingActions.removeAt(0);

        } else {
          // Retry the action
          await _handleRetry(action, response.statusCode ?? 500);
        }
      } catch (e) {
        // Network or other errors
        await _handleRetry(action, 0, e.toString());
      }

      _notifyQueueChanged();

      // Small delay between processing
      await Future.delayed(const Duration(milliseconds: 100));
    }

    _isProcessing = false;
  }

  Future<void> _handleRetry(
    ApiAction action,
    int statusCode, [
    String? error,
  ]) async {
    if (action.retryCount >= config.maxRetries) {
      // Max retries reached, remove from queue
      _pendingActions.removeAt(0);
      return;
    }

    final updatedAction = action.copyWith(
      retryCount: action.retryCount + 1,
      failureReason: error ?? 'HTTP $statusCode',
      lastAttemptedAt: DateTime.now(),
    );

    // Move to end of queue for retry
    _pendingActions.removeAt(0);
    _pendingActions.add(updatedAction);

    // Wait before next retry attempt
    final delay = config.getRetryDelay(updatedAction.retryCount);
    await Future.delayed(delay);
  }




  // Future<void> _cleanupOldActions() async {
  //   final threshold = DateTime.now().subtract(config.cleanupThreshold);
  //   _pendingActions.removeWhere(
  //     (action) => action.createdAt.isBefore(threshold),
  //   );

  //   if (_pendingActions.isNotEmpty) {
  //     _notifyQueueChanged();
  //   }
  // }

  void _notifyQueueChanged() {
    if (!_queueController.isClosed) {
      _queueController.add(pendingActions);
    }
  }

  // Cleanup

  Future<void> dispose() async {
    _cleanupTimer?.cancel();
    _isProcessing = false;
    _isPaused = true;
    _queueController.close();

    // await storage?.close();
  }
}
