import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/services/logger_service.dart';
import 'package:riverpod/riverpod.dart';

final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  return AnalyticsService();
});

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  Future<void> logScreenView(BuildContext context) async {
    final screenName = context.widget.runtimeType.toString();
    await _analytics.logScreenView(screenName: screenName);
    _analytics.logEvent(name: screenName, parameters: {'event': screenName});
  }
}

class AppAnalytics {
  AppAnalytics._();
  int counter = 0;
  static final analytics = FirebaseAnalytics.instance;

  incrementCounter() {
    counter++;
  }

  static void logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    try {
      await analytics.logEvent(name: name, parameters: parameters);
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: 'Analytics cant logEvent',
        errorCode: 'Analytics error',
      );
    }
  }
  Future<void> setCurrentScreen({
    required String screenName,
    Map<String, Object>? parameters,
  }) async {
    await analytics.logScreenView(
      screenName: screenName,
      parameters: parameters,
    );
  }

  Future<void> setUserId(String? userId) async {
    await analytics.setUserId(id: userId);
  }

  Future<void> setUserProperty({
    required String name,
    required String? value,
  }) async {
    await analytics.setUserProperty(name: name, value: value);
  }
}

class AnalyticsLoggingScreen extends StatefulWidget {
  final Widget child;

  const AnalyticsLoggingScreen({super.key, required this.child});

  @override
  State<AnalyticsLoggingScreen> createState() => _AnalyticsLoggingScreenState();
}

class _AnalyticsLoggingScreenState extends State<AnalyticsLoggingScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // add setCurrentScreeninstead of initState because might not always give you the
    // expected results because initState() is called before the widget
    // is fully initialized, so the screen might not be visible yet.
    AnalyticsService().logScreenView(context);
  }

  @override
  Widget build(BuildContext context) {
    // Log the screen view
    AnalyticsService().logScreenView(context);
    log.d('CURRENT SCREEN ${widget.child}');
    return widget.child;
  }
}
