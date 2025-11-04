import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/services/services.dart';

final appLifecycleObserverProvider = Provider((ref) {
  return LifecycleObserver(ref);
});

class LifecycleObserver with WidgetsBindingObserver {
  final Ref ref;
  const LifecycleObserver(this.ref);
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        // ✅ Refresh all messages when the app is reopened
        log.d("App moved to foreground");
        // final isAuthenticated = ref.watch(authStatusProvider) == AuthStatus.authenticated;
        // if (isAuthenticated) {
        //   log.d("App $isAuthenticated");
        // }
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
}
