// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';
import 'dart:math' show Random;


import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:lykluk/core/services/services.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:path_provider/path_provider.dart';

import '../di/injection.dart';


final notificationServiceProvider =
    Provider((ref) => getIt<PushNotificationsService>());

class PushNotificationsService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  FirebaseMessaging firebaseMessaging;
  late NotificationSettings settings;

  PushNotificationsService({
    required this.flutterLocalNotificationsPlugin,
    required this.firebaseMessaging,
  }) {
    initialize();
  }

  Future<void> initialize() async {
    await requestPermission();
    await getToken();
    setupInteractMessage();
  }

  Future<void> messageHandler(RemoteMessage message) async {
    try {
      // // log.d(message.notification?.toMap());
      await setupNotificationPlugin(message);
      // // log.d(message.notification?.toMap());
      final remote = message.notification?.toMap();
      final remoteNotification = PushNotification.fromMap(remote ?? {});
      final dataBodyMap = message.data;
      final push = PushNotification.fromMap(dataBodyMap);
      log.d(push.toMap());
      log.d(remote);

      final notificationTitle = remoteNotification.title;
      final notificationBody = remoteNotification.body;

      StyleInformation notificationStyle = BigTextStyleInformation(
        notificationBody,
        contentTitle: '<b>${(notificationTitle)}</b>',
        htmlFormatContentTitle: true,
        summaryText: notificationBody,
        htmlFormatSummaryText: false,
      );
      if (Platform.isIOS) return;
      await showNotification(
        style: notificationStyle,
        id: int.parse(push.id),
        title: push.title.capitalize,
        body: push.body.capitalize,
      );
    } on Exception catch (e, s) {
      log.e(e, stackTrace: s);
    }
  }

  Future<void> showNotification({
    required StyleInformation style,
    required int id,
    required String title,
    required String body,
    AndroidNotificationChannel? inputchannel,
    String? payload,
  }) async {
    AndroidNotificationChannel channel = inputchannel ??
        const AndroidNotificationChannel(
          'high_importance_channel', // id
          'High Importance Notifications', // title
          description:
              'This channel is used for important notifications.', // description
          importance: Importance.high,
        );
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          importance: Importance.high,
          priority: Priority.high,
          styleInformation: style,
          icon: '@mipmap/ic_launcher',
          // icon: '',
        ),
        iOS: const DarwinNotificationDetails(
          presentSound: true,
          sound: 'default',
        ),
      ),
      payload: payload,
     
    );
  }

  Future<void> showCallNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'incoming_calls',
          'Incoming Calls',
          channelDescription: 'Notifications for incoming voice/video calls',
          icon: '@mipmap/ic_launcher',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
          actions: [
            AndroidNotificationAction(
              'accept_call',
              'Accept',
            ),
            AndroidNotificationAction(
              'reject_call',
              'Reject',
            ),
          ],
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          sound: 'default',
          categoryIdentifier: 'incoming_call',
        ),
      ),
    );

    // Register iOS notification actions
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      await _configureIOSNotificationActions();
    }
  }

  Future<void> _configureIOSNotificationActions() async {
    DarwinNotificationCategory callCategory = DarwinNotificationCategory(
      'incoming_call',
      actions: [
        DarwinNotificationAction.plain(
          'accept_call',
          'Accept',
          options: {
            DarwinNotificationActionOption.foreground,
          },
        ),
        DarwinNotificationAction.plain(
          'reject_call',
          'reject_call',
          options: {
            DarwinNotificationActionOption.destructive,
            DarwinNotificationActionOption.foreground,
          },
        ),
      ],
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.initialize(
          DarwinInitializationSettings(
              requestAlertPermission: true,
              requestBadgePermission: true,
              requestSoundPermission: true,
              notificationCategories: [callCategory]),
        );

    // ?.setNotificationCategories([callCategory]);
  }

  Future<void> requestPermission() async {
    log.d('request permission');
    settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  Future<String?> getToken() async {
    try {
      final token = await firebaseMessaging.getToken();
      log.d("Token value: $token");
      if (token == null) {
        log.e('Unable to get token');
        return null;
      }
      return token;
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: 'Unable to get token',
      );
      return null;
    }
  }

  Stream<String> onTokenRefresh() {
    return firebaseMessaging.onTokenRefresh;
  }

  Future<void> setupNotificationPlugin(RemoteMessage message) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings(
      notificationCategories: [
        DarwinNotificationCategory(
          'demoCategory',
          actions: <DarwinNotificationAction>[
            DarwinNotificationAction.plain(
              'id_2',
              'Action 2',
              options: <DarwinNotificationActionOption>{
                DarwinNotificationActionOption.foreground,
              },
            ),
          ],
          options: <DarwinNotificationCategoryOption>{
            DarwinNotificationCategoryOption.allowAnnouncement,
            DarwinNotificationCategoryOption.allowInCarPlay,
          },
        ),
      ],
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: darwinInitializationSettings,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        // messageHandler(details as RemoteMessage);
        log.d(details.toString());
        handleMessage(message);
      },
      onDidReceiveBackgroundNotificationResponse: background,
    );
  }

  Future<void> setupInteractMessage() async {
    log.d('setupInteractMessage');
    RemoteMessage? initialMessage = await firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(event);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      messageHandler(event);
    });
  }

  /// handle notification tap
  Future<void> handleMessage(RemoteMessage message) async {
    log.d('handle press notification');
    try {
      // final context = providerContainer.read(routerProvider).currentState?.context;
      // final context = AppRouter.parentNavigatorKey.currentState?.context;
      log.d(message.data);
      // final dataBodyMap = message.data;
      // final push = PushNotification.fromMap(dataBodyMap);
      // if (push.jsonAlert != null) {
      //   // final alert = AlertModel.fromJson(push.jsonAlert!);
      //   // alert.gotoPage(context);
      // }
    } catch (e, s) {
      LoggerService.logError(
          error: e, stackTrace: s, reason: 'Unable to route notification');
    }
  }

  Future<String> downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  /// get file logo from assets
  Future<String> getLogoPath() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/xpressuser';
    final ByteData data = await rootBundle.load('assets/logo/logo.png');
    final List<int> bytes = data.buffer.asUint8List();
    final File file = File(filePath);
    await file.writeAsBytes(bytes);
    return filePath;
  }
}

@pragma('vm:entry-point')
void background(NotificationResponse res) {
  configureFirebase();
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final service = getIt<PushNotificationsService>();
  await service.messageHandler(message);
  service.handleMessage(message);
}

Future<void> configureFirebase() async {
  // final NotificationsController notificationController =
  //     NotificationsController();
  // await notificationController.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

///////////////////  -- PushNotification  model--  //////
class PushNotification extends Equatable {
  final String id;
  final String title;
  final String body;
  final Map<String, dynamic>? jsonAlert;

  const PushNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.jsonAlert,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        body,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
      'jsonAlert': jsonAlert,
    };
  }

  factory PushNotification.fromMap(Map<String, dynamic> map) {
    return PushNotification(
      id: map['id'] ?? (Random().nextInt(100000) * 1000).toString(),
      title: map['title'] ?? "New notification",
      body: map['body'] ?? "Check Chattabox for update",
      jsonAlert: map['jsonAlert'] != null
          ? Map<String, dynamic>.from(jsonDecode(map['jsonAlert']) as Map)
          : null,
    );
  }
}
