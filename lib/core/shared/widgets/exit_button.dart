import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

class ExitButton extends StatelessWidget {
  final Widget? child;
  final VoidCallback? onTap;
  final double? size;
  final Color? color;
  const ExitButton({super.key, this.child, this.onTap, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => context.pop(),
      child: Container(
        height: size ?? 32.h,
        width: size ?? 32.w,
        decoration: BoxDecoration(
          color: color?? context.colorScheme.onSecondary.withValues(alpha: .1),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: child ?? Icon(Icons.close, color: context.colorScheme.inversePrimary),
        ),
      ),
    );
  }
}
