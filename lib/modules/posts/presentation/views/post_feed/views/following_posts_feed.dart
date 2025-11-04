import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
 
import '../../../../../../../core/shared/widgets/shared_widget.dart';
import '../../../../../../utils/hooks/scroll_hook.dart';
import '../../../../../home/presentation/widgets/home_tab.dart';
import '../../../view_model/providers/following_post_provider.dart';
import '../widgets/post_feed.dart';
import '../widgets/video_background.dart';

 
class FollowingPostsFeed extends HookConsumerWidget {
  const FollowingPostsFeed({super.key});
 
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItems = ref.watch(followingPostsProvider);
    final notifier = ref.watch(followingPostsProvider.notifier);
 
    final pageController = usePagePagination(
      notifier.loadMore,
      notifier.canLoadMore,
    );
 
    return RefreshIndicator(
      onRefresh: () => ref.refresh(followingPostsProvider.future),
      child: Stack(
        children: [
          // VideoFeedView(),
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
              return PageView.builder(
                controller: pageController,
                scrollDirection: Axis.vertical,
                physics: const PageScrollPhysics(),
                itemCount: reels.dataList.length,
                onPageChanged: (index) {
                  notifier.handleScroll(index);
 
                  // if (index >= reels.dataList.length - 2) {
                  //   notifier.loadMore();
                  // }
                },
                itemBuilder: (context, index) {
                  final item = reels.dataList[index];
 
                  if (!item.initialized || item.controller == null) {
                    // show a stable placeholder (keeps layout stable) while controller initializes
                    return Container(
                      height: context.height,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: const [Colors.black54, Colors.black87],
                          stops: const [0.0, 1.0],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          VideoBackground(),
                          // overlay a subtle loader so users know it's loading
                          const Center(child: CircularProgressIndicator()),
                        ],
                      ),
                    );
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
                      ref.invalidate(followingPostsProvider);
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
