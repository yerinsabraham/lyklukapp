import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/core/shared/widgets/loading_widget.dart';

import 'theme.dart';

class AppButton extends StatelessWidget {
  final Widget widget;
  final Function()? onPressed;
  final Color? backgroundColor;
  final Size? minimumSize;
  final bool isLoading;
  final bool isDisabled;
  final BorderSide? borderSide;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final OutlinedBorder? shape;
  final Color? indicatorColor;
  final Color? disabledColor;

  const AppButton({
    super.key,
    required this.widget,
    required this.onPressed,
    this.backgroundColor,
    this.minimumSize,
    this.isLoading = false,
    this.isDisabled = false,
    this.borderSide,
    this.borderRadius,
    this.padding,
    this.shape,
    this.indicatorColor,
    this.disabledColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool buttonDisabled = isLoading || isDisabled;
    return isLoading
        ? TextButton(
          style: TextButton.styleFrom(
            backgroundColor:
                buttonDisabled
                    ? (disabledColor ?? const Color(AppColors.lightGreyColor))
                    : (backgroundColor ?? const Color(AppColors.primaryColor)),
            minimumSize: minimumSize ?? Size(1.sw, 40.h),
            shape: RoundedRectangleBorder(
              side: borderSide ?? BorderSide.none,
              borderRadius: borderRadius ?? BorderRadius.circular(100.r),
            ),
            padding: padding,
          ),
          onPressed: buttonDisabled ? null : onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget,
              SizedBox(width: 10.w),
              LoadingWidget(
                color: indicatorColor ?? const Color(AppColors.white),
              ),
            ],
          ),
        )
        : TextButton(
          style: TextButton.styleFrom(
            disabledBackgroundColor:
                buttonDisabled
                    ? (disabledColor ?? const Color(AppColors.lightGreyColor))
                    : (backgroundColor ?? const Color(AppColors.primaryColor)),
            backgroundColor:
                backgroundColor ?? const Color(AppColors.primaryColor),
            minimumSize: minimumSize ?? Size(1.sw, 50.h),
            shape: RoundedRectangleBorder(
              side: borderSide ?? BorderSide.none,
              borderRadius: borderRadius ?? BorderRadius.circular(100.r),
            ),
            padding: padding,
          ),
          onPressed: isDisabled ? null : onPressed,
          child: widget,
        );
  }

  static Widget button({
    required Widget widget,
    required Function()? onPressed,
    Color? backgroundColor,
    Size? minimumSize,
    bool isLoading = false,
    bool isDisabled = false,
    BorderSide? borderSide,
    BorderRadiusGeometry? borderRadius,
    EdgeInsetsGeometry? padding,
    OutlinedBorder? shape,
    Color? indicatorColor,
    Color? disabledColor,
  }) {
    // backgroundColor: backgroundColor ?? const Color(AppColors.primaryColor),
    final bool buttonDisabled = isLoading || isDisabled;
    return isLoading
        ? TextButton(
          style: TextButton.styleFrom(
            backgroundColor:
                buttonDisabled
                    ? (disabledColor ?? const Color(AppColors.lightGreyColor))
                    : (backgroundColor ?? const Color(AppColors.primaryColor)),
            minimumSize: minimumSize ?? Size(1.sw, 40.h),
            shape: RoundedRectangleBorder(
              side: borderSide ?? BorderSide.none,
              borderRadius: borderRadius ?? BorderRadius.circular(100.r),
            ),
            padding: padding,
          ),
          onPressed: buttonDisabled ? null : onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget,
              SizedBox(width: 10.w),
              LoadingWidget(
                color: indicatorColor ?? const Color(AppColors.white),
              ),
            ],
          ),
        )
        : TextButton(
          style: TextButton.styleFrom(
            disabledBackgroundColor:
                buttonDisabled
                    ? (disabledColor ?? const Color(AppColors.lightGreyColor))
                    : (backgroundColor ?? const Color(AppColors.primaryColor)),
            backgroundColor:
                backgroundColor ?? const Color(AppColors.primaryColor),
            minimumSize: minimumSize ?? Size(1.sw, 50.h),
            shape: RoundedRectangleBorder(
              side: borderSide ?? BorderSide.none,
              borderRadius: borderRadius ?? BorderRadius.circular(100.r),
            ),
            padding: padding,
          ),
          onPressed: isDisabled ? null : onPressed,
          child: widget,
        );
  }
}
