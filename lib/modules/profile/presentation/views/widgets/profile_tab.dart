import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

import '../../../../../utils/assets_manager.dart';

class ProfileTab extends HookConsumerWidget {
  final Function(int)? onTap;
  final int currentIndex;
  const ProfileTab({super.key, this.onTap, this.currentIndex = 0});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = useState(currentIndex);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              selected.value = 0;
              onTap?.call(0);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  IconAssets.logo,
                  height: 25.h,
                  width: 25.w,
                  colorFilter: ColorFilter.mode(
                    selected.value == 0
                        ? context.colorScheme.primary
                        : context.colorScheme.inversePrimary,
                    BlendMode.srcIn,
                  ),
                ),
                3.sH,
                Container(
                  height: 2.h,
                  width: 25.w,
                  decoration: BoxDecoration(
                    color:
                        selected.value == 0
                            ? context.colorScheme.primary
                            : context.colorScheme.surface,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              selected.value = 1;
              onTap?.call(1);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  IconAssets.bookmark2Icon,
                  height: 25.h,
                  width: 25.w,
                  colorFilter: ColorFilter.mode(
                    selected.value == 1
                        ? context.colorScheme.primary
                        : context.colorScheme.inversePrimary,
                    BlendMode.srcIn,
                  ),
                ),
                3.sH,
                Container(
                  height: 2.h,
                  width: 25.w,
                  decoration: BoxDecoration(
                    color:
                        selected.value == 1
                            ? context.colorScheme.primary
                            : context.colorScheme.surface,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ],
            ),
          ),
          
          GestureDetector(
            onTap: () {
              selected.value = 2;
              onTap?.call(2);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  IconAssets.mircophoneIcon,
                  height: 25.h,
                  width: 25.w,
                  colorFilter: ColorFilter.mode(
                    selected.value == 2
                        ? context.colorScheme.primary
                        : context.colorScheme.inversePrimary,
                    BlendMode.srcIn,
                  ),
                ),
                3.sH,
                Container(
                  height: 2.h,
                  width: 25.w,
                  decoration: BoxDecoration(
                    color:
                        selected.value == 2
                            ? context.colorScheme.primary
                            : context.colorScheme.surface,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              selected.value = 3;
              onTap?.call(3);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  IconAssets.shopIcon,
                  height: 25.h,
                  width: 25.w,
                  colorFilter: ColorFilter.mode(
                    selected.value == 3
                        ? context.colorScheme.primary
                        : context.colorScheme.inversePrimary,
                    BlendMode.srcIn,
                  ),
                ),
                3.sH,
                Container(
                  height: 2.h,
                  width: 25.w,
                  decoration: BoxDecoration(
                    color:
                        selected.value == 3
                            ? context.colorScheme.primary
                            : context.colorScheme.surface,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
