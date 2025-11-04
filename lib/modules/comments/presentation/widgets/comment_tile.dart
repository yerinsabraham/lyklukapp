import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/shared_widget.dart';
import 'package:lykluk/modules/comments/presentation/view_model/notifiers/comment_notifier.dart';
import 'package:lykluk/modules/comments/presentation/view_model/providers/replies_provider.dart';
import 'package:lykluk/modules/comments/presentation/widgets/reply_tile.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/theme/theme.dart';

import '../../data/model/comment_model.dart';

class CommentTile extends HookConsumerWidget {
  final CommentModel comment;
  final Function(CommentModel)? onReply;
  const CommentTile({super.key, required this.comment, this.onReply});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showReplies = useState(false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileAvatar(
          isProfile: true,
          imageUrl: comment.avatarUrl,
          radius: 22,
          placeholderValue:
              comment.user?.username.substring(1, 3).toUpperCase(),
        ),

        10.sW,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap:(){
                showReplies.value = false;
              },
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: context.width * 0.7),
                child: Text(
                  comment.header,
                  style: context.body14.copyWith(
                    color: context.colorScheme.inversePrimary,
                  ),
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: context.width * 0.7),
              child: Text(
                comment.comment?.capitalize ?? "",
                style: context.body14Light,
              ),
            ),
            // 10.sH,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    // isReplying.value =!isReplying.value;
                    // onReply?.call(isReplying.value, comment.id.toString());
                    onReply?.call(comment);
                  },
                  child: Text(
                    'Reply',
                    style: context.body14Light.copyWith(fontSize: 12.sp),
                  ),
                ),
                // Spacer(),
                (context.width * 0.58).sW,
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        ref
                            .read(commentNotifierProvider.notifier)
                            .likeComment(comment: comment);
                      },
                      child:
                          comment.isLiked
                              ? Icon(
                                Icons.favorite_rounded,
                                size: 16.sp,
                                color: Colors.red,
                              )
                              : Icon(
                                Icons.favorite_outline_rounded,
                                size: 16.sp,
                              ),
                    ),
                    Text(
                      comment.count.commentLikes.toString(),
                      style: context.body12,
                    ),
                  ],
                ),
              ],
            ),
            Visibility(
              visible: comment.count.replyFrom > 0 && !showReplies.value,
              child: GestureDetector(
                onTap: () {
                  showReplies.value = !showReplies.value;
                },
                child: Text.rich(
                  TextSpan(
                    text:
                        "---View ${comment.count.replyFrom.pluralize("reply", "replies")}",
                    style: context.body14Light.copyWith(fontSize: 12.sp),
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Color(AppColors.greyColor),
                          size: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        
            /// replies list
            Visibility(
              visible: comment.count.replyFrom > 0 && showReplies.value,
              child: ReplyList(comment: comment, onReply: onReply),
            ),
          ],
        ),
      ],
    );
  }
}

class ReplyList extends HookConsumerWidget {
  final CommentModel comment;
  final Function(CommentModel)? onReply;
  const ReplyList({super.key, required this.comment, this.onReply});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final param = (
      commentId: comment.id.toString(),
      videoId: comment.videoId.toString(),
    );
    final asyncItems = ref.watch(repliesProvider(param));
    final notifier = ref.read(repliesProvider(param).notifier);
    // final scrollController = usePagination(
    //   notifier.loadMore,
    //   notifier.canLoadMore,
    // );

    return asyncItems.when(
      error: (e, _) {
        return AppErrorWidget(
          errorText: e.toString(),
          asyncValue: asyncItems,
          onRetry: () => ref.invalidate(repliesProvider(param)),
        );
      },
      loading:
          () => Center(child: LoadingWithText(text: 'Loading comments...')),
      data: (data) {
        if (data.dataList.isEmpty) {
          return Center(child: Text('No comments yet', style: context.body14));
        }
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            // borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.r)),
          ),
          child: RefreshIndicator(
            onRefresh: () => ref.refresh(repliesProvider(param).future),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                data.isCompleted
                    ? data.dataList.length + 1
                    : data.dataList.length,
                (i) {
                  if (i == data.dataList.length) {
                    return GestureDetector(
                      onTap: () => notifier.loadMore(),
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: Text(
                          'Load more replies...',
                          style: context.body12.copyWith(color: Colors.blue),
                        ),
                      ),
                    );
                  }
                  final comment = data.dataList[i];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: ReplyTile(comment: comment, onReply: onReply),
                  );
                },
              ),
            ),
            // child: ListView.separated(
            //   padding: EdgeInsets.only(top:10.h),
            //   separatorBuilder: (c, i) => 10.sH,
            //   controller: scrollController,
            //   itemCount: data.dataList.length + 1,
            //   itemBuilder: (c, i) {
            //     if (i == data.dataList.length) {
            //       return BottomLoader(
            //         isLoading: asyncItems.isLoading && asyncItems.hasValue,
            //       );
            //     } else {
            //       final comment = data.dataList[i];
            //       return ReplyTile(comment: comment, onReply: onReply);
            //     }
            //   },
            // ),
          ),
        );
      },
    );
  }
}
