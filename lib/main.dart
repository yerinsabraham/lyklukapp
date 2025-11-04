import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/di/injection.dart';
import 'package:lykluk/firebase_options.dart';
import 'package:lykluk/lykluk.dart';

import 'core/services/push_notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'lykluk-app',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupDependencies();
  await configureFirebase();

  // // Initialize the app (this will handle Firebase + Crashlytics + Hive)
  // await AppInitializer.initialize();

  // // Configure Firebase for background isolates (for notifications)
  // await configureFirebaseForIsolate();

  runApp(
    ProviderScope(
   
      child: Lykluk(),
     
    ),
  );
}
