import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/core/shared/widgets/shared_widget.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Size? size;
  final Widget? child;
  final Widget? title;
  final List<Widget>? actions;
  final bool? centerTitle;
  final Color? backgroundColor;

  final bool automaticallyImplyLeading;

  const CustomAppbar({
    super.key,
    this.size,
    this.child,
    this.title,
    this.actions,
    this.centerTitle,
    this.backgroundColor,
    this.automaticallyImplyLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return child ??
        Container(
          height: size?.height ?? kToolbarHeight,
          width: size?.width ?? double.infinity,
          // margin: EdgeInsets.only(top: 20.h),
          decoration: BoxDecoration(
            color: backgroundColor ?? context.colorScheme.surface,
          ),
          child: Row(
            children: [
              if (automaticallyImplyLeading) ExitButton(),
              30.sW,
              title ?? SizedBox.shrink(),
              30.sW,
              ...actions ?? [],
            ],
          ),
        );
  }

  @override
  Size get preferredSize => size ?? const Size.fromHeight(kToolbarHeight);
}

class CustomTileAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Size? size;
  final Widget? child;
  final Widget? title;
  final Widget? leading;
  final Widget? subTitle;
  final List<Widget>? actions;
  final bool? centerTitle;
  final Color? backgroundColor;

  final bool automaticallyImplyLeading;

  const CustomTileAppbar({
    super.key,
    this.size,
    this.child,
    this.title,
    this.leading,
    this.subTitle,
    this.actions,
    this.centerTitle,
    this.backgroundColor,
    this.automaticallyImplyLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          ExitButton(
            child: Icon(
              Icons.keyboard_backspace_rounded,
              color: context.colorScheme.primary,
              size: 24.sp,
            ),
          ),
          10.sW,
          leading ?? SizedBox.shrink(),
          10.sW,
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title ?? SizedBox.shrink(),
              10.sW,
              subTitle ?? SizedBox.shrink(),
            ],
          ),
        ],
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => size ?? const Size.fromHeight(kToolbarHeight);
}
