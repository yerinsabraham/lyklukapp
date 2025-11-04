import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/services/services.dart';
import 'package:lykluk/modules/posts/presentation/view_model/state/post_state.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/helpers/thumb_generator.dart';
import 'package:lykluk/utils/theme/theme.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../core/shared/widgets/shared_widget.dart';
import '../../../../../../utils/router/app_router.dart';
import '../../../view_model/notifiers/post_notifier.dart';

class VideoPreviewScreen extends StatefulHookConsumerWidget {
  final File file;
  const VideoPreviewScreen({super.key, required this.file});
  @override
  ConsumerState<VideoPreviewScreen> createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends ConsumerState<VideoPreviewScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.file)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(title: const Text("Preview")),
      body: Stack(
        children: [
          _controller.value.isInitialized
              ? Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              )
              : const LoadingWidget(color: Color(AppColors.primaryColor)),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 20.h,
                  ),
                  child: Icon(Icons.close, color: Colors.white, size: 30.sp),
                ),
              ),
            ),
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: UPloadProgress()),
        ],
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.r),
            topRight: Radius.circular(10.r),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: CustomElevatedButton(
                color: context.colorScheme.onSecondary.withValues(alpha: 0.1),
                borderColor: Colors.white,
                onTap: () {},
                textColor: context.colorScheme.primary,
                buttonText: 'Trim video',
              ),
            ),
            10.sW,
            Expanded(
              child: CustomElevatedButton(
                // isLoading: ref.watch(videoNotifierProvider) is VideoUploading,
                onTap: () async {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  }
                  final thumb = await ThumbnailGenerator.generateThumbnail(
                    videoPath: widget.file.path,
                  );
                  log.d(thumb);
                  // ignore: use_build_context_synchronously
                  context.pushNamed(
                    Routes.createPostRoute,
                    extra: {"file": widget.file, "thumbnail": thumb},
                  );
                },
                buttonText: 'Next',
              ),
            ),
            // ElevatedButton(onPressed: (){}, child: Text('Share'))
          ],
        ),
      ),
    );
  }
}

class UPloadProgress extends HookConsumerWidget {
  const UPloadProgress({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postNotifierProvider);
    if (state is PostUploading) {
      // return Slider(onChanged: (v) {}, value: state.progress, min: 0.0, max: 1);
      return CircularProgressIndicator(value: state.progress, backgroundColor: Colors.grey.shade300, color: context.colorScheme.primary,);
    } else {
      return SizedBox.shrink();
    }
  }
}
