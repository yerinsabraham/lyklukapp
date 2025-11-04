import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/domain/notification_constants.dart';
import 'package:lykluk/utils/constant/font_constant.dart';
import 'package:lykluk/utils/theme/theme.dart';

/// Reusable notification filter chip widget
/// Used for displaying filter options like 'All', 'Requests', 'Comments', etc.
class NotificationFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final double? width;

  const NotificationFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: NotificationConstants.filterButtonHeight.h,
        padding: EdgeInsets.all(5.w),
        decoration: ShapeDecoration(
          color:
              isSelected
                  ? const Color(NotificationConstants.activeFilterColor)
                  : const Color(NotificationConstants.inactiveFilterColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              NotificationConstants.filterButtonBorderRadius,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppText(
              text: label,
              color:
                  isSelected
                      ? const Color(AppColors.white)
                      : const Color(NotificationConstants.primaryTextColor),
              fontSize: NotificationConstants.filterFontSize.sp,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
              fontFamily: FontConstant.bricolage,
            ),
          ],
        ),
      ),
    );
  }
}


