import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/services/logger_service.dart';
import 'package:lykluk/modules/auth/presentation/views/components/interest_page.dart';
import 'package:lykluk/modules/auth/presentation/views/splash.dart';
import 'package:lykluk/utils/storage/local_storage.dart';

class AuthWrapper extends StatefulHookConsumerWidget {
  const AuthWrapper({super.key});

  @override
  ConsumerState<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends ConsumerState<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    final isLogin = HiveStorage.isLoggedIn;
    log.d('isUser Logged In? $isLogin');
    if (isLogin) {
      return const SplashScreen();
    } else {
      return ChooseInterestScreen();
    }
  }
}
