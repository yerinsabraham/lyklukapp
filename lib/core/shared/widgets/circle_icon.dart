

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

class CircleIcon extends StatelessWidget {
  final Widget child;
  final Color? color;
  final VoidCallback? onTap;
  const CircleIcon({super.key, required this.child, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color?? context.colorScheme.surface,
        ),
        child: child
      
      ),
    );
  }
}
