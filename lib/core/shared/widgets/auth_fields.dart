import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

import '../../../utils/theme/app_colors.dart';
import 'shared_widget.dart';

class AuthField extends HookConsumerWidget {
  final String? label;
  final String? hint;
  final Color? fillColor;
  final TextEditingController? controller;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final int? maxLines;
  final String? initialValue;
  final TextCapitalization? textCapitalization;
  final bool readOnly;
  final bool enable;
  final Widget? suffix;
  final Widget? preffix;
  final VoidCallback? onTap;
  final TextStyle? style;
  final List<TextInputFormatter>? formatter;
  const AuthField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.obscureText,
    this.keyboardType,
    this.onChanged,
    this.validator,
    this.maxLines,
    this.initialValue,
    this.textCapitalization,
    this.readOnly = false,
    this.enable = true,
    this.suffix,
    this.onTap,
    this.style,
    this.formatter,
    this.preffix,
    this.fillColor,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Offstage(
          offstage: label == null,
          child: Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: Text(
              label ?? "",
              style: context.body14.copyWith(
                color: context.colorScheme.inversePrimary,
              ),
            ),
          ),
        ),
        CustomField(
          fillColor: fillColor  ,
          enabled: enable,
          onTap: onTap,
          preffixWidget: preffix,
          formatter: formatter,
          borderRadius: 10,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLines: maxLines,
          initialValue: initialValue,
          validator: validator,
          onChanged: onChanged,
          controller: controller,
          hasBorder: true,
          hintColor: Color(AppColors.textColor2),
          fontWeight: FontWeight.w400,
          hintText: hint?.capitalize ?? "",
          hintTextsize: 18.sp,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          suffixWidget: suffix,
          readOnly: readOnly,
          textStyle: style ?? context.body14,
        ),
      ],
    );
  }
}

class AuthFieldWithDropDown<T> extends HookConsumerWidget {
  final List<T> items;
  final T? selectedItem;
  final ValueChanged<T>? onSelectedItemChanged;
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final int? maxLines;
  final String? initialValue;
  final TextCapitalization? textCapitalization;
  final bool readOnly;
  final bool enable;
  final Widget? suffix;
  final Widget? preffix;
  final VoidCallback? onTap;
  final TextStyle? style;
  final List<TextInputFormatter>? formatter;
  const AuthFieldWithDropDown({
    super.key,
    this.items = const [],
    this.selectedItem,
    this.onSelectedItemChanged,
    this.label,
    this.hint,
    this.controller,
    this.obscureText,
    this.keyboardType,
    this.onChanged,
    this.validator,
    this.maxLines,
    this.initialValue,
    this.textCapitalization,
    this.readOnly = false,
    this.enable = true,
    this.suffix,
    this.onTap,
    this.style,
    this.formatter,
    this.preffix,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Offstage(
          offstage: label == null,
          child: Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: Text(
              label ?? "",
              style: context.body14.copyWith(
                color: context.colorScheme.inversePrimary,
              ),
            ),
          ),
        ),
        CustomField(
          enabled: enable,

          // height: 20.h,
          onTap: onTap,
          preffixWidget: preffix,
          formatter: formatter,
          borderRadius: 10,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLines: maxLines,
          initialValue: initialValue,
          validator: validator,
          onChanged: onChanged,
          controller: controller,
          hasBorder: true,
          hintColor: Color(AppColors.textColor2),
          fontWeight: FontWeight.w400,
          hintText: hint?.capitalize ?? "",
          hintTextsize: 18.sp,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          suffixWidget: PopupMenuButton(
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: context.colorScheme.inversePrimary,
            ),
            padding: EdgeInsets.zero,
            color: context.colorScheme.surface,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.transparent),
            ),
            // splashRadius: 0,
            itemBuilder: (c) {
              return List.generate(items.length, (i) {
                final e = items[i];
                return PopupMenuItem(
                  value: e.toString(),
                  child: Text(e.toString(), style: context.body14),
                  onTap: () {
                    onSelectedItemChanged?.call(e);
                  },
                );
              });
            },
          ),
          readOnly: readOnly,
          textStyle: style ?? context.body14,
        ),
      ],
    );
  }
}

class AuthFieldDatePicker extends HookConsumerWidget {
  final ValueChanged<DateTime>? onSelectedItemChanged;
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final int? maxLines;
  final String? initialValue;
  final TextCapitalization? textCapitalization;
  final bool readOnly;
  final bool enable;
  final Widget? suffix;
  final Widget? preffix;
  final VoidCallback? onTap;
  final TextStyle? style;
  final List<TextInputFormatter>? formatter;
  const AuthFieldDatePicker({
    super.key,
    this.onSelectedItemChanged,
    this.label,
    this.hint,
    this.controller,
    this.obscureText,
    this.keyboardType,
    this.onChanged,
    this.validator,
    this.maxLines,
    this.initialValue,
    this.textCapitalization,
    this.readOnly = false,
    this.enable = true,
    this.suffix,
    this.onTap,
    this.style,
    this.formatter,
    this.preffix,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Offstage(
          offstage: label == null,
          child: Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: Text(
              label ?? "",
              style: context.body14.copyWith(
                color: context.colorScheme.inversePrimary,
              ),
            ),
          ),
        ),
        CustomField(
          enabled: enable,

          // height: 20.h,
          onTap: onTap,
          preffixWidget: preffix,
          formatter: formatter,
          borderRadius: 10,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLines: maxLines,
          initialValue: initialValue,
          validator: validator,
          onChanged: onChanged,
          controller: controller,
          hasBorder: true,
          hintColor: Color(AppColors.textColor2),
          fontWeight: FontWeight.w400,
          hintText: hint?.capitalize ?? "",
          hintTextsize: 18.sp,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          suffixWidget: GestureDetector(
            child: Icon(
              Icons.calendar_today,
              color: context.colorScheme.onSecondary,
            ),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(DateTime.now().year + 100),
                builder: (context, child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: Colors.deepPurple, // header background color
                        onPrimary: Colors.white, // header text color
                        onSurface: Colors.black, // body text color
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          foregroundColor:
                              Colors.deepPurple, // button text color
                        ),
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (date != null) {
                onSelectedItemChanged?.call(date);
              }
            },
          ),
          readOnly: readOnly,
          textStyle: style ?? context.body14,
        ),
      ],
    );
  }
}
