import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/hooks/scroll_hook.dart';

import '../../../../../../core/shared/widgets/shared_widget.dart';
import '../../../../../home/presentation/widgets/home_tab.dart';

import '../../../view_model/providers/posts_provider.dart';
import '../widgets/post_feed.dart';
import '../widgets/video_background.dart';
import 'package:preload_page_view/preload_page_view.dart';

class PostsFeed extends HookConsumerWidget {
  const PostsFeed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItems = ref.watch(fypProvider);
    final notifier = ref.watch(fypProvider.notifier);

    final pageController = usePreloadPagination(
      notifier.loadMore,
      notifier.canLoadMore,
    );

    return RefreshIndicator(
      onRefresh: () => ref.refresh(fypProvider.future),
      child: Stack(
        children: [
          asyncItems.when(
            data: (reels) {
              if (reels.dataList.isEmpty) {
                return VideoBackground(
                  child: SizedBox.expand(
                    child: Center(
                      child: Text(
                        'No video found',
                        style: context.bodySmall18.copyWith(
                          color: context.colorScheme.surface,
                        ),
                      ),
                    ),
                  ),
                );
              }
              return PreloadPageView.builder(
                controller: pageController,
                preloadPagesCount: 2,
                scrollDirection: Axis.vertical,
                itemCount: reels.dataList.length,
                onPageChanged: (index) {
                 // notifier.handleScroll(index);
                  ref.read(fypProvider.notifier).handleScroll(index);

                  // if (index >= reels.dataList.length - 2) {
                  //   notifier.loadMore();
                  // }
                },
                itemBuilder: (context, index) {
                  final item = reels.dataList[index];

                  if (!item.initialized || item.controller == null) {
                    // return const Center(child: CircularProgressIndicator());
                    return Container(
                      height: context.height,
                      decoration: BoxDecoration(
                       gradient: LinearGradient(
                        colors : const [Colors.black54, Colors.black87],
                          stops :const [0.0, 1.0],

                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Center(child: CircularProgressIndicator()));
                  }

                  return PostReel(
                    reel: item.post,
                    controller: item.controller!,
                  );
                },
              );
            },
            error: (e, _) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  VideoBackground(),
                  AppErrorWidget(
                    textColor: Colors.white,
                    errorText: e.toString(),
                    asyncValue: asyncItems,
                    onRetry: () {
                      ref.invalidate(fypProvider);
                    },
                  ),
                ],
              );
            },
            loading: () {
              return Stack(
                fit: StackFit.expand,
                children: [
                  VideoBackground(),
                  Center(child: CircularProgressIndicator()),
                ],
              );
            },
          ),

          // /// tab section
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Padding(
              padding: EdgeInsets.only(top: 60.h),
              child: HomeTab(
                active: context.colorScheme.surface.withValues(alpha: .7),
                inactive: context.colorScheme.surface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
