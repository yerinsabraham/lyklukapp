import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/domain/notification_constants.dart';
import 'package:lykluk/utils/constant/font_constant.dart';
import 'package:lykluk/utils/router/app_router.dart';
import 'package:lykluk/utils/theme/theme.dart';

/// Custom AppBar for notification screens
class NotificationAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final bool showBackButton;
  final Widget? trailing;
  final Color? backgroundColor;

  const NotificationAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
    this.showBackButton = true,
    this.trailing,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:
          backgroundColor ?? Color(AppColors.white).withValues(alpha: 0.95),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      leading:
          showBackButton
              ? IconButton(
                onPressed: onBackPressed ?? () => AppRouter.router.pop(),
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: const Color(NotificationConstants.primaryTextColor),
                  size: 20.sp,
                ),
              )
              : null,
      title: AppText(
        text: title,
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: const Color(NotificationConstants.primaryTextColor),
        fontFamily: FontConstant.bricolage,
      ),
      centerTitle: true,
      actions: trailing != null ? [trailing!] : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}


