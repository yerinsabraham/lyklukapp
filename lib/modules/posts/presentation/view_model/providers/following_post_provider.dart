import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/comments/presentation/view_model/notifiers/comment_notifier.dart';
import 'package:lykluk/modules/posts/domain/repo/post_repo.dart';
import 'package:lykluk/utils/pagination/cursor_pagination.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/services/services.dart';
import '../../../data/impl/post_repo_impl.dart';
import 'posts_provider.dart';





final followingPostsProvider = AsyncNotifierProvider<
  NewVideoNotifier,
  CursorPaginatedResponse<VideoItemVM>
>(NewVideoNotifier.new);

class FollowingPostsNotifier
    extends AsyncNotifier<CursorPaginatedResponse<VideoItemVM>>
    with CursorPaginationController<VideoItemVM> {
  late PostRepository _postRepository;

  @override
  FutureOr<CursorPaginatedResponse<VideoItemVM>> build() async {
    _postRepository = ref.read(postRepoProvider);
    onAuthStateChanged();
    onNetworkStateChanged();
    onCommentUpdate();
    onVideoUpdate();
    return loadData(CursorPaginatedRequest());
  }

  Future<void> _initController(List<VideoItemVM> items, int index) async {
    final item = items[index];
    if (item.initialized) return;

    try {
      // File file = await DefaultCacheManager().getSingleFile(item.post.url);
      // final controller = VideoPlayerController.file(file);
      final controller = VideoPlayerController.networkUrl(
        Uri.parse(item.post.outputKey?? ""),
      );
      await controller.initialize();
      controller.setLooping(true);

      item.controller = controller;
      item.initialized = true;

      /// play the first video
      // if (index == 0) {
      //   controller.play();
      // }

      // Trigger rebuild
      final newState = state.requireValue.copyWith(dataList: [...items]);
      state = AsyncData(newState);
    } catch (e, s) {
      // keep uninitialized
      LoggerService.logError(
        error: e.toString(),
        stackTrace: s,
        reason: 'VideoController initialization failed',
      );
    }
  }

  // Future<void> loadMore() async {
  //   final newList = await _fetchAndPrepare();
  //   state = AsyncData(newList);
  // }

  Future<void> handleScroll(int index) async {
    final items = state.value?.dataList ?? [];

    if (index >= items.length) return;

    // --- Play current ---
    // --- Ensure current is initialized ---
    final current = items[index];
    if (current.controller == null) {
      await _initController(items, index);
    }

    // --- Play only the current ---
    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      if (item.controller != null) {
        if (i == index) {
          item.controller!.play();
        } else {
          item.controller!.pause();
        }
      }
    }

    // --- Preload neighbors (both directions) ---
    if (index + 1 < items.length) {
      _initController(items, index + 1);
    }
    if (index - 1 >= 0) {
      _initController(items, index - 1);
    }

    // --- Dispose far away items ---
    if (index - 2 >= 0 && items[index - 2].controller != null) {
      items[index - 2].controller!.dispose();
      items[index - 2].controller = null;
      items[index - 2].initialized = false;
    }
    if (index + 2 < items.length && items[index + 2].controller != null) {
      items[index + 2].controller!.dispose();
      items[index + 2].controller = null;
      items[index + 2].initialized = false;
    }
    final newState = state.requireValue.copyWith(dataList: [...items]);
    state = AsyncData(newState);
  }

  @override
  FutureOr<CursorPaginatedResponse<VideoItemVM>> loadData(
    CursorPaginatedRequest request,
  ) async {
    try {
      // final videos = await _getVideos(page: _page, limit: _limit);
      final res = await _postRepository.getFollowingPosts(
        query: CursorPaginatedRequest().toJson(),
      );

      return res.fold(
        (l) {
          return Future.error(l.message);
        },
        (r) {
          final videos = r.data.dataList;
          // if (videos.length < _limit) _hasMore = false;
          final current = state.value?.dataList ?? [];
          // Wrap into VideoItemVM
          final newItems = videos.map((v) => VideoItemVM(post: v)).toList();
          final merged = [...current, ...newItems];

          // Preload first two controllers
          for (
            int i = current.length;
            i < merged.length && i < current.length + 2;
            i++
          ) {
            _initController(merged, i);
          }

          return CursorPaginatedResponse(
            dataList: merged,
            totalItems: r.data.totalItems,
            cursor: r.data.cursor,
            stop: r.data.stop,
            extraMap: r.data.extraMap,
            keyword: r.data.keyword,
          );
          // return r.data.copyWith(dataList: merged)
        },
      );
    } catch (e) {
      log.e(e);
      return Future.error(e.toString());
    }
  }

  /// onvideo update
  void onVideoUpdate() {
    _postRepository.onPostUpdate().listen((d) {
      try {
        addBottom(VideoItemVM(post: d, controller: null, initialized: false));
      } catch (e) {
        log.e(e);
      }
    });
  }

  void onCommentUpdate() {
    ref.listen(commentNotifierProvider, (p, n) {
      n.maybeWhen(
        orElse: () {},
        sent: (message, comment) {
          findAndUpdate(
            where: (item) => item.post.id == comment.videoId,
            update: (e) {
              return e.copyWith(
                post: e.post.copyWith(
                  count: e.post.count.copyWith(
                    comments: e.post.count.comments + 1,
                  ),
                ),
              );
            },
          );
        },
      );
    });
  }
}
