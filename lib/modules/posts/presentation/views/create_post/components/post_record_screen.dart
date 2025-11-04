import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lykluk/modules/home/presentation/nav_bar.dart';
import 'package:lykluk/modules/posts/presentation/view_model/notifiers/camera_notifer.dart';
import 'package:lykluk/modules/posts/presentation/view_model/notifiers/video_upload_notifier.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/widgets/circle_record_button.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/widgets/galleru_video_preview.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/widgets/recorder_timer.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/widgets/top_chip.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/helpers/image_video_extension.dart';
import 'package:lykluk/utils/theme/theme.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/video_editor/video_editor_page.dart';
import 'package:lykluk/core/shared/widgets/loading_widget.dart';

class PostRecordScreen extends StatefulHookConsumerWidget {
  const PostRecordScreen({
    super.key,
    required this.onAddSound,
    required this.onNext,
  });

  final VoidCallback onAddSound;
  final VoidCallback onNext;

  @override
  ConsumerState<PostRecordScreen> createState() => _PostRecordScreenState();
}

class _PostRecordScreenState extends ConsumerState<PostRecordScreen> {

  Timer? timer;
  int recordingDuration = 0; // Track recording duration in seconds
  final int maxRecordingDuration = 180; // 3 minutes = 180 seconds


  @override
  void dispose() {
    // Dispose camera when leaving
    // ref.read(cameraControllerProvider.notifier).clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uploadState = ref.watch(videoUploadProvider);
    // final uploadNotifier = ref.watch(videoUploadProvider.notifier);
    final isRecording = ref.watch(isRecordingProvider);
    final cameraController = ref.watch(cameraControllerProvider);
    final cs = Theme.of(context).colorScheme;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          ref.read(navBarStatusProvider.notifier).state = true;
        }
      },
      child: Stack(
        children: [
           cameraController == null || !cameraController.value.isInitialized
              ? const Center(
                child: LoadingWidget(color: Color(AppColors.primaryColor)),
              )
              : SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: cameraController.value.previewSize!.height,
                    height: cameraController.value.previewSize!.width,
                    child: CameraPreview(cameraController),
                  ),
                ),
              ),
          // header
          Positioned(
            top: 10.h,
            left: 16.w,
            right: 16.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    ref.read(navBarStatusProvider.notifier).state = true;
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(IconAssets.xIcon),
                ),
                const Spacer(),
                TopChip(
                  label: 'Add sound',
                  asset: IconAssets.spotify,
                  onTap: widget.onAddSound,
                ),
                const Spacer(),
                SizedBox(width: 20.w),
              ],
            ),
          ),

          // bottom controls
          Positioned(
            left: 0,
            right: 0,
            bottom: 26.h,
            child: Column(
              children: [
                if (uploadState.isUploading)
                  Text(
                    "Uploading... ${(uploadState.progress * 100).toStringAsFixed(0)}%",
                    style: TextStyle(color: cs.onPrimary, fontSize: 12.sp),
                  )
                else if (isRecording)
                  const RecordingTimer()
                else
                  Text(
                    '00:00',
                    style: TextStyle(color: cs.surface, fontSize: 12.sp),
                  ),
                8.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const _MiniAvatar(),
                    30.horizontalSpace,
                    CircleRecordButton(
                      onToggle: (recording) async {
                        final controller = ref.read(cameraControllerProvider)!;
                    
                        if (recording) {
                          await controller.startVideoRecording();
                          startRecordingTimer();
                        } else {
                          final file = await controller.stopVideoRecording();
                          stopRecordingTimer();

                          final renameFile = await renameTempToMp4(file);

                          Navigator.push(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) =>
                                  // VideoEditorScreen(file: File(picked.path)),
                                  VideoEditorPage(file: File(renameFile.path)),
                            ),
                          );
                          // widget.onNext();
                        }
                      },
                    ),
                    30.horizontalSpace,
                    _MiniTool(
                      icon: Icons.photo_library_outlined,
                      // onTap: () => uploadNotifier.pickAndUpload(),
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();
                        // Open gallery for picking video
                        final XFile? picked = await picker.pickVideo(
                          source: ImageSource.gallery,
                        );
                        if (picked == null) return;
                        // selectedVideo.value = File(picked.path);

                         // Check the size of the video
                        final file = File(picked.path);
                        
                        final fileSize = await file.length();

                        // If file size exceeds 32 MB (32 * 1024 * 1024 = 33554432 bytes)
                        if (fileSize > 33554432) {
                          showDialog(
                            // ignore: use_build_context_synchronously
                            context: context,
                            builder: (_) => AlertDialog(
                              backgroundColor: Colors.white,
                              title: Text('File too large',style: context.body16Bold.copyWith(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                )),
                              content: Text('The selected video is larger than 32 MB. Please choose a smaller video.',
                                  style: context.body14Bold.copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w300,
                                  )),
                              actions: [
                                Center(
                                  child: TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('OK',style: context.body16Bold.copyWith(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,color: context.colorScheme.primary,
                                )),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          // Proceed with the video if the size is valid
                          Navigator.push(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                              builder: (_) => VideoEditorPage(file: file),
                            ),
                          );
                        }
                      },
                    ),
                   
                  ],
                ),
                10.verticalSpace,
                Text(
                  'Post',
                  style: TextStyle(color: cs.onPrimary.withValues(alpha: .8)),
                ),
                10.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }

   /// Start the timer when recording begins
  void startRecordingTimer() {
    timer?.cancel();
    recordingDuration = 0;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (recordingDuration >= maxRecordingDuration) {
        // Stop the recording after 3 minutes
        stopRecordingTimer();
        final controller = ref.read(cameraControllerProvider)!;
        controller.stopVideoRecording().then((file) {
          Navigator.push(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
              builder: (_) => VideoEditorPage(file: File(file.path)),
            ),
          );
        });
      } else {
        setState(() {
          recordingDuration++;
        });
      }
    });
  }

  /// Stop the timer when recording ends
  void stopRecordingTimer() {
    timer?.cancel();
    timer = null;
  }
}

 


class _MiniAvatar extends StatelessWidget {
  const _MiniAvatar();

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(radius: 16, backgroundColor: Colors.grey);
  }
}

class _MiniTool extends ConsumerWidget {
  final VoidCallback? onTap;
  final IconData icon;
  const _MiniTool({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uploadNotifier = ref.watch(videoUploadProvider.notifier);

    return InkResponse(
      onTap:
          onTap ??
          () async {
            final file = await uploadNotifier.pickFirstVideo();
            if (file != null && context.mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => VideoPreviewScreen(file: file),
                ),
              );
            }
          },
      radius: 24,
      child: CircleAvatar(
        radius: 18.r,
        backgroundColor: Colors.black.withValues(alpha: .35),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
