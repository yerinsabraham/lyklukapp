import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/shared_widget.dart';
import 'package:lykluk/modules/profile/presentation/view_model/providers/profile_posts_provider.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/helpers/empty_widget.dart';
import 'package:lykluk/utils/hooks/scroll_hook.dart';
import 'package:lykluk/utils/router/app_router.dart';

import '../../../../posts/data/model/post_model.dart';

class ProfilePosts extends HookConsumerWidget {
  final String userId;
  const ProfilePosts({super.key, required this.userId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItems = ref.watch(profilePostsProvider(userId));
    final notifier = ref.read(profilePostsProvider(userId).notifier);
    final controller = usePagination(notifier.loadMore, notifier.canLoadMore);
    return SliverFillRemaining(
      child: RefreshIndicator(
        onRefresh: () => ref.read(profilePostsProvider(userId).future),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.colorScheme.surface.withValues(alpha: 0.8),
          ),
          child: Column(
            children: [
              Expanded(
                child: asyncItems.when(
                  error: (e, s) {
                    return AppErrorWidget(
                      errorText: e.toString(),
                      asyncValue: asyncItems,
                      onRetry: () {
                        ref.invalidate(profilePostsProvider);
                      },
                    );
                  },
                  loading:
                      () => Center(child: CircularProgressIndicator.adaptive()),
                  data: (videos) {
                    if (videos.dataList.isEmpty) {
                      return EmptyWidget(
                        title: Image.asset(ImageAssets.emptyVideosImage),
                        subTitle: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Share some cultural \ncontent to the world!',
                                style: context.body16Bold.copyWith(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              20.sH,
                              CustomButton(
                                width: 150.w,
                                height: 50.h,
                                onTap: () {
                                  context.pushNamed(Routes.postRecordRoute);
                                },
                                buttonText: "Upload",
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                      ).copyWith(top: 10.h),
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        controller: controller,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 3.w,
                          mainAxisSpacing: 2.h,
                          childAspectRatio: 3.2 / 5,
                        ),
                        itemCount: videos.dataList.length,
                        itemBuilder: (c, i) {
                          // final post = i.isEven ? ImageAssets.post3mage : ImageAssets.post4mage;
                          final post = videos.dataList[i];
                          return ProfilePostTile(post: post);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePostTile extends HookConsumerWidget {
  final double? height;
  final double? width;
  final PostModel post;
  const ProfilePostTile({
    super.key,
    required this.post,
    this.height,
    this.width,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usePlaceholder = useState(false);
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.postViewRoute, extra: post);
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          image:
              post.thumbNailUrl.isEmpty || usePlaceholder.value
                  ? DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage(ImageAssets.emptyVideosImage),
                  )
                  : DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                      errorListener: (v) {
                        // print("Error loading image, using placeholder");
                        if (context.mounted) {
                        usePlaceholder.value = true;

                        }
                      },
                      post.thumbNailUrl,
                    ),
                  ),
          // image: DecorationImage(fit: BoxFit.cover, image: AssetImage(ImageAssets.post1mage)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
              child: Row(
                children: [
                  SvgPicture.asset(IconAssets.viewcountIcon),
                  5.sW,
                  Text(
                    // '10.8M',
                    post.count.videoViews.toString(),
                    style: context.body12.copyWith(
                      color: context.colorScheme.surface,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
