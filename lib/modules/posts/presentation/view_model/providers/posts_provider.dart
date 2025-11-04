// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'package:lykluk/modules/posts/presentation/view_model/notifiers/post_notifier.dart';
import 'package:lykluk/modules/comments/presentation/view_model/notifiers/comment_notifier.dart';
import 'package:lykluk/modules/posts/data/impl/post_repo_impl.dart';
import 'package:lykluk/utils/pagination/cursor_pagination.dart';
import '../../../../../core/services/services.dart';
import '../../../data/model/post_model.dart';
import '../../../domain/repo/post_repo.dart';

/// Single video item
class VideoItemVM {
  final PostModel post;
  VideoPlayerController? controller;
  bool initialized;
  bool isPlaying;

  VideoItemVM({
    required this.post,
    this.controller,
    this.initialized = false,
    this.isPlaying = false,
  });

  VideoItemVM copyWith({
    PostModel? post,
    VideoPlayerController? controller,
    bool? initialized,
    bool? isPlaying,
  }) {
    return VideoItemVM(
      post: post ?? this.post,
      controller: controller ?? this.controller,
      initialized: initialized ?? this.initialized,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}

/// Provider
final fypProvider = AsyncNotifierProvider<
    NewVideoNotifier, CursorPaginatedResponse<VideoItemVM>>(NewVideoNotifier.new);

class NewVideoNotifier
    extends AsyncNotifier<CursorPaginatedResponse<VideoItemVM>>
    with CursorPaginationController<VideoItemVM> {
  late PostRepository _postRepository;
  bool _isInitializing = false;

  @override
  FutureOr<CursorPaginatedResponse<VideoItemVM>> build() async {
    _postRepository = ref.read(postRepoProvider);

    // Attach listeners
    onAuthStateChanged();
    onNetworkStateChanged();
    onCommentUpdate();
    onVideoUpdate();
    onPostUpdate();


    // Initial load
    final result = await loadData(CursorPaginatedRequest());
    if (result.dataList.isNotEmpty) {
      // Preload first video immediately
      await _initController(result.dataList, 0);
      await _initController(result.dataList, 1); // preload next
    }
    return result;
  }

  /// --- Initialize Video Controller Smoothly ---
  Future<void> _initController(List<VideoItemVM> items, int index) async {
    if (_isInitializing || index < 0 || index >= items.length) return;
    final item = items[index];
    if (item.initialized || item.controller != null) return;

    _isInitializing = true;
    try {
      final controller = VideoPlayerController.networkUrl(
        Uri.parse(item.post.outputKey?? ""),
        // httpHeaders: 
      );

      LoggerService.logInfo("Loading video from URL: ${item.post.outputKey}");

      await controller.initialize();
      controller.setLooping(true);

      item.controller = controller;
      item.initialized = true;

      // Update the state silently (no heavy rebuild)
      final newState = state.requireValue.copyWith(dataList: [...items]);
      state = AsyncData(newState);
    } catch (e, s) {
      LoggerService.logError(
        error: e.toString(),
        stackTrace: s,
        reason: 'VideoController initialization failed',
      );
    } finally {
      _isInitializing = false;
    }
  }

  Future<void> handleScroll(int index) async {
  // Explicitly cast to List<VideoItemVM>
  final List<VideoItemVM> items = List<VideoItemVM>.from(
    state.value?.dataList ?? <VideoItemVM>[],
  );

  if (index < 0 || index >= items.length) return;

  // Pause all other videos
  for (var i = 0; i < items.length; i++) {
    final c = items[i].controller;
    if (c != null && c.value.isInitialized) {
      if (i == index) {
        await c.play();
        items[i].isPlaying = true;
      } else {
        await c.pause();
        items[i].isPlaying = false;
      }
    }
  }

  // Initialize current if needed
  await _initController(items, index);

  // Preload neighbors
  _initController(items, index + 1);
  _initController(items, index - 1);

  // Dispose far-away ones
  _disposeFar(items, index);

  // Update state
  state = AsyncData(state.requireValue.copyWith(dataList: [...items]));
}


  void _disposeFar(List<VideoItemVM> items, int index) {
    for (int i = 0; i < items.length; i++) {
      if ((i - index).abs() > 3 && items[i].controller != null) {
        try {
          items[i].controller?.dispose();
        } catch (_) {}
        items[i]
          ..controller = null
          ..initialized = false
          ..isPlaying = false;
      }
    }
  }

  /// --- Load paginated data ---
  @override
  FutureOr<CursorPaginatedResponse<VideoItemVM>> loadData(
    CursorPaginatedRequest request,
  ) async {
    try {
      final res = await _postRepository.getPosts(query: request.toJson());
      return res.fold(
        (l) => Future.error(l.message),
        (r) {
          final videos = r.data.dataList;
          final current = state.value?.dataList ?? [];
          final newItems = videos.map((v) => VideoItemVM(post: v)).toList();
          final merged = [...current, ...newItems];

          // Preload first two
          if (current.isEmpty && merged.isNotEmpty) {
            _initController(merged, 0);
            if (merged.length > 1) _initController(merged, 1);
          }

          return CursorPaginatedResponse(
            dataList: merged,
            totalItems: r.data.totalItems,
            cursor: r.data.cursor,
            stop: r.data.stop,
            extraMap: r.data.extraMap,
            keyword: r.data.keyword,
          );
        },
      );
    } catch (e, s) {
      LoggerService.logError(error: e.toString(), stackTrace: s);
      return Future.error(e.toString());
    }
  }

  /// --- Post update stream ---
  void onPostUpdate() {
    _postRepository.onPostUpdate().listen((d) {
      try {
        addBottom(VideoItemVM(post: d));
      } catch (e) {
        log.e(e);
      }
    });
  }

  /// --- Comment count listener ---
  void onCommentUpdate() {
    ref.listen(commentNotifierProvider, (p, n) {
      n.maybeWhen(
        orElse: () {},
        sent: (message, comment) {
          findAndUpdate(
            where: (item) => item.post.id == comment.videoId,
            update: (e) => e.copyWith(
              post: e.post.copyWith(
                count: e.post.count.copyWith(
                  comments: e.post.count.comments + 1,
                ),
              ),
            ),
          );
        },
      );
    });
  }

  /// --- Post like/save listener ---
  void onVideoUpdate() {
    ref.listen(postNotifierProvider, (p, n) {
      n.maybeWhen(
        orElse: () {},
        liked: _updatePost,
        unliked: _updatePost,
        likeFailed: _updatePostWithMessage,
        saved: _updatePost,
        unsaved: _updatePost,
        saveFailed: _updatePostWithMessage,
      );
    });
  }

  void _updatePost(PostModel post) {
    findAndUpdate(
      where: (item) => item.post.id == post.id,
      update: (e) => e.copyWith(post: post),
    );
  }

  void _updatePostWithMessage(PostModel post, String msg) {
    findAndUpdate(
      where: (item) => item.post.id == post.id,
      update: (e) => e.copyWith(post: post),
    );
  }
}
