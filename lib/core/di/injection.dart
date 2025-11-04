import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lykluk/core/services/crashlytics_service.dart';
import 'package:lykluk/core/services/remote_config_service.dart';
import 'package:lykluk/modules/ecommerce/data/ecommerce_services/product_image_uploader.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:path_provider/path_provider.dart';

import '../services/app_analytics.dart';
import '../services/push_notification_service.dart';
import '../services/utils_services.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  //register database
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.openBox<dynamic>('app_hive');
  await Hive.openBox<dynamic>('app_stable_hive');

  // Firebase Analytics
  getIt.registerLazySingleton<AnalyticsService>(() => AnalyticsService());

  // Local Notifications
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  getIt.registerSingleton<PushNotificationsService>(
    PushNotificationsService(
      firebaseMessaging: FirebaseMessaging.instance,
      flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
    ),
  );

  // utils services
  final deviceInfo = DeviceInfoPlugin();
  final packageInfo = await PackageInfo.fromPlatform();
  getIt.registerLazySingleton<UtilsServices>(
    () => UtilsServices(deviceInfoPlugin: deviceInfo, packageInfo: packageInfo),
  );

  getIt.registerLazySingleton<CrashlyticsService>(
    () => CrashlyticsService(FirebaseCrashlytics.instance),
  );

  getIt.registerLazySingleton<RemoteConfigService>(
    () => RemoteConfigService(config: FirebaseRemoteConfig.instance),
  );
  getIt.registerLazySingleton<ProductImageUploadService>(()=> ProductImageUploadService()..init());
}
