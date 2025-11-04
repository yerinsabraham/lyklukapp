import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/comments/domain/repo/comment_repository.dart';
import 'package:lykluk/modules/comments/presentation/view_model/state/comment_state.dart';
import 'package:lykluk/utils/storage/local_storage.dart';

import '../../../../../core/services/services.dart';
import '../../../data/impl/comment_repo_impl.dart';
import '../../../data/model/comment_model.dart';

final commentNotifierProvider = NotifierProvider<CommentNotifier, CommentState>(
  CommentNotifier.new,
);

class CommentNotifier extends Notifier<CommentState> {
  late CommentRepository _commentRepository;
  @override
  build() {
    _commentRepository = ref.read(commentRepoProvider);
    return CommentStateInitial();
  }

  void sendComment(String comment, String videoId) async {
    try {
      state = SendingComment();
      final result = await _commentRepository.sendComment(
        data: {'comment': comment},
        videoId: videoId,
      );
      result.fold(
        (l) {
          state = SendingCommentFailed(message: l.message);
        },
        (r) {
          state = SentComment(message: r.message, comment: r.data);
        },
      );
    } catch (e) {
      log.e(e.toString());
      state = SendingCommentFailed(message: e.toString());
    }
  }

  void likeComment({required CommentModel comment}) async {
    try {
    if(comment.isLiked){
         state = LikeSucess(
          message: 'Undo comment like',
          comment: comment.copyWith(
            commentLikes:
                comment.commentLikes
                    .where(
                      (e) => e.user?.username != HiveStorage.getUser.username,
                    )
                    .toList(),
            count: comment.count.copyWith(
              commentLikes: comment.count.commentLikes - 1,
            ),
          ),
        );
    }else{
        state = LikeSucess(
          message: 'Comment liked',
          comment: comment.copyWith(
            commentLikes: [
              ...comment.commentLikes,
              CommentLike(user: HiveStorage.getUser),
            ],
            count: comment.count.copyWith(
              commentLikes: comment.count.commentLikes + 1,
            ),
          ),
        );
    }
      
      final result = await _commentRepository.likeComment(
        commentId: comment.id.toString(),
      );
      result.fold(
        (l) {
          state = LikeFailed(message: l.message, comment: comment);
        },
        (r) {
          // state = SentComment(message: r.message, comment: r.data);
        },
      );
    } catch (e) {
      log.e(e.toString());
      state = LikeFailed(message: e.toString(), comment: comment);
    }
  }

  void replyToComment(String commentId, String videoId, String comment)async {
   try {
      state = ReplyingComment();
      final result = await _commentRepository.replyToComment(
        data: {'comment': comment},
        videoId: videoId,
        commentId: commentId
      );
      result.fold(
        (l) {
          state = ReplyingCommentFailed(message: l.message);
        },
        (r) {
          state = RepliedComment(message: r.message, comment: r.data, replyToId: commentId);
        },
      );
    } catch (e) {
      log.e(e.toString());
      state = ReplyingCommentFailed(message: e.toString());
    }
  }

  void deleteComment(String commentId) {}
}
