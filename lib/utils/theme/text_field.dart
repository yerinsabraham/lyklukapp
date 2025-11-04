import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/utils/constant/font_constant.dart';
import 'package:lykluk/utils/theme/app_colors.dart';

class AppTextInput {
  static Widget input({
    double? height,
    TextStyle? style,
    TextEditingController? controller,
    Function(String val)? onChanged,
    String? labelText,
    bool? readOnly,
    String? hintText,
    String? initialValue,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    AutovalidateMode? autovalidateMode,
    String? fontFamily,
    bool? autofocus,
    bool? autocorrect,
    bool? obscureText,
    bool? enabled,
    int? minLines,
    int? maxLines,
    Widget? prefix,
    Widget? surfix,
    Widget? prefixIcon,
    Widget? surfixIcon,
    Color? fillColor,
    Color? borderColor,
    Color? activeBorderColor,
    int? maxLength,
    double? borderRadius,
    FocusNode? focusNode,
    List<TextInputFormatter>? inputFormatters,
    VoidCallback? onTap,
    String? Function(String?)? validator,
    TextAlign? textAlign,
    double? fontSize,
    EdgeInsetsGeometry? contentPadding,
    Color? hintColor,
    TextCapitalization? textCapitalization,
    bool? hideCounter,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: Text(
              labelText,
              style: TextStyle(
                fontFamily: fontFamily ?? FontConstant.bricolage,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        TextFormField(
          focusNode: focusNode,
          readOnly: readOnly ?? false,
          onTap: onTap,
          textAlign: textAlign ?? TextAlign.start,
          controller: controller,
          initialValue: initialValue,
          keyboardType: keyboardType ?? TextInputType.text,
          textInputAction: textInputAction ?? TextInputAction.next,
          cursorColor: const Color(AppColors.primaryColor),
          enableSuggestions: false,
          autocorrect: autocorrect ?? false,
          obscureText: obscureText ?? false,
          inputFormatters: inputFormatters,
          maxLines: maxLines,
          minLines: minLines,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          autofocus: autofocus ?? true,
          enabled: enabled,
          maxLength: maxLength,
          enableInteractiveSelection: true,
          autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
          validator: validator,
          style:
              style ??
              TextStyle(
                color: const Color(AppColors.black),
                fontFamily: fontFamily ?? FontConstant.bricolage,
                fontWeight: FontWeight.w400,
                fontSize: fontSize ?? 14.sp,
                decoration: TextDecoration.none,
              ),
          decoration: InputDecoration(
            isCollapsed: true,
            contentPadding: contentPadding ?? EdgeInsets.symmetric(vertical: (height ?? 40.h) / 4, horizontal: 10.w),
            constraints: BoxConstraints.loose(const Size.fromWidth(double.infinity)),
            fillColor: fillColor ?? Colors.transparent,
            filled: true,
            prefix: prefix,
            suffix: surfix,
            prefixIcon: prefixIcon,
            suffixIcon: surfixIcon,
            counterStyle:
                hideCounter == true
                    ? const TextStyle(
                      fontSize: 0,
                      height: 0,
                      color: Colors.transparent,
                    )
                    : TextStyle(
                      color: Colors.black,
                      fontFamily: FontConstant.bricolage,
                    ),
            counterText: hideCounter == true ? '' : null,
            // labelText: labelText,
            labelStyle: TextStyle(
              fontFamily: fontFamily ?? FontConstant.bricolage,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: hintColor ?? const Color(AppColors.greyColor),
              fontFamily: fontFamily ?? FontConstant.bricolage,
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 10.r)), borderSide: BorderSide(color: activeBorderColor ?? const Color(AppColors.primaryColor))),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 10.r)),
              borderSide: BorderSide(color: activeBorderColor ?? const Color(AppColors.primaryColor)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 10.r)),
              borderSide: BorderSide(color: borderColor ?? const Color(AppColors.lightGreyColor)),
            ),
            disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 10.r)), borderSide: const BorderSide(color: Color(AppColors.disabledColor))),
            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 10.r)), borderSide: BorderSide(color: borderColor ?? const Color(AppColors.errorColor))),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
