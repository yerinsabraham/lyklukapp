import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/comments/presentation/view_model/notifiers/comment_notifier.dart';

import 'package:lykluk/utils/pagination/cursor_pagination.dart';
import '../../../../core/services/services.dart';
import '../../../posts/data/impl/post_repo_impl.dart';
import '../../../posts/data/model/post_model.dart';
import '../../../posts/domain/repo/post_repo.dart';
import '../../../posts/presentation/view_model/notifiers/post_notifier.dart';



final followingVideosProvider = AsyncNotifierProvider<
  FollowingVideoListNotifier,
  CursorPaginatedResponse<PostModel>
>(FollowingVideoListNotifier.new);

class FollowingVideoListNotifier
    extends AsyncNotifier<CursorPaginatedResponse<PostModel>>
    with CursorPaginationController<PostModel> {
  late PostRepository postRepository;
  @override
  FutureOr<CursorPaginatedResponse<PostModel>> build() {
    postRepository = ref.read(postRepoProvider);
    onAuthStateChanged();
    onNetworkStateChanged();
    onVideoUpdate();
    onCommentUpdate();
    onVideoActions();
    return loadData(CursorPaginatedRequest());
  }

  @override
  FutureOr<CursorPaginatedResponse<PostModel>> loadData(
    CursorPaginatedRequest request,
  ) async {
    try {
      final res = await postRepository.getFollowingPosts(
        query: request.toJson(),
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

  /// onvideo update
  void onVideoUpdate() {
   postRepository.onPostUpdate().listen((d) {
      try {
        addTop(d);
      } catch (e) {
        log.e(e);
      }
    });
  }

  void onVideoActions() {
    ref.listen(postNotifierProvider, (p, n) {
      n.maybeWhen(
        orElse: () {},
        liked: (video) {
          findAndUpdate(
            where: (item) => item.id == video.id,
            update: (e) {
              return e.copyWith(
                count: e.count.copyWith(videoLikes: e.count.videoLikes + 1),
              );
            },
          );
        },
        unliked: (video) {
          findAndUpdate(
            where: (item) => item.id == video.id,
            update: (e) {
              return e.copyWith(
                count: e.count.copyWith(videoLikes: e.count.videoLikes - 1),
              );
            },
          );
        },
      );
    });
  }

  void onCommentUpdate() {
    ref.listen(commentNotifierProvider, (p, n) {
      n.maybeWhen(
        orElse: () {},
        sent: (message, comment) {
          findAndUpdate(
            where: (item) => item.id == comment.videoId,
            update: (e) {
              return e.copyWith(
                count: e.count.copyWith(comments: e.count.comments + 1),
              );
            },
          );
        },
      );
    });
  }
}
