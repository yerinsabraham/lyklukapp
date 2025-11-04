import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/comments/data/model/comment_model.dart';
import 'package:lykluk/modules/comments/domain/repo/comment_repository.dart';
import 'package:lykluk/modules/comments/presentation/view_model/notifiers/comment_notifier.dart';
import 'package:lykluk/utils/pagination/pagination.dart';
import '../../../../../core/services/services.dart';
import '../../../data/impl/comment_repo_impl.dart';

// class CommentsProvider extends AsyncNotifier<PaginatedResponse<CommentModel>> with PaginationController<CommentModel> {
//   @override
//   FutureOr<PaginatedResponse<CommentModel>> build() {
//     return loadData(PaginatedRequest());
//   }

//   @override
//   FutureOr<PaginatedResponse<CommentModel>> loadData(PaginatedRequest request) {

//     throw UnimplementedError();
//   }
// }

final commentsProvider = AsyncNotifierProviderFamily< CommentListNotifier,PaginatedResponse<CommentModel>,String>(CommentListNotifier.new);

class CommentListNotifier extends FamilyAsyncNotifier<PaginatedResponse<CommentModel>, String>
    with PaginationController<CommentModel> {
  late CommentRepository commentRepository;
  @override
  FutureOr<PaginatedResponse<CommentModel>> build(arg) {
    commentRepository = ref.read(commentRepoProvider);
    onAuthStateChanged();
    onNetworkStateChanged();
    onCommentUpdate();
    onCommentChanges();
    return loadData(PaginatedRequest(page: 1, limit: 20));
  }

  @override
  FutureOr<PaginatedResponse<CommentModel>> loadData(
    PaginatedRequest request,
  ) async {
    try {
      final res = await commentRepository.getComments(
        query: request.toJson(),
        videoId: arg,
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
  
  /// on comment update
  void onCommentUpdate() {
    ref.watch(commentRepoProvider).onCommentUpdate().listen((d) {
      try {
        if (arg == d.videoId.toString()) addTop(d);
      } catch (e) {
        log.e(e);
      }
    });
  }

  void onCommentChanges() {
    ref.listen(commentNotifierProvider, (p, n) {
      n.maybeWhen(
        orElse: () {},
        sent: (message, comment) {
          if (arg == comment.videoId.toString()) addTop(comment);
        },
        likeSucess: (message, comment) {
          if (arg == comment.videoId.toString()) {
            findAndReplace(model: comment, test: (cm) => cm.id == comment.id);
          }
        },
        likeFailed: (message, comment) {
          if (arg == comment.videoId.toString()) {
            findAndReplace(model: comment, test: (cm) => cm.id == comment.id);
          }
        },
        replied: (msg, comment, replyId) {
          if (arg == comment.videoId.toString()) {
            findAndUpdate(
              where: (e) => e.id.toString() == replyId,
              update: (e)=> e.copyWith(count: e.count.copyWith(replyFrom: e.count.replyFrom + 1)),
            );
          }
        },
      );
    });
  }
}
