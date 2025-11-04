import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/modules/auth/presentation/views/widget/onboarding_widget.dart';
import 'package:lykluk/utils/router/app_router.dart';
import 'package:lykluk/utils/theme/app_colors.dart';
import 'package:lykluk/utils/theme/texts.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingBase(
      collage: const HeroCollage(),
      headlineSpans: [
        AppTextHelpers.textSpan(
          'Your ',
          color: Colors.white,
          fontSize: 44.sp,
          fontWeight: FontWeight.w700,
        ),
        AppTextHelpers.textSpan(
          'Culture',
          color: Color(AppColors.cultureColor),
          fontSize: 44.sp,
          fontWeight: FontWeight.w700,
        ),
        AppTextHelpers.textSpan(
          ',\nYour Stage.',
          color: Colors.white,
          fontSize: 44.sp,
          fontWeight: FontWeight.w700,
        ),
      ],
      subtitle:
          'Dive into a vibrant community where we bring cultural stories to life. '
          'See what’s trending, or show off your unique heritage.',
      onNext: () => AppRouter.router.pushNamed(Routes.chooseInterestRoute),
      onSkip: () => AppRouter.router.pushNamed(Routes.chooseInterestRoute),
    );
  }
}
