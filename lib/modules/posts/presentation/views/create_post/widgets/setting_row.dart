import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/utils/theme/theme.dart';

class SettingRow extends StatelessWidget {
  const SettingRow({super.key, required this.title, required this.trailing});
  final String title;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: AppText(
        text: title,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: Color(AppColors.black),
      ),
      trailing: trailing,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
    );
  }
}
