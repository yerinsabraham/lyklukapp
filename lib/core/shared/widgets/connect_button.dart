import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

class ConnectButton extends StatelessWidget {
  final Color? color;
  final Color? textColor;
  final Color? borderColor;

  const ConnectButton({
    super.key,
    this.color,
    this.borderColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side:
            borderColor == null
                ? BorderSide.none
                : BorderSide(color: borderColor!, width: 1.w),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        backgroundColor:
            color ?? context.colorScheme.primaryFixedDim.withValues(alpha: .1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      onPressed: () {},
      child: Text(
        'Connect',
        style: context.body14Light.copyWith(
          color: textColor ?? context.colorScheme.primary,
        ),
      ),
    );
  }
}
