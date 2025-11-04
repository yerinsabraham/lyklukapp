import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/router/app_router.dart';

final homeTabController = StateProvider((_) => 0);

class HomeTab extends HookConsumerWidget {
  final Color? active;
  final Color? inactive;
  final Color? activeIndicator;
  final Color? inactiveIndicator;
  final Color? backgroundColor;

  const HomeTab({
    super.key,
    this.active,
    this.inactive,
    this.activeIndicator,
    this.inactiveIndicator,
    this.backgroundColor,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabs = ['Luks', "Following", "Mutuals", "Market", "Podcast"];
    final selectedTab = ref.watch(homeTabController);
    final tabNotifier = ref.read(homeTabController.notifier);
    return Container(
      decoration: BoxDecoration(color: backgroundColor),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: GestureDetector(
                onTap: () {
                  // selectedTab.value = 4;
                  context.pushNamed(Routes.notificationPageRoute);
                },
                child: Badge(
                  backgroundColor: Colors.red,
                  child: SvgPicture.asset(
                    IconAssets.bellIcon,
                    colorFilter: ColorFilter.mode(
                      active ??
                          context.colorScheme.onSecondary.withValues(alpha: .6),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ),
          5.sH,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...List.generate(tabs.length, (i) {
                return GestureDetector(
                  onTap: () {
                    // selectedTab.value = i;
                    tabNotifier.update((c) => i);
                  },
                  child: _buildTile(
                    title: tabs[i],
                    isSelected: i == selectedTab,
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTile({required String title, bool isSelected = false}) {
    return Builder(
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.body16.copyWith(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color:
                    isSelected
                        ? active ?? context.colorScheme.inversePrimary
                        : inactive ??
                            context.colorScheme.onSecondary.withValues(
                              alpha: .6,
                            ),
              ),
            ),
            20.sH,
            if (isSelected)
              Container(
                height: 2.h,
                width: 50.w,
                decoration: BoxDecoration(
                  color:
                      isSelected
                          ? activeIndicator ?? context.colorScheme.surface
                          : inactiveIndicator ??
                              context.colorScheme.onTertiaryFixed,
                ),
              ),
          ],
        );
      },
    );
  }
}
