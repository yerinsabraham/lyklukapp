import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/utils/constant/font_constant.dart';
import 'package:lykluk/utils/theme/app_colors.dart';
import 'package:lykluk/utils/theme/app_theme.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;
  final String? fontFamily;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextStyle? style;
  const AppText({
    super.key,
    required this.text,
    this.color,
    this.height,
    this.fontSize,
    this.fontWeight,
    this.decoration,
    this.fontFamily,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines,
      overflow: overflow,
      style:
          style ??
          TextStyle(
            height: height,
            fontSize: fontSize ?? 14.sp,
            color: color ?? const Color(AppColors.black),
            fontWeight: fontWeight ?? FontWeight.normal,
            decoration: decoration ?? TextDecoration.none,
            fontFamily: fontFamily ?? FontConstant.bricolage,
          ),
    );
  }
}

class AppTextWithIcon extends StatelessWidget {
  final String label;

  final Widget icon;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;
  final String? fontFamily;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  const AppTextWithIcon({
    super.key,
    required this.label,
    required this.icon,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.decoration,
    this.fontFamily,
    this.textAlign,
    this.overflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    final appExt = Theme.of(context).extension<AppExtension>()!;
    return Row(
      children: [
        icon,
        SizedBox(width: 5.w),
        AppText(
          text: label,
          fontSize: 14.sp,
          color: color ?? appExt.textColor,
          fontWeight: fontWeight,
          decoration: decoration,
          fontFamily: fontFamily,
          textAlign: textAlign,
          overflow: overflow,
          maxLines: maxLines,
        ),
      ],
    );
  }
}

class AppTextHelpers {
  AppTextHelpers._();

  static TextSpan textSpan(
    String text, {
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    TextDecoration? decoration,
    String? fontFamily,
    List<InlineSpan>? children,
    Function()? onTap,
  }) {
    return TextSpan(
      text: text,
      children: children,
      recognizer: TapGestureRecognizer()..onTap = onTap,
      style: TextStyle(
        color: color ?? const Color(AppColors.black),
        fontSize: fontSize ?? 14.sp,
        fontWeight: fontWeight ?? FontWeight.normal,
        decoration: decoration ?? TextDecoration.none,
        fontFamily: fontFamily ?? FontConstant.bricolage,
      ),
    );
  }
}
