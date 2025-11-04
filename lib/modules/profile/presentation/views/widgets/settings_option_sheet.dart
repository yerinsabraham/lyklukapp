import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/shared_widget.dart';
import 'package:lykluk/modules/auth/presentation/view_model/notifier/auth_notifier.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/widgets/bottom_sheet_wrapper.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/router/app_router.dart';
import 'package:lykluk/utils/theme/theme.dart';

class SettingsOptionsSheet extends HookConsumerWidget {
  const SettingsOptionsSheet({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
      
    // final cs = Theme.of(context).colorScheme;
    final items = [
      _SettingOptionItem("LykLuk Studio", IconAssets.studioIcon, () {}),
      _SettingOptionItem("Ad tools", IconAssets.adsToolIcon, () {}),
      _SettingOptionItem("Wallet", IconAssets.settingsWalletIcon, () {
        AppRouter.router.pop();
        AppRouter.router.pushNamed(Routes.walletScreenRoute);
      }),
      _SettingOptionItem("Share Profile", IconAssets.shareProfileIcon, () {}),
      _SettingOptionItem("Settings and privacy", IconAssets.gearIcon, () {}),
      _SettingOptionItem("Logout", IconAssets.forwardArrowIcon, () {
        ref.read(authNotifierProvider.notifier).logout();
        // context.pop();
      }),
    ];

    return BottomSheetWrapper(
      title: '',
      hasDrag: true,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: const Color(AppColors.white),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(items.length, (i) {
            final item = items[i];
            return ActionTile(
              titleStyle: context.body14.copyWith(color: Colors.black),
              padding: EdgeInsets.symmetric(vertical: 10.h),
              title: item.label,
              trailing: SvgPicture.asset(
                item.icon,
                // color: Colors.black,
              ),
              onTap: item.onTap,
            );
          }),
        ),
      ),
    );
  }
}

class _SettingOptionItem {
  final String label;
  final String icon;
  final VoidCallback onTap;

  _SettingOptionItem(this.label, this.icon, this.onTap);
}
