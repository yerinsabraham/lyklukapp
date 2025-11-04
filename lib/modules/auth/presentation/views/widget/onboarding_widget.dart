import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/utils/constant/image_path.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/theme/app_colors.dart';
import 'package:lykluk/utils/theme/texts.dart';

class OnboardingBase extends StatelessWidget {
  final Widget collage;
  final List<TextSpan> headlineSpans;
  final String subtitle;
  final VoidCallback onNext;
  final VoidCallback? onSkip;

  const OnboardingBase({
    super.key,
    required this.collage,
    required this.headlineSpans,
    required this.subtitle,
    required this.onNext,
    this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppColors.primaryColor),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color(AppColors.primaryColor),
          image: DecorationImage(
            image: AssetImage(ImagePath.splashBgPng),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: onSkip ?? onNext,
                  borderRadius: BorderRadius.circular(8.r),
                  child: Padding(
                    padding: EdgeInsets.only(top: 30.h, right: 8.w),
                    child: AppText(
                      text: 'Skip',
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              RichText(text: TextSpan(children: headlineSpans)),

              // HERO AREA — sized to match the mock
              SizedBox(height: 0.42.sh, child: collage),

              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: AppText(
                      text: subtitle,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 30.w),
                  InkWell(
                    onTap: onNext,
                    child: Container(
                      width: 45.w,
                      height: 45.w,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}

class HeroCollage extends StatelessWidget {
  const HeroCollage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, c) {
        final w = c.maxWidth;
        final h = c.maxHeight;

        Widget tile(
          String path, {
          required double left,
          required double top,
          required double width,
          required double angle,
        }) {
          final tileW = w * width; // width is % of content width
          final tileH = tileW * (2 / 3); // 3:2 aspect (like the mock)
          return Positioned(
            left: w * left,
            top: h * top,
            child: Transform.rotate(
              angle: angle, // in radians
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Image.asset(
                  path,
                  width: tileW,
                  height: tileH,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }

        return Stack(
          clipBehavior: Clip.none,
          children: [
            // subtle rounded rect behind (like the faint lilac plate)
            Positioned(
              left: w * 0.5,
              right: w * -0.05,
              bottom: h * 0.12,
              child: Transform.rotate(
                angle: 0.01,
                child: Container(
                  height: h * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .10),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                ),
              ),
            ),
            Positioned(
              left: w * 0.05,
              right: w * 0.5,
              bottom: h * 0.24,
              child: Transform.rotate(
                angle: -0.3,
                child: Container(
                  height: h * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .10),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                ),
              ),
            ),

            Positioned(
              left: w * 0.02,
              right: w * 0.23,
              top: h * 0.18,
              child: Transform.rotate(
                angle: -0.22,
                child: Container(
                  height: h * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .10),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                ),
              ),
            ),

            // Top-left large tile (slight CCW)
            tile(
              'assets/images/culture1.png',
              left: -0.05, // flush to content left
              top: 0.18, // sits below headline
              width: 0.90, // almost full width
              angle: -0.06, // ~ -3.4°
            ),

            // Bottom-right smaller tile (CW), overlapping
            tile(
              'assets/images/culture2.png',
              left: 0.48,
              top: 0.48,
              width: 0.62,
              angle: 0.18, // ~ 10°
            ),
          ],
        );
      },
    );
  }
}
