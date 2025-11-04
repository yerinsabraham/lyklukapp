import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/controllers/post_controller.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/video_editor/editor_preview.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:video_editor/video_editor.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../core/shared/widgets/shared_widget.dart';
import '../../../../../../utils/router/app_router.dart';
import 'ffmpeg_commands.dart';

class VideoEditorPage extends StatefulHookConsumerWidget {
  final File file;
  const VideoEditorPage({super.key, required this.file});

  @override
  ConsumerState<VideoEditorPage> createState() => _VideoEditorPageState();
}

class _VideoEditorPageState extends ConsumerState<VideoEditorPage> {
  VideoPlayerController? _videoPlayerController;
  VideoEditorController? _videoEditorController;

  @override
  void initState() {
    _initController();

    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController!.dispose();
    _videoEditorController!.dispose();
    super.dispose();
  }

  void _initController() async {
    final file = widget.file;
    _videoEditorController = VideoEditorController.file(
      File(file.path),
      minDuration: const Duration(seconds: 1),
      maxDuration: const Duration(hours: 24),
    );

    _videoPlayerController = VideoPlayerController.file(File(file.path));

    try {
      await Future.wait([
        _videoEditorController!.initialize(),
        _videoPlayerController!.initialize(),
      ]);

      _videoPlayerController!.addListener(() {
        if (_videoPlayerController!.value.position >=
            _videoEditorController!.endTrim) {
          _videoPlayerController!.pause();
        }
      });
    } catch (e) {
      debugPrint("Initialization error : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final updatedFile = useState(widget.file);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          /// video prview
          EditorPreview(
            file: widget.file,
            onUpdate: (file) {
              updatedFile.value = file;
            },
          ),

          /// action buttons
          EditorActions(
            controller: _videoPlayerController!,
            file: updatedFile.value,
          ),
        ],
      ),
    );
    // return Scaffold();
  }
}

class EditorActions extends HookConsumerWidget {
  final VideoPlayerController controller;
  final File file;
  const EditorActions({
    super.key,
    required this.controller,
    required this.file,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isResizing = useState(false);

    // Future<File?> resize() async {
    //   try {
    //     isResizing.value = true;
    //     final result = await FFmpegCommandsHelper.resizeVideoForMobile(file);
    //     debugPrint("new resized file : ${result?.path}");
    //     isResizing.value = false;
    //     return result;
    //   } catch (e) {
    //     isResizing.value = false;
    //     return null;
    //   }
    // }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
          bottomLeft: Radius.circular(0.r),
          bottomRight: Radius.circular(0.r),
        ),
      ),
      child: Row(
        children: [
          // Expanded(
          //   child: CustomElevatedButton(
          //     color: context.colorScheme.onSecondary.withValues(alpha: 0.1),
          //     borderColor: Colors.white,
          //     onTap: () {

          //     },
          //     textColor: context.colorScheme.primary,
          //     buttonText: 'Trim video',
          //   ),
          // ),
          Expanded(
            child: CustomElevatedButton(
              isLoading: isResizing.value,
              onTap: () async {
                if (controller.value.isPlaying) {
                  controller.pause();
                }
                // final newfile = await resize();
                final thumb = await FFmpegCommandsHelper.generateThumbnailImage(
                  inputPath: file.path,
                );
                debugPrint("new thumbnail : ${thumb?.path}");
                ref
                    .read(postParamsController.notifier)
                    .update((v) => v.copyWith(
                      video: file,
                      thumbnail: thumb,
                    ));
                // ignore: use_build_context_synchronously
                context.pushNamed(Routes.createPostRoute);
              },
              buttonText: 'Next',
            ),
          ),
        ],
      ),
    );
  }
}

class TrimTimeLine extends StatelessWidget {
  final List<Map<String, String>> trimmedVideos;
  final VoidCallback onTrim;
  const TrimTimeLine({
    super.key,
    required this.trimmedVideos,
    required this.onTrim,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ReorderableListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: trimmedVideos.length,
        onReorder: (int oldIndex, int newIndex) {
          if (newIndex > oldIndex) newIndex -= 1;
          final Map<String, String> movedClip = trimmedVideos.removeAt(
            oldIndex,
          );
          trimmedVideos.insert(newIndex, movedClip);
        },
        itemBuilder: (context, index) {
          return ReorderableDragStartListener(
            index: index,
            key: ValueKey(trimmedVideos[index]['video']),
            child: Container(
              width: 100,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  trimmedVideos[index]['thumbnail'] != null
                      ? Image.file(
                        File(trimmedVideos[index]['thumbnail']!),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                      : Center(child: CircularProgressIndicator()),
                  Positioned(
                    right: 4,
                    top: 4,
                    child: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: onTrim,
                      // onPressed:
                      //     () => setState(() {
                      //       trimmedVideos.removeAt(index);
                      //     }),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
