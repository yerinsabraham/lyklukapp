import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

import 'loading_with_text.dart';

class AppErrorWidget<T> extends StatelessWidget {
  final VoidCallback? onRetry;
  final String errorText;
  final EdgeInsets padding;
  final Widget? refreshingWidget;
  final AsyncValue<T> asyncValue;
  final Color? textColor;
  final String? errorButtonTitle;
  const AppErrorWidget({
    super.key,
    required this.errorText,
    this.onRetry,
    this.padding = EdgeInsets.zero,
    this.refreshingWidget,
    required this.asyncValue,
    this.textColor,
    this.errorButtonTitle,
  });

  @override
  Widget build(BuildContext context) {
    if (asyncValue.isRefreshing || asyncValue.isLoading) {
      return refreshingWidget ?? const LoadingWithText(text: 'Refreshing...');
    }
    return Padding(
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 300.w),
              child: Text(
                errorText,
                textAlign: TextAlign.center,
                style: context.body16Light.copyWith(color: textColor),
              ),
            ),
          ),
          SizedBox(height: 20.w),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: context.colorScheme.primary,
            ),
            onPressed: onRetry,
            child: Text(
             errorButtonTitle?? 'Retry',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.colorScheme.surface,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ErrorRefreshWidget extends StatelessWidget {
  final VoidCallback? onRetry;
  final String errorText;
  final Color? errorTextColor;
  final EdgeInsets padding;
  final Widget? refreshingWidget;
  final bool isRefreshing;
  const ErrorRefreshWidget({
    super.key,
    required this.errorText,
    this.onRetry,
    this.padding = EdgeInsets.zero,
    this.refreshingWidget,
    this.isRefreshing = false,
    this.errorTextColor,
  });

  @override
  Widget build(BuildContext context) {
    if (isRefreshing) {
      return refreshingWidget ?? const LoadingWithText(text: 'Refreshing...');
    }
    return Padding(
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 300.w),
              child: Text(
                errorText,
                textAlign: TextAlign.center,
                style: TextStyle(color: errorTextColor),
              ),
            ),
          ),
          SizedBox(height: 20.w),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: context.colorScheme.primary,
            ),
            onPressed: onRetry,
            child: Text(
              'Retry',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }
}
