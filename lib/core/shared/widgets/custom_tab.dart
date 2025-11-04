// ignore_for_file: unused_result

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/profile/presentation/view_model/providers/followers_provider.dart';
import 'package:lykluk/modules/profile/presentation/view_model/providers/following_provider.dart';
import 'package:lykluk/modules/profile/presentation/view_model/providers/requests_provider.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/storage/local_storage.dart';

class CustomTab<T> extends HookConsumerWidget {
  final List<String> tabs;
  final int initialTabIndex;
  final Function(String) onSelect;
  final Function(int)? onIndexChanged;
  final EdgeInsets? padding;
  final EdgeInsets? childPadding;
  final bool scrollable;
  const CustomTab({
    super.key,
    required this.tabs,
    required this.onSelect,
    this.padding,
    this.initialTabIndex = 0,
    this.childPadding,
    this.onIndexChanged,
    this.scrollable = false,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = useState(initialTabIndex);
    if (selectedTab.value == 0) {
      ref.invalidate(
        followersProvider((
          userId: HiveStorage.username,
          search: '',
          sortBy: 'Default',
        )),
      );
    } else if (selectedTab.value == 1) {
      ref.invalidate(
        followingProvider((
          userId: HiveStorage.username,
          search: '',
          sortBy: 'Default',
        )),
      );
    } else if (selectedTab.value == 2) {
      ref.invalidate(requestsProvider((search: '', sortBy: 'Default')));
    }
    return Container(
      padding: padding ?? EdgeInsets.symmetric(vertical: 20.h),
      width: double.infinity,
      color: context.colorScheme.surface,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics:
            scrollable
                ? AlwaysScrollableScrollPhysics()
                : NeverScrollableScrollPhysics(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(tabs.length, (i) {
            return CustomTabTile(
              padding: childPadding,
              title: tabs[i],
              isSelected: i == selectedTab.value,
              onTap: () {
                selectedTab.value = i;
                onSelect.call(tabs[i]);
                onIndexChanged?.call(i);
              },
            );
          }),
        ),
      ),
    );
  }
}

class CustomTabTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final EdgeInsets? padding;

  const CustomTabTile({
    super.key,
    required this.isSelected,
    required this.title,
    required this.onTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? EdgeInsets.all(10.r),
        constraints: BoxConstraints(minWidth: 80.w),
        // width: 85.w,
        // height: 30.h,
        // margin: EdgeInsets.only(right: 10.w, ),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? context.colorScheme.primaryFixedDim
                  : context.colorScheme.onTertiaryFixed.withValues(alpha: .1),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Text(
            title,
            style: context.body16Light.copyWith(
              color:
                  isSelected
                      ? context.colorScheme.surface
                      : context.colorScheme.inversePrimary,
            ),
          ),
        ),
      ),
    );
  }
}
