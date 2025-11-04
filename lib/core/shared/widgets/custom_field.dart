

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// ;
// import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
// ignore: depend_on_referenced_packages
import 'package:pinput/pinput.dart';

class CustomField extends HookConsumerWidget {
  final double? height;
  final double? width;
  final bool? readOnly;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final Widget? suffixWidget;
  final Widget? preffixWidget;
  final bool? obscureText;
  final String? obscuringCharacter;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? hintText;
  final Color? textColor;
  final double? textSize;
  final double? hintTextsize;
  final Color? hintColor;
  final Color? borderColor;
  final Function(String)? onChanged;
  final int? maxLines;
  final String? initialValue;
  final Color? fillColor;
  final Color? focusColor;
  final List<TextInputFormatter>? formatter;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final int? maxLength;
  final bool? autofocus;
  final bool hasBorder;
  final double? borderRadius;
  final BorderRadius? borderRadiusStyle;
  final TextCapitalization? textCapitalization;
  final FontWeight? fontWeight;
  final bool? enabled;
  final AutovalidateMode? autovalidateMode;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final EdgeInsets? padding;
  final TextInputAction? textInputAction;

  const CustomField({
    super.key,
    this.height,
    this.width,
    this.onTap,
    this.validator,
    this.suffixWidget,
    this.obscureText,
    this.keyboardType,
    this.controller,
    this.preffixWidget,
    this.hintText,
    this.textColor,
    this.hintTextsize = 10,
    this.hintColor,
    this.textSize,
    this.borderColor,
    this.readOnly,
    this.onChanged,
    this.maxLines,
    this.initialValue,
    this.fillColor,
    this.formatter,
    this.focusColor,
    this.focusNode,
    this.onFieldSubmitted,
    this.maxLength,
    this.autofocus,
    this.hasBorder = true,
    this.obscuringCharacter,
    this.borderRadius = 20,
    this.borderRadiusStyle,
    this.textCapitalization,
    this.fontWeight,
    this.enabled,
    this.autovalidateMode,
    this.textStyle,
    this.hintTextStyle,
    this.padding,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorFocusNode = focusNode ?? useFocusNode();

    return TextFormField(
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      enabled: enabled ?? true,
      buildCounter: (
        BuildContext context, {
        required int currentLength,
        required int? maxLength,
        required bool isFocused,
      }) {
        return maxLength == null
            ? const SizedBox()
            : Text('$currentLength/$maxLength', style: context.body14Light);
      },
      textInputAction: textInputAction,
      initialValue: initialValue,
      controller: controller,
      maxLength: maxLength,
      focusNode: colorFocusNode,
      autofocus: autofocus ?? false,
      readOnly: readOnly ?? false,
      obscureText: obscureText ?? false,
      obscuringCharacter: obscuringCharacter ?? '*',
      keyboardType: keyboardType ?? TextInputType.text,
      autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      style: textStyle ?? context.body14,
      onTap: onTap,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      // cursorColor: textColor ?? context.colorScheme.primary,
      maxLines: obscureText ?? false ? 1 : maxLines,
      enableSuggestions: true,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      inputFormatters: formatter,
      decoration: InputDecoration(
        hintText: hintText,
        isCollapsed: true,
        contentPadding:
            padding ??
            EdgeInsets.symmetric(
              vertical: (height ?? 50.h) / 4,
              horizontal: 10.w,
            ),
        hintStyle:
            hintTextStyle ??
            context.body14Light.copyWith(
              fontWeight: FontWeight.w400,
              color: hintColor,
            ),
        constraints: BoxConstraints.loose(
          Size.fromWidth(width ?? double.infinity),
        ),
        isDense: true,
        suffixIcon: suffixWidget,
        prefixIcon: preffixWidget,
        errorMaxLines: 2,
        errorStyle: TextStyle(
          color: context.colorScheme.errorContainer,
          fontSize: 10.sp,
        ),
        fillColor: fillColor ?? context.colorScheme.surface,
        filled: true,
        focusColor: focusColor ?? context.colorScheme.onPrimary,
        disabledBorder:
            hasBorder
                ? OutlineInputBorder(
                  borderRadius: borderRadiusStyle?? BorderRadius.circular(borderRadius ?? 4.r),
                  borderSide: BorderSide(
                    color: borderColor ?? context.colorScheme.onTertiaryFixed,
                    width: 1,
                  ),
                )
                : InputBorder.none,
        focusedBorder:
            hasBorder
                ? OutlineInputBorder(
                  borderRadius:  borderRadiusStyle ??
                      BorderRadius.circular(borderRadius ?? 4.r),
                  borderSide: BorderSide(
                    color: borderColor ?? context.colorScheme.primary,
                    width: 1,
                  ),
                )
                : InputBorder.none,
        focusedErrorBorder:
            hasBorder
                ? OutlineInputBorder(
                  borderRadius:
                      borderRadiusStyle ?? BorderRadius.circular(borderRadius ?? 4.r),
                  borderSide: BorderSide(
                    color: context.colorScheme.onTertiaryFixed,
                    width: 1,
                  ),
                )
                : InputBorder.none,
        enabledBorder:
            hasBorder
                ? OutlineInputBorder(
                  borderRadius:  borderRadiusStyle ??
                      BorderRadius.circular(borderRadius ?? 4.r),
                  borderSide: BorderSide(
                    color: borderColor ?? context.colorScheme.onTertiaryFixed,
                    width: 1,
                  ),
                )
                : InputBorder.none,
        border:
            hasBorder
                ? OutlineInputBorder(
                  borderRadius:
                      borderRadiusStyle ??
                      BorderRadius.circular(borderRadius ?? 4.r),
                  borderSide: BorderSide(
                    color: borderColor ?? context.colorScheme.primary,
                    width: 1,
                  ),
                )
                : InputBorder.none,
      ),
    );
  }

  CustomField copyWith({
    double? height,
    double? width,
    VoidCallback? onTap,
    String? Function(String?)? validator,
    Widget? suffixWidget,
    Widget? preffixWidget,
    bool? obscureText,
    TextInputType? keyboardType,
    TextEditingController? controller,
    String? hintText,
    Color? textColor,
    double? textSize,
    double? hintTextsize,
    Color? hintColor,
  }) {
    return CustomField(
      height: height ?? this.height,
      width: width ?? this.width,
      onTap: onTap ?? this.onTap,
      validator: validator ?? this.validator,
      suffixWidget: suffixWidget ?? this.suffixWidget,
      preffixWidget: preffixWidget ?? this.preffixWidget,
      obscureText: obscureText ?? this.obscureText,
      keyboardType: keyboardType ?? this.keyboardType,
      controller: controller ?? this.controller,
      hintText: hintText ?? this.hintText,
      textColor: textColor ?? this.textColor,
      textSize: textSize ?? this.textSize,
      hintTextsize: hintTextsize ?? this.hintTextsize,
      hintColor: hintColor ?? this.hintColor,
    );
  }
}

class CustomPinField extends HookConsumerWidget {
  final FocusNode? node;
  final TextEditingController? otpController;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  const CustomPinField({
    super.key,
    this.node,
    this.otpController,
    this.onChanged,
    this.validator,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Pinput(
      focusedPinTheme: PinTheme(
        width: 48.h,
        height: 48.h,
        textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600,
        ),
        decoration: BoxDecoration(
          color: context.colorScheme.outline.withValues(alpha: .1),
          border: Border.all(width: 1.w, color: context.colorScheme.primary),
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      submittedPinTheme: PinTheme(
        width: 48.h,
        height: 48.h,
        textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600,
        ),
        decoration: BoxDecoration(
          color: context.colorScheme.outline.withValues(alpha: .1),
          border: Border.all(width: 1.w, color: context.colorScheme.primary),
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),

      defaultPinTheme: PinTheme(
        width: 48.h,
        height: 48.h,
        textStyle: TextStyle(
          fontSize: 20,
          color: context.colorScheme.onPrimary,
          fontWeight: FontWeight.w600,
        ),
        decoration: BoxDecoration(
          color: context.colorScheme.outline,
          border: Border.all(
            width: 0.5.w,
            color: context.colorScheme.onTertiary,
          ),
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      length: 4,
      mainAxisAlignment: MainAxisAlignment.start,
      focusNode: node ?? useFocusNode(),
      controller: otpController,
      textInputAction: TextInputAction.done,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      //separator: const XMargin(3),
      onChanged: onChanged,
      validator: validator,
    );
  }
}

class CustomFieldDropDown<T> extends StatelessWidget {
  final List<T> items;
  final String? initialValue;
  final Function(T)? onChanged;
  final Widget? suffixWidget;
  final Widget? preffixWidget;
  final double? height;
  final double? width;
  final bool? readOnly;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;

  final bool? obscureText;
  final String? obscuringCharacter;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? hintText;
  final Color? textColor;
  final double? textSize;
  final double? hintTextsize;
  final Color? hintColor;
  final Color? borderColor;

  final int? maxLines;

  final Color? fillColor;
  final Color? focusColor;
  final List<TextInputFormatter>? formatter;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final int? maxLength;
  final bool? autofocus;
  final bool hasBorder;
  final double? borderRadius;
  final TextCapitalization? textCapitalization;
  final FontWeight? fontWeight;
  final bool? enabled;
  final AutovalidateMode? autovalidateMode;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final EdgeInsets? padding;
  const CustomFieldDropDown({
    super.key,
    required this.items,
    this.initialValue,
    this.onChanged,
    this.suffixWidget,
    this.preffixWidget,
    this.height,
    this.width,
    this.onTap,
    this.validator,

    this.obscureText,
    this.keyboardType,
    this.controller,

    this.hintText,
    this.textColor,
    this.hintTextsize = 10,
    this.hintColor,
    this.textSize,
    this.borderColor,
    this.readOnly,

    this.maxLines,

    this.fillColor,
    this.formatter,
    this.focusColor,
    this.focusNode,
    this.onFieldSubmitted,
    this.maxLength,
    this.autofocus,
    this.hasBorder = true,
    this.obscuringCharacter,
    this.borderRadius = 20,
    this.textCapitalization,
    this.fontWeight,
    this.enabled,
    this.autovalidateMode,
    this.textStyle,
    this.hintTextStyle,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return CustomField(
      readOnly: true,
      initialValue: initialValue,
      suffixWidget: PopupMenuButton(
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: context.colorScheme.onSecondary,
        ),
        itemBuilder: (context) {
          return items.map((item) {
            return PopupMenuItem(
              value: item,
              child: Text(item.toString().capitalize),
            );
          }).toList();
        },
        onSelected: (value) {
          onChanged!(value);
        },
      ),
    );
  }
}



class CustomFieldDatePicker extends StatelessWidget {
  final String? initialValue;
  final Function(DateTime)? onChanged;
  final Widget? suffixWidget;
  final Widget? preffixWidget;
  final double? height;
  final double? width;
  final bool? readOnly;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;

  final bool? obscureText;
  final String? obscuringCharacter;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? hintText;
  final Color? textColor;
  final double? textSize;
  final double? hintTextsize;
  final Color? hintColor;
  final Color? borderColor;

  final int? maxLines;

  final Color? fillColor;
  final Color? focusColor;
  final List<TextInputFormatter>? formatter;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final int? maxLength;
  final bool? autofocus;
  final bool hasBorder;
  final double? borderRadius;
  final TextCapitalization? textCapitalization;
  final FontWeight? fontWeight;
  final bool? enabled;
  final AutovalidateMode? autovalidateMode;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final EdgeInsets? padding;
  const CustomFieldDatePicker({
    super.key,

    this.initialValue,
    this.onChanged,
    this.suffixWidget,
    this.preffixWidget,
    this.height,
    this.width,
    this.onTap,
    this.validator,

    this.obscureText,
    this.keyboardType,
    this.controller,

    this.hintText,
    this.textColor,
    this.hintTextsize = 10,
    this.hintColor,
    this.textSize,
    this.borderColor,
    this.readOnly,

    this.maxLines,

    this.fillColor,
    this.formatter,
    this.focusColor,
    this.focusNode,
    this.onFieldSubmitted,
    this.maxLength,
    this.autofocus,
    this.hasBorder = true,
    this.obscuringCharacter,
    this.borderRadius = 20,
    this.textCapitalization,
    this.fontWeight,
    this.enabled,
    this.autovalidateMode,
    this.textStyle,
    this.hintTextStyle,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return CustomField(
      readOnly: true,
      initialValue: initialValue,
      validator: validator,
      hintText: hintText,
      
      suffixWidget:  GestureDetector(
        child: Icon(
          Icons.calendar_today,
          color: context.colorScheme.onSecondary,
        ),
        onTap: () async {
          final date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (date != null) {
            onChanged?.call(date);
          }
        },
      ),
    );
  }
}


