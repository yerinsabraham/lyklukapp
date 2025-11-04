import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

class ActionTile extends StatelessWidget {
  final String title;
  final Function()? onTap;
  final Widget? trailing;
  final bool hasBorder;
  final String? subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final EdgeInsets? padding;
  const ActionTile({
    super.key,
    required this.title,
    this.onTap,
    this.trailing,
    this.hasBorder = true,
    this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding?? EdgeInsets.symmetric(vertical: 16.h, horizontal: 0.w),
        decoration: BoxDecoration(
          border:
              hasBorder
                  ? Border(
                    bottom: BorderSide(
                      color: context.colorScheme.onSecondary.withValues(
                        alpha: 0.1,
                      ),
                      width: 1,
                    ),
                  )
                  : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                      titleStyle ??
                      context.body16.copyWith(
                        color: context.colorScheme.inversePrimary,
                      ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style:
                        subtitleStyle ??
                        context.body12.copyWith(
                          color: context.colorScheme.onSecondary.withValues(
                            alpha: 0.5,
                          ),
                        ),
                  ),
              ],
            ),
            Spacer(),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
