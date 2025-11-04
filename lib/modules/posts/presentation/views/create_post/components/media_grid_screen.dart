import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/widgets/top_chip.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/theme/theme.dart';

class MediaGridScreen extends HookConsumerWidget {
  const MediaGridScreen({
    super.key,
    required this.onBack,
    required this.onNext,
    required this.onAddSound,
  });

  final VoidCallback onBack;
  final VoidCallback onNext;
  final VoidCallback onAddSound;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final tab = useState(1); // All / Videos / Photos

    return Column(
      children: [
        8.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Row(
            children: [
              IconButton(
                onPressed: onBack,
                icon: Icon(Icons.close_rounded, color: cs.onPrimary),
              ),
              8.horizontalSpace,
              TopChip(label: 'AI', asset: IconAssets.spotify, onTap: () {}),
              const Spacer(),
              TopChip(
                label: 'Add sound',
                asset: IconAssets.spotify,
                onTap: onAddSound,
              ),
            ],
          ),
        ),
        8.verticalSpace,
        _Tabs(index: tab.value, onChanged: (i) => tab.value = i),
        8.verticalSpace,
        Expanded(child: _Grid()),
        Container(
          padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 12.h + 8),
          color: Colors.black,
          child: AppButton(
            isLoading: false,
            isDisabled: false,
            onPressed: onNext,
            borderRadius: BorderRadius.circular(5.r),
            backgroundColor: const Color(AppColors.primaryColor),
            widget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  text: 'Next',
                  fontSize: 14.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Tabs extends StatelessWidget {
  const _Tabs({required this.index, required this.onChanged});
  final int index;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final items = ['All', 'Videos', 'Photos'];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: List.generate(items.length, (i) {
          final selected = i == index;
          return Padding(
            padding: EdgeInsets.only(right: 14.w),
            child: GestureDetector(
              onTap: () => onChanged(i),
              child: Text(
                items[i],
                style: TextStyle(
                  color:
                      selected
                          ? cs.onPrimary
                          : cs.onPrimary.withValues(alpha: .6),
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _Grid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.deepOrange,
      Colors.orange,
      Colors.amber,
      Colors.yellow.shade700,
    ];

    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 6.h,
        crossAxisSpacing: 6.w,
      ),
      itemCount: 18,
      itemBuilder: (_, i) {
        final c = colors[i % colors.length];
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: c,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            Positioned(
              left: 6,
              bottom: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: .45),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  '0:09',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
