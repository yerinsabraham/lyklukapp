import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/video_editor/editor_trimmer.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:video_editor/video_editor.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../utils/assets_manager.dart';
import '../widgets/top_chip.dart';

class EditorPreview extends StatefulWidget {
  final File file;
  final Function(File) onUpdate;
  const EditorPreview({super.key, required this.file, required this.onUpdate});

  @override
  State<EditorPreview> createState() => _EditorPreviewState();
}

class _EditorPreviewState extends State<EditorPreview> {
  late VideoPlayerController controller;
  late VideoEditorController editorController;
  late File _updatedFile;
  @override
  void initState() {
    _updatedFile = widget.file;
    _initController();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    editorController.dispose();
    super.dispose();
  }

  void _initController() async {
    final file = _updatedFile;
    editorController = VideoEditorController.file(
      File(widget.file.path),
      minDuration: const Duration(seconds: 1),
      maxDuration: const Duration(hours: 24),
    );

    controller = VideoPlayerController.file(File(file.path));

    try {
      await Future.wait([
        editorController.initialize(),
        controller.initialize(),
      ]);

      controller.addListener(() {
        if (controller.value.position >= editorController.endTrim) {
          controller.pause();
        }
      });
    } catch (e) {
      debugPrint("Initialization error : $e");
    }
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final hours = duration.inHours;
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return hours > 0 ? "$hours:$minutes:$seconds" : "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.8,
      width: context.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
      child: Stack(
        children: [
          Center(
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            ),
          ),

          Center(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (controller.value.isPlaying) {
                    controller.pause();
                  } else {
                    controller.play();
                  }
                });
              },
              child: Icon(
                controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 48,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PreviewActionButton(
                    iconPath: IconAssets.editGearIcon,
                    onTap: () {},
                  ),
                  PreviewActionButton(
                    iconPath: IconAssets.editTrimIcon,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => EditorTrimmer(
                                controller: controller,
                                editorController: editorController,
                                file: _updatedFile,
                                onUpdate: (v) async {
                                  debugPrint("Trimmed file : ${v.path}");
                                  _updatedFile = v;
                                  controller = VideoPlayerController.file(
                                    File(_updatedFile.path),
                                  );
                                  await controller.initialize().then((_) {
                                   
                                    setState(() {});
                                  });

                                  widget.onUpdate(v);
                                },
                              ),
                        ),
                      );
                    },
                  ),
                  PreviewActionButton(
                    iconPath: IconAssets.editNoteIcon,
                    onTap: () {},
                  ),
                  PreviewActionButton(
                    iconPath: IconAssets.editTextIcon,
                    onTap: () {},
                  ),
                  PreviewActionButton(
                    iconPath: IconAssets.editStickerIcon,
                    onTap: () {},
                  ),
                  PreviewActionButton(
                    iconPath: IconAssets.editFilterIcon,
                    onTap: () {},
                  ),
                  PreviewActionButton(
                    iconPath: IconAssets.editGalleryIcon,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),

          Positioned(top: 60.h, left: 16.w, right: 16.w, child: SoundButton()),
          Positioned(
            bottom: 70.h,
            left: 0,
            right: 0,
            child: ValueListenableBuilder(
              valueListenable: controller,
              builder: (context, value, child) {
                double sliderValue = value.position.inMilliseconds.toDouble();
                return Row(
                  children: [
                    Expanded(
                      child: Slider(
                        max:
                            controller.value.duration.inMilliseconds.toDouble(),
                        value: sliderValue.clamp(
                          0,
                          controller.value.duration.inMilliseconds.toDouble(),
                        ),
                        onChanged: (value) {
                          // setState(() {
                          sliderValue = value;
                          // });
                        },
                        onChangeEnd: (value) {
                          controller.seekTo(
                            Duration(milliseconds: value.toInt()),
                          );
                        },
                        onChangeStart: (value) {},

                        activeColor: context.colorScheme.secondary,
                        inactiveColor: Colors.grey,
                      ),
                    ),
                    Text(
                      formatDuration(controller.value.position),
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PreviewActionButton extends StatelessWidget {
  final String? iconPath;
  final Widget? child;
  final VoidCallback? onTap;
  const PreviewActionButton({super.key, this.iconPath, this.onTap, this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.h,
        width: 40.w,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child:
                child ??
                Center(
                  child: SvgPicture.asset(
                    iconPath ?? IconAssets.editTrimIcon,
                    color: Colors.white,
                  ),
                ),
          ),
        ),
      ),
    );
  }
}

class SoundButton extends StatelessWidget {
  const SoundButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            // ref.read(navBarStatusProvider.notifier).state = true;
            Navigator.pop(context);
          },
          child: SvgPicture.asset(IconAssets.xIcon),
        ),
        const Spacer(),
        TopChip(label: 'Add sound', asset: IconAssets.spotify, onTap: () {}),
        const Spacer(),
        SizedBox(width: 20.w),
      ],
    );
  }
}
