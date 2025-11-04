import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/model/profile_model.dart';
import 'package:lykluk/modules/comments/presentation/comment_view.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:video_player/video_player.dart';
import '../../../../../../core/shared/providers/auth_status_provider.dart';
import '../../../../../../core/shared/widgets/shared_widget.dart';
import '../../../../../../utils/assets_manager.dart';
import '../../../../../../utils/helpers/show_sheet.dart';
import '../../../../data/model/post_model.dart';
import '../../../view_model/notifiers/post_notifier.dart';
import 'post_action_sheet.dart';
import 'video_background.dart';


class FeedActions extends HookConsumerWidget {
  final PostModel post;
  final VideoPlayerController controller;
  const FeedActions({super.key, required this.post, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            if (!authState) {
              showAuthSheet(context);
              return;
            }
            ref.read(postNotifierProvider.notifier).savePost(post: post);
          },
          child:
              post.isSaved
                  ? Icon(
                    Icons.bookmark,
                    color: context.colorScheme.primary,
                    size: 32.r,
                  )
                  : SvgPicture.asset(IconAssets.bookmarkIcon),
        ),
        20.sH,
        GestureDetector(
          onTap: () {
            if (!authState) {
              showAuthSheet(context);
              return;
            }
            ref.read(postNotifierProvider.notifier).likePost(post: post);
          },
          child:
              post.isLiked
                  ? SvgPicture.asset(IconAssets.loveIcon)
                  : Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.white,
                    size: 24.r,
                  ),
        ),
        20.sH,
        GestureDetector(
          onTap: () {
            if (!authState) {
              showAuthSheet(context);
              return;
            }
            _showCommentSection(context: context, reel: post);
          },
          child: SvgPicture.asset(IconAssets.commentChatIcon),
        ),
        20.sH,
        GestureDetector(
          onTap: () {},
          child: SvgPicture.asset(IconAssets.sendWhiteIcon),
        ),
        20.sH,
        GestureDetector(
          onTap: () {
            if (!authState) {
              showAuthSheet(context);
              return;
            }
            _showOptions(context: context, reel: post);
          },
          child: SvgPicture.asset(IconAssets.moreBlurIcon),
        ),
      ],
    );
  }

  void _showCommentSection({
    required BuildContext context,
    required PostModel reel,
  }) async {
    await showSheet(
      context,
      child: CommentView(reel: reel, videoController: controller),
      isScrollControlled: true,
      maxHeight: context.height,
      showDragHandle: false,
    );
  }

  void _showOptions({
    required BuildContext context,
    required PostModel reel,
  }) async {
    await showSheet(
      context,
      isScrollControlled: true,
      showDragHandle: false,
      scrollControlDisabledMaxHeightRatio: 1,
      child: PostActionSheet(post: reel),
    );
  }
}

class FeedDetails extends HookConsumerWidget {
  final PostModel video;
  const FeedDetails({super.key, required this.video});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(left: 14.w),
      child: GestureDetector(
        onTap: () {
          // context.pushNamed(Routes.otherUserProfileRoute, extra: video.user.);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ProfileAvatar(
                  imageUrl: video.user?.profile?.proflleImageUrl,
                  radius: 20,
                  placeholderValue:
                      video.user?.username?.substring(1, 3).toUpperCase(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: context.width * 0.3,
                        ),
                        child: Text(
                          video.availableName.capitalize,
                          style: context.body16.copyWith(
                            color: context.colorScheme.surface,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      5.sH,
                      Text(
                        video.timeAt,
                        style: context.body14Light.copyWith(
                          color: context.colorScheme.surface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Connect',
                    style: context.body14.copyWith(
                      color: context.colorScheme.surface,
                    ),
                  ),
                ),
              ],
            ),

            20.sH,
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: context.width * 0.8),
              child: Text(
                video.description ?? "",

                style: context.body16.copyWith(
                  color: context.colorScheme.surface,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // VideoProgress()
          ],
        ),
      ),
    );
  }
}

