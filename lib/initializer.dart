// app_startup.dart
// ───────────────────────────────────────────────────────────────────────────
// One-stop bootstrap:  ▸ Firebase ▸ Crashlytics ▸ Hive ▸ RemoteConfig
//                      ▸ FCM & local-notifications  (iOS + Android)
// ───────────────────────────────────────────────────────────────────────────

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/services/logger_service.dart';
import 'package:lykluk/core/services/remote_config.dart';
import 'package:lykluk/firebase_options.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/storage/local_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

/// Public 1-liner: call `AppInitializer.initialize()` before `runApp()`.
class AppInitializer {
  static bool _booted = false;

  static Future<void> initialize() async {
    if (_booted) return;
    _booted = true;

    await _initFirebase();
    await _initHive();
    await _initCrashlytics();
    // await _initTTSDK();

    // Notifications (foreground isolate)
    await NotificationsController().initialize();
    await NotificationsController().getToken();

    await _initRemoteConfig();
    _cacheAppVersion();
  }

  // ────────────────────────────────────────────────────────────────────────
  static Future<void> _initFirebase() async {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        name: 'lykluk-app',
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  }

  static Future<void> _initCrashlytics() async {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }

  //Lykluk
  static Future<void> _initHive() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    await Hive.openBox<dynamic>('app_hive');
    await Hive.openBox<dynamic>('app_stable_hive');
  }

  static Future<void> _initRemoteConfig() async {
    final container = ProviderContainer();
    final rc = container.read(remoteConfigServiceProvider);
    try {
      await rc.initialize();
      log.d('✅ Remote Config initialised');
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: 'Remote-Config init failed',
      );
    }
  }

  static Future<void> _cacheAppVersion() async {
    final p = await PackageInfo.fromPlatform();
    LocalAppStorage.appVersion = p.buildNumber;
    log.d('App v${p.version}+${p.buildNumber}');
  }
}

// ───────────────────────────────────────────────────────────────────────────
// NOTIFICATIONS  (push + local)
// ───────────────────────────────────────────────────────────────────────────

final NotificationsController notificationController =
    NotificationsController();

class NotificationsController {
  NotificationsController._internal();
  static final NotificationsController _instance =
      NotificationsController._internal();
  factory NotificationsController() => _instance;

  final FlutterLocalNotificationsPlugin _fln =
      FlutterLocalNotificationsPlugin();
  bool _initialised = false;

  /// Call once (AppInitializer already does this).
  Future<void> initialize() async {
    if (_initialised) return;
    _initialised = true;

    // ---- Local-notifications set-up ----------------------------
    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/launcher_icon'),
      iOS: DarwinInitializationSettings(),
    );

    await _fln.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onTap,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    _setupInteractMessages();
  }

  // ---- FCM permissions + listeners ---------------------------
  void requestPermission() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // ──────────────────────────────────────────────────────────────
  // INCOMING MESSAGES (any state)
  // ──────────────────────────────────────────────────────────────
  Future<void> messageHandler(RemoteMessage m) async {
    if (!_initialised) await initialize();

    final title = m.notification?.title ?? 'New notification';
    final body = m.notification?.body ?? '';

    const channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'Channel for important notifications',
      importance: Importance.high,
    );

    final bigText = BigTextStyleInformation(
      body,
      contentTitle: '<b>$title</b>',
      htmlFormatContentTitle: true,
      summaryText: body,
    );

    await _fln.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          importance: Importance.high,
          styleInformation: bigText,
        ),
        iOS: const DarwinNotificationDetails(presentSound: true),
      ),
      payload: jsonEncode(m.data),
    );
  }

  // ──────────────────────────────────────────────────────────────
  // TAP HANDLERS
  // ──────────────────────────────────────────────────────────────
  void _onTap(NotificationResponse r) => _routeFromPayload(r.payload);

  Future<void> _routeFromPayload(String? payload) async {
    if (payload == null) return;
    final data = jsonDecode(payload) as Map<String, dynamic>;
    log.d('🔔 Tapped → $data');
  }

  // ──────────────────────────────────────────────────────────────
  // PERMISSIONS / TOKEN
  // ──────────────────────────────────────────────────────────────
  Future<void> getToken() async {
    const topic = 'lykluk_mobile';
    try {
      final fm = FirebaseMessaging.instance;
      if (Platform.isIOS) {
        final apns = await fm.getAPNSToken();
        LocalAppStorage.fcm = apns ?? '';
        if (apns != null) await fm.subscribeToTopic(topic);
        log.d('THIS IS APP TOKEN: $apns');
      } else {
        await fm.subscribeToTopic(topic);
        final apns = await fm.getToken();
        LocalAppStorage.fcm = apns ?? '';
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: 'FCM token fetch failed',
      );
    }
  }

  void _setupInteractMessages() async {
    final initial = await FirebaseMessaging.instance.getInitialMessage();
    if (initial != null) _routeFromPayload(jsonEncode(initial.data));

    FirebaseMessaging.onMessage.listen(messageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(
      (m) => _routeFromPayload(jsonEncode(m.data)),
    );
  }

  // ──────────────────────────────────────────────────────────────
  // OPTIONAL LOCAL-ONLY NOTIFICATION
  // ──────────────────────────────────────────────────────────────
  Future<void> createLocalNotification({
    required String title,
    required String body,
  }) async {
    if (!_initialised) await initialize();

    const channel = AndroidNotificationChannel(
      'local_notifications',
      'Local notifications',
      description: 'Channel for local notifications',
      importance: Importance.high,
    );

    final bigText = BigTextStyleInformation(
      body,
      contentTitle: '<b>$title</b>',
      htmlFormatContentTitle: true,
      summaryText: body,
    );

    await _fln.show(
      Random().nextInt(1000),
      title.toTitleCase,
      body.toCapitalized,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          importance: Importance.high,
          styleInformation: bigText,
        ),
        iOS: const DarwinNotificationDetails(
          presentSound: true,
          presentAlert: true,
          presentBadge: true,
        ),
      ),
    );
  }

  // Helpers (download logo / files) omitted for brevity – copy from your original file if still needed.
}

// ───────────────────────────────────────────────────────────────────────────
// BACKGROUND / TERMINATED ISOLATE CALLBACKS  (must stay top-level)
// ───────────────────────────────────────────────────────────────────────────

@pragma('vm:entry-point')
Future<void> notificationTapBackground(NotificationResponse r) async {
  await configureFirebaseForIsolate();
  await NotificationsController()._routeFromPayload(r.payload);
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage m) async {
  await configureFirebaseForIsolate();
  await NotificationsController().messageHandler(m);
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBg(RemoteMessage m) =>
    NotificationsController().messageHandler(m);

Future<void> configureFirebaseForIsolate() async {
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name: 'lykluk-app',
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  await AppInitializer.initialize();
  await NotificationsController().initialize();
}
