import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/core/shared/widgets/loading_widget.dart';

class CustomButton extends StatelessWidget {
  final String? buttonText;
  final VoidCallback onTap;
  final Color? color;
  final Color? disableColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final bool isLoading;
  final bool isDisable;
  final FontWeight? weight;
  final Widget? child;
  final double? evelation;
  final double? textSize;
  final double? radius;
  final Widget? icon;
  final Color? indicatorColor;

  final Color? borderColor;
  final FocusNode? focusNode;
  final bool showGradient;
  const CustomButton({
    this.disableColor,
    this.buttonText,
    required this.onTap,
    super.key,
    this.indicatorColor,
    this.color,
    this.textColor,
    this.width,
    this.height,
    this.isLoading = false,
    this.isDisable = false,
    this.evelation,
    this.weight = FontWeight.w600,
    this.textSize,
    this.radius,
    this.borderColor,
    this.focusNode,
    this.showGradient = false,
    this.child,
    this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisable || isLoading ? null : onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 60.h,
        decoration: BoxDecoration(
          color:
              isDisable
                  ? disableColor ??
                      context.colorScheme.onSecondary.withValues(alpha: 0.3)
                  : color ?? context.colorScheme.primary,
          borderRadius: BorderRadius.circular(radius ?? 8.r),
          border: Border.all(color: borderColor ?? Colors.transparent),
          gradient:
              showGradient
                  ? LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      context.colorScheme.secondary,
                      context.colorScheme.primary,
                    ],
                  )
                  : null,
        ),
        child: Visibility(
          visible: !isLoading,
          replacement: SizedBox(
            height: 30.h,
            width: 30.w,
            child:  Center(child: LoadingWidget(color: indicatorColor ?? Colors.white)),
          ),
          child:
              child ??
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null)
                    Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: icon!,
                    ),
                  Center(
                    child: Text(
                      buttonText ?? '',
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodySmall!.copyWith(
                        fontSize: textSize ?? 16.sp,
                        fontWeight: weight,
                        color:
                            isDisable
                                ? Colors.white
                                : textColor ?? context.colorScheme.surface,
                      ),
                    ),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final String? buttonText;
  final VoidCallback onTap;
  final Color? color;
  final Color? disableColor;
  final Color? textDisableColor;
  final Color? indicatorColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final bool isLoading;
  final bool isDisable;
  final FontWeight? weight;
  final Widget? child;
  final double? evelation;
  final double? textSize;
  final double? radius;
  final Widget? icon;
  final double? iconPadding;

  final Color? borderColor;
  final FocusNode? focusNode;
  final bool showGradient;
  const CustomElevatedButton({
    this.indicatorColor,
    this.disableColor,
    this.textDisableColor,
    this.buttonText,
    required this.onTap,
    super.key,
    this.color,
    this.textColor,
    this.width,
    this.height,
    this.isLoading = false,
    this.isDisable = false,
    this.evelation,
    this.weight = FontWeight.w500,
    this.textSize,
    this.radius,
    this.borderColor,
    this.focusNode,
    this.showGradient = false,
    this.child,
    this.icon,
    this.iconPadding,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isDisable || isLoading ? null : onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isDisable
                ? disableColor ??
                    context.colorScheme.onSecondary.withValues(alpha: 0.3)
                : color ?? context.colorScheme.primary,
        elevation: evelation ?? 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 8.r),
          side: BorderSide(color: borderColor ?? Colors.transparent),
        ),
        fixedSize: Size(width ?? double.infinity, height ?? 56.h),
        // maximumSize: Size.fromHeight(height ?? 56.h).copyWith(width: width ?? double.infinity),
      ),
      child: Visibility(
        visible: !isLoading,
        replacement: SizedBox(
          height: 30.h,
          width: 30.w,
          child:  Center(
            child: CircularProgressIndicator(color:  indicatorColor?? Colors.grey),
          ),
        ),
        child:
            child ??
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null)
                  Padding(
                    padding: EdgeInsets.only(right: iconPadding ?? 10.w),
                    child: icon!,
                  ),
                Center(
                  child: Text(
                    buttonText ?? '',
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodySmall!.copyWith(
                      fontSize: textSize ?? 16.sp,
                      fontWeight: weight,
                      color:
                          isDisable
                              ? textDisableColor ?? Colors.white
                              : textColor ?? context.colorScheme.surface,
                    ),
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
