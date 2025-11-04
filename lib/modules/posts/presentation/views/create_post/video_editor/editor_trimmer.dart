// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'dart:io';

import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/core/services/logger_service.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:video_editor/video_editor.dart';
import 'package:video_player/video_player.dart';

import 'editor_preview.dart';

class EditorTrimmer extends StatefulWidget {
  final VideoPlayerController controller;
  final VideoEditorController editorController;
  final File file;
  final Function(File) onUpdate;
  const EditorTrimmer({
    super.key,
    required this.controller,
    required this.editorController,
    required this.file,
    required this.onUpdate,
  });

  @override
  State<EditorTrimmer> createState() => _EditorTrimmerState();
}

class _EditorTrimmerState extends State<EditorTrimmer> {
  // late File _updatedFile;
  bool canShowEditor = false;
  List<Map<String, String>> trimmedVideos = [];
  bool isSeeking = false;
  bool enableTransition = false;
  bool isMuted = false;
  bool isSpeedControlVisible = false;
  double playbackSpeed = 1.0;
  String selectedAspectRatio = "Original";
  final Map<String, List<int>> aspectRatios = {
    "Original": [0, 0, 0, 0],
    "16:9": [1920, 1080, 0, 0],
    "9:16": [1080, 1920, 0, 0],
    "4:3": [1440, 1080, 0, 0],
  };
  String selectFilter = "None";
  final Map<String, String> filterCommands = {
    "None": "",
    "Brightness": "eq=brightness=0.3",
    "Contrast": "eq=contrast=1.5",
    "Saturation": "eq=saturation=1.8",
    "Grayscale": "format=gray",
    "Sepia":
        "colorchannelmixer=.393:.769:.189:0:.349:.686:.168:0:.272:.534:.131",
  };
  ///////////////////////////
  void _showFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: context.width,
          padding: EdgeInsets.all(16),
          height: 250,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
            // border: Border.all(color: context.colorScheme.surface, width: 1)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Filter",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              Wrap(
                runSpacing: 10.w,
                spacing: 10.h,
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:
                    filterCommands.keys.map((filter) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectFilter = filter;
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color:
                                selectFilter == filter
                                    ? Colors.green
                                    : Colors.white10,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            filter,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openCropRatioModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.black,
          padding: EdgeInsets.all(16),
          height: 200,
          child: Column(
            children: [
              Text(
                "Select crop ratio",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:
                    aspectRatios.keys.map((ratio) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedAspectRatio = ratio;
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color:
                                selectedAspectRatio == ratio
                                    ? Colors.green
                                    : Colors.white10,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            ratio,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  

  Future<void> _mergeVideosOptimized() async {
    if (trimmedVideos.isEmpty) return;

    final path = Uuid().v1();
    final Directory tempDir = await getTemporaryDirectory();
    final String mergedVideoPath = '${tempDir.path}/$path.mp4';
    final String fileListPath = '${tempDir.path}/file_list.txt';
    File fileList = File(fileListPath);

    String fileListContent = trimmedVideos
        .map((path) => "file '${path['video']}'")
        .join("\n");
    await fileList.writeAsString(fileListContent);

    // Start with concat input
    String command = '-f concat -safe 0 -i $fileListPath';

    List<String> videoFilters = [];
    List<String> audioFilters = [];

    // Transitions
    if (enableTransition) {
      videoFilters.add('fade=in:0:30');
    }

    // Mute
    if (isMuted) {
      command += ' -an';
    }

    // Speed
    if (playbackSpeed != 1.0) {
      double setptsValue = 1 / playbackSpeed;
      videoFilters.add("setpts=$setptsValue*PTS");
      audioFilters.add("atempo=$playbackSpeed");
    }

    // Aspect Ratio
    if (selectedAspectRatio != "Original") {
      final videoWidth = widget.controller.value.size.width;
      final videoHeight = widget.controller.value.size.height;

      final aspectRatioSettings = aspectRatios[selectedAspectRatio]!;
      int targetWidth = aspectRatioSettings[0];
      int targetHeight = aspectRatioSettings[1];
      int cropX = aspectRatioSettings[2];
      int cropY = aspectRatioSettings[3];

      double videoAspectRatio = videoWidth / videoHeight;
      double targetAspectRatio = targetWidth / targetHeight.toDouble();

      if (videoAspectRatio > targetAspectRatio) {
        targetWidth = (videoHeight * targetAspectRatio).toInt();
        cropX = ((videoWidth - targetWidth) ~/ 2);
        cropY = 0;
        targetHeight = videoHeight.toInt();
      } else {
        targetHeight = (videoWidth / targetAspectRatio).toInt();
        cropY = ((videoHeight - targetHeight) ~/ 2);
        cropX = 0;
        targetWidth = videoWidth.toInt();
      }

      targetWidth = targetWidth - (targetWidth % 2);
      targetHeight = targetHeight - (targetHeight % 2);

      videoFilters.add("crop=$targetWidth:$targetHeight:$cropX:$cropY");
    }

    // Custom filter
    if (selectFilter != "None") {
      videoFilters.add(filterCommands[selectFilter]!);
    }

    // Apply filters if present
    if (videoFilters.isNotEmpty) {
      command += ' -vf "${videoFilters.join(",")}"';
    }
    if (audioFilters.isNotEmpty) {
      command += ' -af "${audioFilters.join(",")}"';
    }

    // ✅ Optimization: if no filters/speed/ratio → use copy
    if (videoFilters.isEmpty && audioFilters.isEmpty && !enableTransition) {
      command += ' -c copy $mergedVideoPath -y';
    } else {
      // Otherwise re-encode but with ultrafast preset
      command +=
          ' -c:v libx264 -preset ultrafast -crf 23 -movflags +faststart $mergedVideoPath -y';
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await FFmpegKit.execute(command).then((session) async {
      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        String thumbnailPath = trimmedVideos.first['thumbnail']!;

        List<String> savedProjects =
            prefs.getStringList('saved_projects') ?? [];
        savedProjects.add('$mergedVideoPath|$thumbnailPath');
        prefs.setStringList('saved_projects', savedProjects);

    
          widget.onUpdate(File(mergedVideoPath));
        Navigator.pop(context);
      } else {
        debugPrint("❌ Error: ${await session.getOutput()}");
        LoggerService.logError(error: await session.getOutput(), stackTrace:StackTrace.current , reason: "Failed to merge videos.");
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Failed to merge videos.")));
      }
    });
  }

  Future<void> _trimVideo() async {
    final start = widget.editorController.startTrim.inMilliseconds / 1000;
    final end = widget.editorController.endTrim.inMilliseconds / 1000;
    final Directory tempDir = await getTemporaryDirectory();
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final String fileName = 'trimmed_video_$timestamp.mp4';
    final String outputPath = path.join(tempDir.path, fileName);
    debugPrint("tempDir : $outputPath");

    final String command =
        '-i ${widget.editorController.file.path} -ss $start -to $end -c copy $outputPath';
    await FFmpegKit.execute(command).then((session) async {
      final returnCode = await session.getReturnCode();
      if (ReturnCode.isSuccess(returnCode)) {
        _generateThumbnail(outputPath, timestamp);
      } else {
          LoggerService.logError(
          error: await session.getOutput(),
          stackTrace: StackTrace.current,
          reason: "Failed to trim video.",
        );
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to export video'), backgroundColor: Colors.red,));
      }
    });
  }

  Future<void> _generateThumbnail(String videoPath, String timestamp) async {
    final Directory tempDir = await getTemporaryDirectory();
    final String fileName = 'thumb_$timestamp.jpg';
    final String thumbnailPath = path.join(tempDir.path, fileName);

    final String command =
        '-i $videoPath -ss 00:00:00.500 -vframes 1 $thumbnailPath';

    await FFmpegKit.execute(command).then((session) async {
      final returnCode = await session.getReturnCode();
      if (ReturnCode.isSuccess(returnCode)) {
        setState(() {
          trimmedVideos.add({'video': videoPath, 'thumbnail': thumbnailPath});
        });
      } else {
          LoggerService.logError(
          error: await session.getOutput(),
          stackTrace: StackTrace.current,
          reason: "Failed to generate thumbnail for  video.",
        );
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to export video'), backgroundColor: Colors.red,));
      }
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final hours = duration.inHours;
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return hours > 0 ? "$hours:$minutes:$seconds" : "$minutes:$seconds";
  }

  double _sliderValue = 0.0;
  @override
  void initState() {
  
    widget.controller.addListener(() {
      if (widget.controller.value.isInitialized) {
        setState(() {
          _sliderValue =
              widget.controller.value.position.inMilliseconds.toDouble();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        // mainAxisSize: MainAxisSize.max,
        children: [
          Stack(
            // fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              Center(
                child: AspectRatio(
                  aspectRatio: widget.controller.value.aspectRatio,
                  child: VideoPlayer(widget.controller),
                ),
              ),

              // Center(
              //   child: Icon(Icons.import_contacts,  color: Colors.white),
              // ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (widget.controller.value.isPlaying) {
                        widget.controller.pause();
                      } else {
                        if (!isSeeking) {
                          int startTrimDuration =
                              widget.editorController.startTrim.inSeconds;
                          widget.controller.seekTo(
                            Duration(seconds: startTrimDuration),
                          );
                        }
                        widget.controller.play();
                      }
                    });
                  },
                  child: Icon(
                    widget.controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white,
                    size: 48,
                  ),
                ),
              ),

              Positioned(
                top: 60.h,
                right: 0,
                child: Tooltip(
                  message: "Merge and export trimmed videos",
                  child: PreviewActionButton(
                    onTap: _mergeVideosOptimized,
                    child: Icon(
                      Icons.wifi_protected_setup_sharp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 60.h,
                left: 16.w,
                right: 16.w,
                child: SoundButton(),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 10.sH,
                Row(
                  children: [
                    Expanded(
                      child: Slider(
                        max:
                            widget.controller.value.duration.inMilliseconds
                                .toDouble(),
                        value: _sliderValue.clamp(
                          0,
                          widget.controller.value.duration.inMilliseconds
                              .toDouble(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _sliderValue = value;
                          });
                        },
                        onChangeEnd: (value) {
                          isSeeking = false;
                          widget.controller.seekTo(
                            Duration(milliseconds: value.toInt()),
                          );
                        },
                        onChangeStart: (value) {
                          isSeeking = true;
                        },

                        activeColor: context.colorScheme.secondary,
                        inactiveColor: Colors.grey,
                      ),
                    ),
                    Text(
                      formatDuration(widget.controller.value.position),
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                if (isSpeedControlVisible)
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Text(
                              "Speed : ${playbackSpeed.toStringAsFixed(1)}x",
                              style: TextStyle(color: Colors.white),
                            ),
                            Slider(
                              min: 0.5,
                              max: 3.0,
                              divisions: 6,
                              value: playbackSpeed,
                              onChanged: (value) {
                                setState(() {
                                  playbackSpeed = value;
                                  widget.controller.setPlaybackSpeed(
                                    playbackSpeed,
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                      ),

                // TrimSlider
                TrimSlider(
                  controller: widget.editorController,
                  height: 60,
                  horizontalMargin: 16,
                  child: TrimTimeline(controller: widget.editorController),
                ),
                5.sH,
                // Editing toolbar
                Visibility(
                  visible: trimmedVideos.isNotEmpty,
                  replacement: SizedBox.shrink(),
                  child: SizedBox(
                    height: 110.h,
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      removeBottom: true,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        itemCount: trimmedVideos.length,
                        itemBuilder: (c, index) {
                          return Container(
                            width: 100,
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Stack(
                              children: [
                                trimmedVideos[index]['thumbnail'] != null
                                    ? Image.file(
                                      File(trimmedVideos[index]['thumbnail']!),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    )
                                    : Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                Positioned(
                                  right: 4,
                                  top: 4,
                                  child: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed:
                                        () => setState(() {
                                          trimmedVideos.removeAt(index);
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      //   ReorderableListView.builder(
                      //     padding: EdgeInsets.zero,
                      //     scrollDirection: Axis.horizontal,
                      //     itemCount: trimmedVideos.length,
                      //     onReorder: (int oldIndex, int newIndex) {
                      //       if (newIndex > oldIndex) newIndex -= 1;
                      //       final Map<String, String> movedClip = trimmedVideos
                      //           .removeAt(oldIndex);
                      //       trimmedVideos.insert(newIndex, movedClip);
                      //     },
                      //     itemBuilder: (context, index) {
                      //       return
                      //       ReorderableDragStartListener(
                      //         index: index,
                      //         key: ValueKey(trimmedVideos[index]['video']),
                      //         child: Container(
                      //           width: 100,
                      //           margin: EdgeInsets.all(8),
                      //           decoration: BoxDecoration(
                      //             // borderRadius: BorderRadius.circular(10.r),
                      //           ),
                      //           child: Stack(
                      //             children: [
                      //               trimmedVideos[index]['thumbnail'] != null
                      //                   ? Image.file(
                      //                     File(trimmedVideos[index]['thumbnail']!),
                      //                     fit: BoxFit.cover,
                      //                     width: double.infinity,
                      //                   )
                      //                   : Center(child: CircularProgressIndicator()),
                      //               Positioned(
                      //                 right: 4,
                      //                 top: 4,
                      //                 child: IconButton(
                      //                   icon: Icon(Icons.delete, color: Colors.red),
                      //                   onPressed:
                      //                       () => setState(() {
                      //                         trimmedVideos.removeAt(index);
                      //                       }),
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       );

                      //     },
                      //   ),
                      // ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                  ).copyWith(bottom: 30.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PreviewActionButton(
                        onTap: () {
                          setState(() {
                            enableTransition = !enableTransition;
                          });
                        },
                        child: Icon(
                          enableTransition
                              ? Icons.swap_horizontal_circle
                              : Icons.swap_horizontal_circle_outlined,
                          color: Colors.white,
                        ),
                      ),
                      PreviewActionButton(
                        onTap: _trimVideo,
                        child: Icon(Icons.content_cut, color: Colors.white),
                      ),

                      PreviewActionButton(
                        onTap: () => _openCropRatioModal(context),
                        child: Icon(Icons.crop, color: Colors.white),
                      ),

                      PreviewActionButton(
                        onTap: () {
                          setState(() {
                            isSpeedControlVisible = !isSpeedControlVisible;
                          });
                        },
                        child: Icon(
                          Icons.speed,
                          color:
                              !isSpeedControlVisible
                                  ? Colors.white
                                  : Colors.green,
                        ),
                      ),

                      PreviewActionButton(
                        onTap: () {
                          setState(() {
                            isMuted = !isMuted;
                            widget.controller.setVolume(isMuted ? 0 : 1);
                          });
                        },
                        child: Icon(
                          isMuted ? Icons.volume_off : Icons.volume_up,
                          color: Colors.white,
                        ),
                      ),

                      PreviewActionButton(
                        onTap: () => _showFilterModal(context),
                        child: Icon(Icons.filter, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
