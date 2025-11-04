import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/providers/auth_status_provider.dart';
import 'package:lykluk/utils/constant/font_constant.dart';
import 'package:lykluk/utils/constant/image_path.dart';
import 'package:lykluk/utils/router/app_router.dart';
import 'package:lykluk/utils/storage/local_storage.dart';
import 'package:lykluk/utils/theme/app_colors.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      final isLoggedIn = ref.read(authStateProvider);
      if (isLoggedIn) {
        AppRouter.router.goNamed(Routes.navBarRoute);
      } else if (HiveStorage.isOnboarded) {
        AppRouter.router.goNamed(Routes.navBarRoute);
      } else {
        AppRouter.router.goNamed(Routes.onboardingRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: 1.sh,
        width: 1.sw,
        decoration: BoxDecoration(
          color: Color(AppColors.primaryColor),
          image: DecorationImage(
            image: AssetImage(ImagePath.splashBgPng),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(ImagePath.lightLogo),
              AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText(
                    'YKLUK',
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      fontFamily: FontConstant.bricolage,
                    ),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
