import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/shared_widget.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

import '../../data/model/comment_model.dart';

class ReplyTile extends HookConsumerWidget {
  final CommentModel comment;
  final Function(CommentModel)? onReply;
  const ReplyTile({super.key, required this.comment, this.onReply});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileAvatar(
          imageUrl: comment.avatarUrl,
          radius: 15,
          placeholderValue:
              comment.user?.username.substring(1, 3).toUpperCase(),
        ),
        5.sW,
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: context.width * 0.5),
              child: Text(
                comment.header2,
                style: context.body12.copyWith(
                  color: context.colorScheme.inversePrimary,
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: context.width * 0.55),
              child: Text(
                comment.comment?.capitalize ?? "",
                style: context.body12,
              ),
            ),
          ],
        ),
        // 5.sW,
        // Spacer(),
        // Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     GestureDetector(
        //       onTap: () {
        //         ref
        //             .read(commentNotifierProvider.notifier)
        //             .likeComment(comment: comment);
        //       },
        //       child:
        //           comment.isLiked
        //               ? Icon(
        //                 Icons.favorite_rounded,
        //                 size: 16.sp,
        //                 color: Colors.red,
        //               )
        //               : Icon(
        //                 Icons.favorite_outline_rounded,
        //                 size: 16.sp,
        //                 color: context.colorScheme.onSecondary,
        //               ),
        //     ),
        //     Text(comment.count.commentLikes.toString(), style: context.body12),
        //   ],
        // ),
      ],
      // contentPadding: EdgeInsets.zero,
      // visualDensity: VisualDensity(horizontal: -4, vertical: -4),
      // leading: ProfileAvatar(
      //     imageUrl: comment.avatarUrl,
      //     radius: 15,
      //     placeholderValue:
      //         comment.user?.username.substring(1, 3).toUpperCase(),
      //   ),

      // title:  ConstrainedBox(
      //         constraints: BoxConstraints(maxWidth: context.width * 0.5),
      //         child: Text(
      //           comment.header2,
      //           style: context.body14.copyWith(
      //             color: context.colorScheme.inversePrimary,
      //           ),
      //         ),
      //       ),
      // subtitle:  ConstrainedBox(
      //         constraints: BoxConstraints(maxWidth: context.width * 0.7),
      //         child: Text(
      //           comment.comment?.capitalize ?? "",
      //           style: context.body14Light,
      //         ),
      //       ),
      // trailing: Column(
      //   mainAxisSize: MainAxisSize.min,

      //   children: [
      //     GestureDetector(
      //       onTap: () {
      //         ref
      //             .read(commentNotifierProvider.notifier)
      //             .likeComment(comment: comment);
      //       },
      //       child:
      //           comment.isLiked
      //               ? Icon(
      //                 Icons.favorite_rounded,
      //                 size: 16.sp,
      //                 color: Colors.red,
      //               )
      //               : Icon(Icons.favorite_outline_rounded, size: 16.sp, color:context.colorScheme.onSecondary,),
      //     ),
      //     Text(comment.count.commentLikes.toString(), style: context.body12),
      //   ],
      // ),
    );
  }
}
