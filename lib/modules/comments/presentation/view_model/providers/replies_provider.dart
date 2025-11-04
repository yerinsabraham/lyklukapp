import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/comments/data/model/comment_model.dart';
import 'package:lykluk/modules/comments/domain/repo/comment_repository.dart';
import 'package:lykluk/modules/comments/presentation/view_model/notifiers/comment_notifier.dart';
import 'package:lykluk/utils/pagination/pagination.dart';
import '../../../../../core/services/services.dart';
import '../../../data/impl/comment_repo_impl.dart';

typedef ReplyParam = ({String commentId, String videoId});

final repliesProvider = AsyncNotifierProviderFamily<
  RepliesNotifier,
  PaginatedResponse<CommentModel>,
  ReplyParam
>(RepliesNotifier.new);

class RepliesNotifier
    extends FamilyAsyncNotifier<PaginatedResponse<CommentModel>, ReplyParam>
    with PaginationController<CommentModel> {
  late CommentRepository commentRepository;
  @override
  FutureOr<PaginatedResponse<CommentModel>> build(arg) {
    commentRepository = ref.read(commentRepoProvider);
    onAuthStateChanged();
    onNetworkStateChanged();
  
    onCommentChanges();
    return loadData(PaginatedRequest(page: 1, limit: 20));
  }

  @override
  FutureOr<PaginatedResponse<CommentModel>> loadData(
    PaginatedRequest request,
  ) async {
    try {
      final res = await commentRepository.getReplies(
        commentId: arg.commentId,
        query: request.toJson(),
        videoId: arg.videoId,
      );
      return res.fold(
        (l) {
          return Future.error(l.message);
        },
        (r) {
          return r.data;
        },
      );
    } catch (e) {
      log.d(e.toString());
      return Future.error(e.toString());
    }
  }


  void onCommentChanges() {
    ref.listen(commentNotifierProvider, (p, n) {
      n.maybeWhen(
        orElse: () {},
        replied: (message, comment, replyId) {
          if (arg.commentId == replyId) addTop(comment);
        },
      );
    });
  }
}
