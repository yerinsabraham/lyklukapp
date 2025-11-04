import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/utils/theme/theme.dart';

/// Reusable section header widget with title and optional action
class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onActionTap;
  final Widget? actionWidget;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionText,
    this.onActionTap,
    this.actionWidget,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: actionText != null || actionWidget != null ? 145.w : null,
            child: Opacity(
              opacity: 0.80,
              child: AppText(
                text: title,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: const Color(AppColors.textColor3),
                fontFamily: 'Figtree',
              ),
            ),
          ),
          if (actionText != null || actionWidget != null) ...[
            const Spacer(),
            if (actionWidget != null)
              actionWidget!
            else if (actionText != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 135.w,
                    child: Opacity(
                      opacity: 0.80,
                      child: GestureDetector(
                        onTap: onActionTap,
                        child: AppText(
                          text: actionText!,
                          textAlign: TextAlign.right,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(AppColors.secondaryTextColor2),
                          fontFamily: 'Figtree',
                          height: 1.22,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    width: 18.w,
                    height: 18.h,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 12.sp,
                      color: const Color(AppColors.secondaryTextColor2),
                    ),
                  ),
                ],
              ),
          ],
        ],
      ),
    );
  }
}
