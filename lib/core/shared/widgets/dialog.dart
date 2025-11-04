import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lykluk/utils/constant/font_constant.dart';
import 'package:lykluk/utils/theme/theme.dart';

enum DialogType { challengeType, chatType }

class DialogueWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? thirdLine;
  final String message;
  final String buttonTextOne;
  final String buttonTextTwo;
  final Color color;
  final String? imageUrl;
  final String? assetImagepath;
  final VoidCallback? onAction;
  final VoidCallback? onCancel;
  final DialogType type;
  final bool loading;

  const DialogueWidget({
    required this.title,
    required this.subtitle,
    required this.thirdLine,
    required this.message,
    required this.buttonTextOne,
    required this.buttonTextTwo,
    required this.color,
    this.loading = false,
    this.imageUrl,
    this.onAction,
    this.onCancel,
    this.assetImagepath,
    this.type = DialogType.chatType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(AppColors.white),
      surfaceTintColor: const Color(AppColors.white),
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      content: Visibility(
        visible: !loading,
        replacement: const Center(
          child: RepaintBoundary(child: CircularProgressIndicator()),
        ),
        child: Container(
          //  height: 1.sh * .6,
          // padding: EdgeInsets.all(10.r),
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.width * .7,
            // maxHeight: MediaQuery.of(context).size.width * .9,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(AppColors.white),
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20.h),
              imageUrl != null
                  ? Center(
                    child: CircleAvatar(
                      radius: 32.r,
                      backgroundImage: NetworkImage(imageUrl!),
                    ),
                  )
                  : Center(
                    child: ClipOval(
                      child: SizedBox(
                        height: 32.h,
                        width: 32.w,
                        child: SvgPicture.asset(
                          assetImagepath ?? 'assets/svg/users.svg',
                          colorFilter: const ColorFilter.mode(
                            Colors.grey,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      text: title,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: FontConstant.bricolage,
                    ),
                    AppText(
                      text: subtitle,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.center,
                      color: const Color(AppColors.primaryColor),
                      fontFamily: FontConstant.bricolage,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 234.w),
                  child: AppText(
                    text: message,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'BricolageGrotesque',
                    color: const Color(AppColors.black),
                    fontSize: 12.sp,
                  ),
                ),
              ),
              thirdLine != 'nill'
                  ? SizedBox(height: 16.h)
                  : const SizedBox(height: 0),
              thirdLine == 'nill'
                  ? const SizedBox.shrink()
                  : AppText(
                    text: thirdLine!,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'BricolageGrotesque',
                  ),
              // const Spacer(),
              SizedBox(height: 20.h),
              Visibility(
                visible: type == DialogType.chatType,
                replacement: MediaQuery.removePadding(
                  context: context,
                  removeLeft: true,
                  removeRight: true,
                  child: MaterialButton(
                    minWidth: double.infinity,
                    elevation: 0,
                    color: const Color(0xFFDC0D2A),
                    height: 42.h,
                    onPressed: () {
                      onAction?.call();
                    },
                    child: AppText(
                      text: buttonTextOne,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'BricolageGrotesque',
                    ),
                  ),
                ),
                child: AppButton(
                  onPressed: () {
                    onAction?.call();
                  },
                  minimumSize: Size(
                    MediaQuery.of(context).size.width * 0.65,
                    50,
                  ),
                  backgroundColor: const Color(0xFFDC0D2A),
                  widget: AppText(
                    text: buttonTextOne,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'BricolageGrotesque',
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Visibility(
                visible: type == DialogType.chatType,
                replacement: MediaQuery.removePadding(
                  context: context,
                  removeLeft: true,
                  removeRight: true,
                  child: TextButton(
                    onPressed: onCancel,
                    child: AppText(
                      text: buttonTextTwo,
                      color: const Color(AppColors.black),
                      fontWeight: FontWeight.w700,
                      fontFamily: 'BricolageGrotesque',
                    ),
                  ),
                ),
                child: AppButton(
                  onPressed: () {
                    onCancel?.call();
                  },
                  backgroundColor: Colors.white,
                  minimumSize: Size(
                    MediaQuery.of(context).size.width * 0.65,
                    50,
                  ),
                  borderSide: BorderSide(color: color, width: 1.w),
                  widget: AppText(
                    text: buttonTextTwo,
                    color: color,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'BricolageGrotesque',
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
