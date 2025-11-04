import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

class TabContainer extends StatelessWidget {
  final bool selected;
  final String value;
  final Color? inActiveColor;
  final Color? color;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final double? textSize;
  const TabContainer({
    super.key,
    this.selected = false,
    required this.value,
    this.inActiveColor,
    this.onTap,
    this.padding,
    this.textSize,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: 85.w,
        // height: 30.h,
        constraints: BoxConstraints(minWidth: 36.w),
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        margin: EdgeInsets.only(right: 10.w),
        decoration: BoxDecoration(
          color:
              selected
                  ?  context.colorScheme.primaryFixedDim
                  : inActiveColor ??
                      context.colorScheme.onTertiaryFixed.withValues(alpha: .2),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Text(
            value,
            style: context.body14.copyWith(
              fontSize: textSize,
              color:
                  selected
                      ? context.colorScheme.surface
                      : context.colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
