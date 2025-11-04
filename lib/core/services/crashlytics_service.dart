import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class CrashlyticsService {
  final FirebaseCrashlytics crashlytics;

  CrashlyticsService(this.crashlytics) {
    initCrashlytics();
  }

  /// initCrashlytics
  Future<void> initCrashlytics() async {
    // Set Flutter error handling to use Firebase Crashlytics
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    // Enable Crashlytics collection
    await crashlytics.setCrashlyticsCollectionEnabled(true);
  }

  void logError({
    required dynamic error,
    StackTrace? stackTrace,
    String? message,
    int? errorCode,
    bool? fatal,
  }) async {
    await crashlytics.recordError(
      error,
      stackTrace,
      reason: message,
      fatal: fatal?? false,
    );
  }
}
