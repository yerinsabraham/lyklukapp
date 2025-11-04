import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/services/lifecycle_observer.dart';
import 'package:lykluk/core/services/logger_service.dart';
import 'package:lykluk/initializer.dart';
import 'package:lykluk/utils/router/app_router.dart';
import 'package:lykluk/utils/storage/local_storage.dart';
import 'package:lykluk/utils/theme/app_theme.dart';

class Lykluk extends ConsumerStatefulWidget {
  const Lykluk({super.key});

  @override
  ConsumerState<Lykluk> createState() => _LyklukState();
}

class _LyklukState extends ConsumerState<Lykluk> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    if (LocalAppStorage.fcm == '') {
      notificationController.requestPermission();
    }
    FirebaseRemoteConfig.instance.onConfigUpdated.listen((event) async {
      await FirebaseRemoteConfig.instance.activate();
      setState(() {}); // Rebuild the UI when config is updated
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.paused:
        log.d("App moved to background");
        break;
      case AppLifecycleState.inactive:
        log.d("App is inactive");
        break;
      case AppLifecycleState.detached:
        log.d("App is being terminated");
        break;
      case AppLifecycleState.hidden:
        log.d("App is hidden");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(appLifecycleObserverProvider);
    // final themeMode = ref.watch(themeNotifierProvider);
    // final themeMode = ref.watch(themeNotifierProvider);
    // final isDark = themeMode == ThemeMode.dark;
    // final appExt = Theme.of(context).extension<AppExtension>()!;

    /// listen to the device orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, // Portrait mode only
      DeviceOrientation.portraitDown,
    ]);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (_, child) {
        final botToastBuilder = BotToastInit();

        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: MaterialApp.router(
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
            title: 'Lykluk',
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            // themeMode: themeMode,
            themeMode: ThemeMode.light,
            builder: (context, child) {
              child = botToastBuilder(context, child);
              return MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(textScaler: const TextScaler.linear(1.0)),
                child: child,
              );
            },
          ),
        );
      },
      child: const SizedBox(),
    );
  }
}
