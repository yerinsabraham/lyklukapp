import 'package:flutter/material.dart';
import 'package:lykluk/core/shared/resources/typedefs.dart';
import 'package:video_player/video_player.dart';

import '../../../../data/model/post_model.dart';

class OptimizedVideoPlayer {
  List<PostModel> reels;
  final IndexChangedCallback? onIndexChanged;
  final int preloadCount;
  final bool loop;
  final VoidCallback onMounted;
  OptimizedVideoPlayer({
    required this.reels,
    required this.onMounted,
    this.onIndexChanged,
    this.preloadCount = 3,
    this.loop = true,
  }) {
    _videoControllers = List.filled(reels.length, null);
  }
  late List<VideoPlayerController?> _videoControllers;
  int _currentPage = 0;

  void initializeControllersForPage(int page) {
    // Pause the old video
    if (_videoControllers[_currentPage] != null &&
        _videoControllers[_currentPage]!.value.isInitialized) {
      _videoControllers[_currentPage]!.pause();
    }

    _currentPage = page;
    onIndexChanged?.call(page);

    // Dispose controllers outside the preload range
    for (int i = 0; i < _videoControllers.length; i++) {
      if (i < page - preloadCount || i > page + preloadCount) {
        if (_videoControllers[i] != null) {
          _videoControllers[i]!.dispose();
          _videoControllers[i] = null;
        }
      }
    }

    // Initialize controllers for the current and surrounding pages
    for (int i = page - preloadCount; i <= page + preloadCount; i++) {
      if (i >= 0 && i < reels.length) {
        if (_videoControllers[i] == null) {
          _videoControllers[i] = _createVideoPlayerController(reels[i]);
          _videoControllers[i]!.initialize().then((_) {
            _videoControllers[i]!.setLooping(loop);
            // Autoplay if it's the current page
            if (i == _currentPage) {
              _videoControllers[i]!.play();
            }
            onMounted();
            // if (mounted) {
            //   setState(() {});
            // }
          });
        }
      }
    }

    // Ensure the current page plays if it was already initialized
    if (_videoControllers[page] != null &&
        _videoControllers[page]!.value.isInitialized) {
      _videoControllers[page]!.play();
    }
  }

  void onPageChanged(int index) {
    initializeControllersForPage(index);
  }

  VideoPlayerController _createVideoPlayerController(PostModel reel) {
    return VideoPlayerController.networkUrl(
      Uri.parse(reel.url),
      // Uri.parse("https://stream-akamai.castr.com/5b9352dbda7b8c769937e459/live_2361c920455111ea85db6911fe397b9e/index.fmp4.m3u8"),
      // Uri.parse("http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"),
      //   httpHeaders: {
      //   'Authorization': 'Bearer ${Endpoints.debugToken}',
      //   'Content-Type': 'application/json',
      //   'User-Agent': 'Lykluk-Video-Player/1.0.0',
      // }
    );
  }

  void dispose() {
    for (var controller in _videoControllers) {
      controller?.dispose();
    }
  }

  int get currentPage => _currentPage;
  List<VideoPlayerController?> get videoControllers => _videoControllers;
  int get videoCount => reels.length;

  //  set setReels(int length){
  //   this.reels = reels;
  //   _videoControllers = List.filled(reels.length, null);
  //   onMounted();
  // }
  

  // // void updateReels(List<VideoModel> newReels) {
  // //   final int oldCount = reels.length;
  // //   final int newCount = newReels.length;

  // //   if (newCount <= oldCount) {
  // //     // If new list is smaller or same size, just update the reference
  // //     reels = newReels;
  // //     return;
  // //   }

  // //   // Update the reels list
  // //   reels = newReels;

  // //   for (int i = oldCount; i < newCount; i++) {
  // //     // For List, we need to ensure the list is long enough and check the index
  // //     if (i >= _videoControllers.length || _videoControllers[i] == null) {
  // //       _initializeControllerForIndex(i);
       
  // //     }
  // //   }

  //   // Preload videos around current position if needed
  //   // _preloadVideos();
  // }
}
