// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/bottom_loader.dart';
import 'package:lykluk/modules/comments/presentation/view_model/notifiers/comment_notifier.dart';
import 'package:lykluk/modules/comments/presentation/widgets/comment_tile.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/helpers/toast_notification.dart';
import 'package:lykluk/utils/hooks/scroll_hook.dart';
import 'package:video_player/video_player.dart';

import '../../../core/shared/widgets/shared_widget.dart';
import '../../posts/data/model/post_model.dart';
import '../data/model/comment_model.dart';
import 'view_model/providers/comments_provider.dart';
import 'view_model/state/comment_state.dart';

class CommentView extends HookConsumerWidget {
  final PostModel reel;
  final VideoPlayerController videoController;
  const CommentView({
    super.key,
    required this.reel,
    required this.videoController,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    // final isReplying = useState(false);
    final selectedComment = useState<CommentModel?>(null);
    ref.listen(commentNotifierProvider, (p, n) {
      n.maybeWhen(
        orElse: () {},
        sent: (m, v) {
          textController.clear();
        },
        sendingFailed: (m) {
          ToastNotification.showCustomNotification(
            title: "Alert",
            subtitle: m,
            isSuccess: false,
          );
        },
        replied: (m, v, id) {
          textController.clear();
          selectedComment.value = null;
        },
        replyingCommentFailed: (m) {
          ToastNotification.showCustomNotification(
            title: "Alert",
            subtitle: m,
            isSuccess: false,
          );
        },
        likeFailed: (message, comment) {
          ToastNotification.showCustomNotification(
            title: "Alert",
            subtitle: message,
            isSuccess: false,
          );
        },
      );
    });

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.h).copyWith(bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // thumnail section,
          Center(
            child: GestureDetector(
              onTap: () {
                if (videoController.value.isPlaying) {
                  videoController.pause();
                } else {
                  videoController.play();
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox(
                    height: 170.h,
                    width: context.width * 0.5,
                    child: VideoPlayer(videoController),
                  ),
                ),
              ),
            ),
          ),
          10.sH,
          Center(
            child: Text(
              // '${reel.count.comments} Comments',
              reel.count.comments.pluralize('Comment', 'Comments'),
              style: context.body14Bold,
            ),
          ),
          10.sH,
          Container(
            // color: context.colorScheme.surface,
            width: context.width,
            padding: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 8.h,
                  width: 70.w,
                  decoration: BoxDecoration(
                    color: context.colorScheme.onSecondary.withValues(
                      alpha: 0.2,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ],
            ),
          ),
          CommentList(
            videoId: reel.id,
            onReply: (comment) {
              selectedComment.value =comment;
            },
          ),

          Container(
            decoration: BoxDecoration(color: context.colorScheme.surface),
            child: Padding(
              padding: EdgeInsets.only(
                top: 5.h,
                left: 14.w,
                right: 14.w,
                bottom: 20.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Visibility(
                  //   visible: selectedComment.value != null,
                  //   replacement: SizedBox.shrink(),
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
                  //     width: double.infinity,
                  //     decoration: BoxDecoration(
                  //       color: context.colorScheme.onSecondary.withValues(alpha: 0.1),
                  //       borderRadius: BorderRadius.vertical(top: Radius.circular(10.r )),
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text(
                  //           'Reply to ${selectedComment.value?.user?.username}',
                  //           style: context.body14Bold,
                  //         ),
                  //         GestureDetector(
                  //           onTap: () {
                  //             selectedComment.value = null;
                  //           },
                  //           child: Icon(Icons.close, size: 20.w),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 80.h,
                      // maxWidth: context.width * 0.8,
                    ),
                    child: CustomField(
                      preffixWidget: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ProfileCircularAvatar(size: 7),
                      ),
                      controller: textController,
                      borderRadius: 30.r,
                      borderRadiusStyle: selectedComment.value != null? BorderRadius.vertical(bottom: Radius.circular(20.r)):null,
                      fillColor: context.colorScheme.onSecondary.withValues(
                        alpha: 0.03,
                      ),
                      // maxLines: 3,
                      keyboardType: TextInputType.multiline ,
                      borderColor: context.colorScheme.surface,
                      hintText: selectedComment.value != null ? "Send a reply" : 'Add a comment',
                      hintTextStyle: context.body14.copyWith(
                        color: context.colorScheme.onSecondary,
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      suffixWidget: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ValueListenableBuilder(
                          valueListenable: textController,
                          builder: (context,v,__) {
                            return CommentSendButton(
                              selectedComment: selectedComment.value,
                              comment: textController.text,
                              videoId: reel.id.toString(),
                           
                            );
                          }
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CommentSendButton extends HookConsumerWidget {
  final String comment;
  final String videoId;
  // final bool isReplying;
  final CommentModel? selectedComment;
  const CommentSendButton({
    super.key,
    required this.comment,
    required this.videoId,
    // this.isReplying = false,
    this.selectedComment,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading =
        ref.watch(commentNotifierProvider) is SendingComment ||
        ref.watch(commentNotifierProvider) is ReplyingComment;
    return isLoading
        ? SizedBox(
          height: 15,
          width: 15,
          child: Center(
            child: CircularProgressIndicator(
              color: context.colorScheme.primary,
            ),
          ),
        )
        : GestureDetector(
          onTap:
              selectedComment !=null
                  ? () {
                    // print("send - $comment to $videoId - $selectedCommentId" );
                    if (comment.isEmpty) return;

                    ref
                        .read(commentNotifierProvider.notifier)
                        .replyToComment(selectedComment!.id.toString(), videoId, comment);
                  }
                  : () {
                    if (comment.isEmpty) return;

                    ref
                        .read(commentNotifierProvider.notifier)
                        .sendComment(comment, videoId);
                  },
          child: SvgPicture.asset(
            IconAssets.sendIcon,
            color: context.colorScheme.primary,
          ),
        );
  }
}

class CommentList extends HookConsumerWidget {
  final int videoId;
  final Function(CommentModel?)? onReply;
  const CommentList({super.key, required this.videoId, this.onReply});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItems = ref.watch(commentsProvider(videoId.toString()));
    final notifier = ref.read(commentsProvider(videoId.toString()).notifier);
    final scrollController = usePagination(
      notifier.loadMore,
      notifier.canLoadMore,
    );

    return asyncItems.when(
      error: (e, _) {
        return Expanded(
          child: AppErrorWidget(
            errorText: e.toString(),
            asyncValue: asyncItems,
            onRetry: () => ref.invalidate(commentsProvider(videoId.toString())),
          ),
        );
      },
      loading:
          () => Expanded(
            child: Center(child: LoadingWithText(text: 'Loading comments...')),
          ),
      data: (data) {
        if (data.dataList.isEmpty) {
          return Expanded(
            child: Center(
              child: Text('No comments yet', style: context.body14),
            ),
          );
        }
        return Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              // borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.r)),
            ),
            child: RefreshIndicator(
              onRefresh:
                  () =>
                      ref.refresh(commentsProvider(videoId.toString()).future),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                separatorBuilder: (c,i) => 10.sH,
                controller: scrollController,
                itemCount: data.dataList.length + 1,
                itemBuilder: (c, i) {
                  if (i == data.dataList.length) {
                    return BottomLoader(
                      isLoading: asyncItems.isLoading && asyncItems.hasValue,
                    );
                  } else {
                    final comment = data.dataList[i];
                    return CommentTile(comment: comment, onReply: onReply);
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
