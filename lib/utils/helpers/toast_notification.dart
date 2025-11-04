import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lykluk/utils/constant/font_constant.dart';
import 'package:lykluk/utils/theme/theme.dart';

class ToastNotification {
  ToastNotification._();

  static void close() {
    BotToast.closeAllLoading();
  }

  static void showSimpleNotification({
    required String title,
    TextStyle? titleStyle,
    bool? isSuccess,
  }) {
    BotToast.showSimpleNotification(
      title: title,
      backgroundColor:
          isSuccess == true
              ? const Color(AppColors.successColor)
              : const Color(AppColors.errorColor),
      titleStyle:
          titleStyle ??
          TextStyle(
            fontSize: 13.sp,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w400,
            color: Color(AppColors.white),
          ),
      closeIcon: Icon(Icons.cancel_outlined, color: Color(AppColors.greyColor)),
    );
  }

  static void showCustomNotification({
    required String title,
    required String subtitle,
    required bool isSuccess,
    bool useSafeArea = true,
    bool enableKeyboardSafeArea = false,
    VoidCallback? onAction,
    int? duration,
  }) {
    BotToast.showCustomNotification(
      useSafeArea: useSafeArea,
      enableKeyboardSafeArea: enableKeyboardSafeArea,
      duration: Duration(seconds: duration ?? 3),
      toastBuilder: (void Function() cancelFunc) {
        return Container(
          // constraints: BoxConstraints.loose(Size.fromHeight(screenHeight * .08)),
          padding: EdgeInsets.only(
            top: 10.h,
            left: 16.w,
            right: 16.w,
            bottom: 10.h,
          ),
          margin: EdgeInsets.only(left: 16.w, right: 16.w),
          decoration: BoxDecoration(
            color:
                isSuccess
                    ? const Color(AppColors.successColor)
                    : const Color(AppColors.errorColor),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 200.w),
                      child: AppText(
                        text: title,
                        maxLines: 3,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                        color: const Color(AppColors.white),
                        fontFamily: FontConstant.bricolage,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 1.sw - 10.w),
                      child: AppText(
                        text: subtitle,
                        maxLines: 3,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.clip,
                        color: const Color(AppColors.white),
                        fontFamily: FontConstant.bricolage,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (onAction != null) {
                    onAction();
                  } else {
                    cancelFunc();
                  }
                },
                child: SvgPicture.asset(
                  isSuccess
                      ? 'assets/svgs/successToastIcon.svg'
                      : 'assets/svgs/errorToastIcon.svg',
                  height: 20.sp,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void showFeedbackNotification(
    BuildContext context, {
    required String title,
    bool useSafeArea = true,
    bool enableKeyboardSafeArea = false,
    VoidCallback? onAction,
    int? duration,
  }) {
    BotToast.showCustomNotification(
      useSafeArea: useSafeArea,
      enableKeyboardSafeArea: enableKeyboardSafeArea,
      duration: Duration(seconds: duration ?? 10),
      toastBuilder: (void Function() cancelFunc) {
        return Container(
          // constraints: BoxConstraints.loose(Size.fromHeight(screenHeight * .08)),
          padding: EdgeInsets.only(
            top: 10.h,
            left: 20.w,
            right: 20.w,
            bottom: 10.h,
          ),
          margin: EdgeInsets.only(left: 24.w, right: 24.w),
          decoration: BoxDecoration(
            color: const Color(0xFF282828),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 1.sw - 30.w),
                      child: AppText(
                        text: title,
                        maxLines: 3,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.clip,
                        color: const Color(AppColors.white),
                        fontFamily: FontConstant.bricolage,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (onAction != null) {
                    onAction();
                  } else {
                    cancelFunc();
                  }
                },
                child: SvgPicture.asset(
                  'assets/svgs/thumbs.svg',
                  height: 24.sp,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static alertError(String message, {bool isSuccess = false}) {
    showCustomNotification(
      title: 'Error',
      subtitle: message,
      isSuccess: isSuccess,
    );
  }

  static alertSuccess(String message, {bool isSuccess = true}) {
    showCustomNotification(
      title: 'Success',
      subtitle: message,
      isSuccess: isSuccess,
    );
  }
}
