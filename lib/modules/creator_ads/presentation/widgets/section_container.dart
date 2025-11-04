import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/theme/app_colors.dart';

/// Reusable section container widget for studio sections
class SectionContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double? height;

  const SectionContainer({
    super.key,
    required this.child,
    this.padding,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: const Color(AppColors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: child,
    );
  }
}
