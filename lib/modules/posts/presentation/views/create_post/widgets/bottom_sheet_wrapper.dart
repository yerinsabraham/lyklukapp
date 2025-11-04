import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/utils/theme/theme.dart';

class BottomSheetWrapper extends StatelessWidget {
  final String? title;
  final Widget child;
  final bool hasDrag;

  const BottomSheetWrapper({super.key, this.title, required this.child, this.hasDrag = true});

  bool get hasTitle => title != null && title!.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        color: const Color(AppColors.buttonColor),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasDrag) Center(child: Container(
            margin: EdgeInsets.symmetric(vertical: 10.h),
            height: 8.h,
            width: 100.w,
            decoration: BoxDecoration(
              color: cs.onSecondary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),),
          if (hasTitle) ...[

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Center(
                child: AppText(
                  text: title!,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(AppColors.black),
                ),
              ),
            ),
            8.verticalSpace,
          ],
          Flexible(fit: FlexFit.loose, child: child),
        ],
      ),
    );
  }
}
