import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/shared_widget.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

import '../../../../utils/helpers/toast_notification.dart';
import '../../../../utils/router/app_router.dart';
import '../../../auth/presentation/view_model/notifier/auth_notifier.dart';

class ProfileSettingsPage extends ConsumerWidget {
  const ProfileSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authNotifierProvider, (previous, current) {
      current.maybeWhen(
        orElse: () {},
        logoutSuccess: (message) {
          context.pop();
        },
        logoutFailure: (message) {
          ToastNotification.showCustomNotification(
            title: 'Logout ',
            subtitle: message,
            isSuccess: false,
          );
        },
      );
    });
    return Scaffold(
      appBar: CustomTileAppbar(
        backgroundColor: context.colorScheme.surface,
        leadingWidget: ExitButton(
          color: context.colorScheme.onSecondary.withValues(alpha: 0.08),
          size: 32.r,
          child: Icon(
            Icons.keyboard_backspace,
            size: 20.r,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Profile Settings',
          style: context.title24.copyWith(fontWeight: FontWeight.w700),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Icon(
              CupertinoIcons.search,
              size: 28.r,
              color: context.colorScheme.inversePrimary,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            5.sH,
            SettingSection(
              title: 'GENERAL',
              children: [
                SettingTile(
                  icon: SvgPicture.asset(IconAssets.bookmark2Icon),
                  label: 'Saved content',
                  onTap: () {},
                ),
                SettingTile(
                  icon: SvgPicture.asset(IconAssets.activityIcon),
                  label: 'Activities',
                  onTap: () {},
                ),
                SettingTile(
                  icon: SvgPicture.asset(IconAssets.contentIcon),
                  label: 'Content preferences',
                  onTap: () {},
                ),
                SettingTile(
                  icon: SvgPicture.asset(IconAssets.podcastManagementIcon),
                  label: 'Podcast preferences',
                  onTap: () {},
                ),
                SettingTile(
                  icon: SvgPicture.asset(IconAssets.bellIcon, color: context.colorScheme.inversePrimary,),
                  label: 'Notifications settings',
                  onTap: () {},
                ),
              ],
            ),
            5.sH,
            SettingSection(
              title: 'MARKETPLACE',
              children: [
                SettingTile(
                  icon: SvgPicture.asset(IconAssets.cartIcon),
                  label: 'Cart',
                  onTap: () {
                    context.pushNamed(Routes.cartRoute);
                  },
                ),
                SettingTile(
                  icon: SvgPicture.asset(IconAssets.orderIcon),
                  label: 'Orders',
                  onTap: () {
                    context.pushNamed(Routes.ordersRoute);
                  },
                ),
                SettingTile(
                  icon: SvgPicture.asset(IconAssets.favoriteOutlineIcon),
                  label: 'Wishlist',
                  onTap: () {},
                ),
                SettingTile(
                  icon: SvgPicture.asset(
                    IconAssets.storeIcon,
                    color: Colors.black,
                  ),
                  label: 'My stores',
                  onTap: () {},
                ),
                SettingTile(
                  icon: SvgPicture.asset(IconAssets.locationIcon),
                  label: 'Delivery addresses',
                  onTap: () {},
                ),
              ],
            ),
            5.sH,
            SettingSection(
              title: 'PREFERENCES',
              children: [
                SettingTile(
                  icon: SvgPicture.asset(IconAssets.preniumCheckIcon),
                  label: 'Premium tool',
                  onTap: () {},
                ),
                SettingTile(
                  icon: SvgPicture.asset(IconAssets.accountPrivacyIcon2),
                  label: 'Account privacy',
                  onTap: () {},
                ),
                SettingTile(
                  icon: SvgPicture.asset(IconAssets.adsToolIcon),
                  label: 'Ad management',
                  onTap: () {},
                ),
                SettingTile(
                  icon: SvgPicture.asset(IconAssets.sessionIcon),
                  label: 'Sessions',
                  onTap: () {},
                ),
                SettingTile(
                  icon: SvgPicture.asset(IconAssets.lockIcon),
                  label: 'Security',
                  onTap: () {},
                ),
              ],
            ),
            5.sH,
            SettingSection(
              title: 'PAYMENT',
              children: [
                SettingTile(
                  icon: SvgPicture.asset(IconAssets.wallet2Icon),
                  label: 'Wallet settings',
                  onTap: () {
                    context.pushNamed(Routes.walletScreenRoute);
                  },
                ),
              ],
            ),
            5.sH,
            SettingSection(
              title: 'INFO',
              children: [
                SettingTile(
                  icon: SvgPicture.asset(IconAssets.helpIcon),
                  label: 'Help',
                  onTap: () {},
                ),
                SettingTile(
                  icon: SvgPicture.asset(IconAssets.aboutUsIcon),
                  label: 'About',
                  onTap: () {},
                ),
              ],
            ),
            5.sH,
            SettingSection(
              title: 'DANGER ZONE',
              children: [
                SettingTile(
                  icon: SvgPicture.asset(IconAssets.logoutIcon),
                  label: 'Log out',
                  
                  onTap: () {
                     ref.read(authNotifierProvider.notifier).logout();
                  },
                ),
              ],
            ),
            50.sH,
          ],
        ),
      ),
    );
  }
}

class SettingSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const SettingSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 16.h),
            child: Text(
              title,
              style: context.body12.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  const SettingTile({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.danger = false,
  });

  final Widget icon;
  final String label;
  final VoidCallback? onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    // final color = danger ? const Color(0xFFEF4444) : const Color(0xFF111827);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(
          top: BorderSide(color: Colors.grey.shade300, width: 0.5.w),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: ListTile(
          onTap: onTap,
          leading: icon,
          title: Text(label, style: context.body16),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.r,
            color: context.colorScheme.onSecondary,
          ),
        ),
      ),
    );
  }
}