class PostReel extends HookConsumerWidget {
  final PostModel reel;
  final VideoPlayerController controller;
  final bool allowTapToPause;

  const PostReel({
    super.key,
    required this.reel,
    required this.controller,
    this.allowTapToPause = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Expanded(
          // flex: 50,
          child: Container(
            width: 1.sw,
            // height: 0.75.sh,
            decoration: BoxDecoration(color: Colors.black),
            // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
            // margin: EdgeInsets.only(top: 60.h),
            child: Stack(
              fit: StackFit.expand,
              children: [
                //  Positioned(child: VideoProgress(), bottom: 0, left: 0, right: 0, ),
                GestureDetector(
                  onTap: () async {
                    if (controller.value.isPlaying) {
                      controller.pause();
                    } else {
                      controller.play();
                    }
                  },
                  child: VideoPlayerWidget(
                    controller: controller,
                    loadingWidget: Center(child: CircularProgressIndicator()),
                  ),
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(flex: 1, child: FeedDetails(video: reel)),
                          Expanded(
                            flex: 0,
                            child: FeedActions(
                              post: reel,
                              controller: controller,
                            ),
                          ),
                        ],
                      ),
                      10.sH,
                      //  // Slider styled as bottom border
                      VideoProgress(controller: controller),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // // Slider styled as bottom border
        // VideoProgress(controller: controller),
      ],
    );
  }
}

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;
  final String? thumbnailUrl;
  final Widget? loadingWidget;
  final Widget? errorWidget;

  const VideoPlayerWidget({
    super.key,
    required this.controller,
    this.thumbnailUrl,
    this.loadingWidget,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    // controller.play();
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, child) {
        if (value.isInitialized) {
          // final isPortrait = controller.value.size.height > controller.value.size.width;
        

          return Stack(
            fit: StackFit.expand,
            children: [
              FittedBox(
                // fit: isPortrait ? BoxFit.cover : BoxFit.contain, // or BoxFit.cover depending on design
                fit: BoxFit.cover ,
                child: SizedBox(
                  width: controller.value.size.width,
                  height: controller.value.size.height,
                  child: VideoPlayer(controller),
                ),
              ),
              //  Positioned(child: VideoProgress(), bottom: 0, left: 0, right: 0, )
            ],
          );
        } else if (value.hasError) {
          return errorWidget ??
              Stack(
                fit: StackFit.expand,
                children: [
                  VideoBackground(),
                  // Center(child: loadingWidget ?? CircularProgressIndicator()),
                  ErrorRefreshWidget(
                    errorTextColor: context.colorScheme.surface,
                    errorText: value.errorDescription ?? "",
                    isRefreshing: controller.value.isBuffering,
                    onRetry: () {
                      controller.initialize();
                    },
                  ),
                ],
              );
          // Center(child: Text('Error loading video', style: context.body16));
        } else {
          // debugPrint(
          //   'VideoPlayer is still initializing ... ${value.toString()}',
          // );
          return Stack(
            fit: StackFit.expand,
            children: [
              VideoBackground(),
              Center(child: loadingWidget ?? CircularProgressIndicator()),
            ],
          );
        }
      },
    );
  }
}

class VideoProgress extends HookConsumerWidget {
  final VideoPlayerController controller;
  const VideoProgress({super.key, required this.controller});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, _) {
        final seekValue =
            value.position.inSeconds.toDouble() /
            value.duration.inSeconds.toDouble();
        return SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 5,
            activeTrackColor: Colors.white,
            trackShape: RectangularSliderTrackShape(),
            inactiveTrackColor: Colors.grey.shade400,
            tickMarkShape: SliderTickMarkShape.noTickMark,
            thumbColor: Colors.white,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
          ),
          child: Slider(
            min: 0.0,
            max: 1.0,
            value: seekValue.isNaN ? 0.0 : seekValue,
            onChanged: (val) {},
          ),
        );
      },
    );
  }
}
