import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/widgets/bottom_sheet_wrapper.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/widgets/search_field.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/widgets/tab_switch.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/widgets/track_tile.dart';
import 'package:lykluk/utils/theme/app_colors.dart';

class SongPickerSheet extends HookConsumerWidget {
  const SongPickerSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = useState(1); // For you / Trending / Saved
    final tracks = List.generate(
      14,
      (i) => TrackModel(
        title: 'Sweet Love',
        artist: 'Burna Boy',
        duration: '3:32',
      ),
    );

    return BottomSheetWrapper(
      title: '',
      child: Container(
        decoration: BoxDecoration(color: Color(AppColors.buttonColor)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            5.verticalSpace,
            const SearchField(hint: 'Search music'),
            12.verticalSpace,
            TabSwitch(
              items: const ['For you', 'Trending', 'Saved'],
              index: tab.value,
              onChanged: (i) => tab.value = i,
            ),
            8.verticalSpace,

            ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const ClampingScrollPhysics(),
              itemCount: tracks.length,
              separatorBuilder:
                  (_, __) => const Divider(height: 1, thickness: .2),
              itemBuilder: (_, i) => TrackTile(track: tracks[i], onAdd: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
