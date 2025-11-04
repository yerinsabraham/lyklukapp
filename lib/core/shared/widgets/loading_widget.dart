import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/utils/theme/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  final Color? color;
  final double? height;
  final double? width;
  const LoadingWidget({
    super.key,
    this.color = const Color(AppColors.white),
    this.height,
    this.width,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 25.w,
      height: height ?? 25.h,
      child: Center(
        child:
            Platform.isIOS
                ? CupertinoActivityIndicator(color: color, radius: 10.r)
                : CircularProgressIndicator(color: color),
      ),
    );
  }
}

class LoadingDialog extends StatelessWidget {
  final Color? color;

  const LoadingDialog({super.key, this.color = const Color(AppColors.white)});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Center(child: LoadingWidget(color: color)),
    );
  }
}
