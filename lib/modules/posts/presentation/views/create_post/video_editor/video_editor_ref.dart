// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'dart:io';

import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:video_editor/video_editor.dart';
import 'package:video_player/video_player.dart';

class VideoEditorScreen extends StatefulWidget {
  // final String projectName;
  final File file;
  const VideoEditorScreen({super.key, required this.file});

  @override
  State<VideoEditorScreen> createState() => _VideoEditorScreenState();
}

class _VideoEditorScreenState extends State<VideoEditorScreen> {
  final ImagePicker _picker = ImagePicker();
  VideoEditorController? _videoEditorController;
  VideoPlayerController? _videoPlayerController;
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

  void _showFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.black,
          padding: EdgeInsets.all(16),
          height: 250,
          child: Column(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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

  Future<void> _pickVideo() async {
    final XFile? file = await _picker.pickVideo(source: ImageSource.gallery);
    if (file != null) {
      _videoEditorController = VideoEditorController.file(
        File(file.path),
        minDuration: const Duration(seconds: 1),
        maxDuration: const Duration(minutes: 6),
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

        setState(() {
          canShowEditor = true;
        });
      } catch (e) {
        debugPrint("Initialization error : $e");
      }
    }
  }

  Future<void> _trimVideo() async {
    if (_videoEditorController == null) return;

    /// check if trim duration is less than 5 seconds
    if (_videoEditorController!.maxDuration.inSeconds <= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Trim video minimum duration is 5 second.',
          ),
        ),
      );
      return;
    }
    final start = _videoEditorController!.startTrim.inMilliseconds / 1000;
    final end = _videoEditorController!.endTrim.inMilliseconds / 1000;
    final Directory tempDir = await getTemporaryDirectory();
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final String fileName = 'trimmed_video_$timestamp.mp4';
    final String outputPath = path.join(tempDir.path, fileName);
    debugPrint("tempDir : $outputPath");

    final String command =
        '-i ${_videoEditorController!.file.path} -ss $start -to $end -c copy $outputPath';
    await FFmpegKit.execute(command).then((session) async {
      final returnCode = await session.getReturnCode();
      if (ReturnCode.isSuccess(returnCode)) {
        _generateThumbnail(outputPath, timestamp);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to trim video, trim minimum duration is 5 second.',
            ),
          ),
        );
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

  Future<void> _generateThumbnail(String videoPath, String timestamp) async {
    final Directory tempDir = await getTemporaryDirectory();
    final String fileName = 'thumb_$timestamp.jpg';
    final String thumbnailPath = path.join(tempDir.path, fileName);

    final String command =
        '-i $videoPath -ss 00:00:00.500 -vframes 1 $thumbnailPath';
    // '-i $videoPath -ss 00:00:00.100 -vframes 1 $thumbnailPath';

    await FFmpegKit.execute(command).then((session) async {
      final returnCode = await session.getReturnCode();
      if (ReturnCode.isSuccess(returnCode)) {
        setState(() {
          trimmedVideos.add({'video': videoPath, 'thumbnail': thumbnailPath});
        });
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to export video')));
      }
    });
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
      final videoWidth = _videoPlayerController!.value.size.width;
      final videoHeight = _videoPlayerController!.value.size.height;

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

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("✅ Exported: $mergedVideoPath")));
        Navigator.pop(context);
      } else {
        debugPrint("❌ Error: ${await session.getOutput()}");
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Failed to merge videos.")));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video editor'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                enableTransition = !enableTransition;
              });
            },
            icon: Icon(
              enableTransition
                  ? Icons.swap_horizontal_circle
                  : Icons.swap_horizontal_circle_outlined,
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: Column(
          children: [
            if (canShowEditor &&
                _videoPlayerController!.value.isInitialized &&
                _videoEditorController!.initialized) ...[
              // Video preview area
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          AspectRatio(
                            aspectRatio:
                                _videoPlayerController!.value.aspectRatio,
                            child: VideoPlayer(_videoPlayerController!),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (_videoPlayerController!.value.isPlaying) {
                                  _videoPlayerController!.pause();
                                } else {
                                  if (!isSeeking) {
                                    int startTrimDuration =
                                        _videoEditorController!
                                            .startTrim
                                            .inSeconds;
                                    _videoPlayerController!.seekTo(
                                      Duration(seconds: startTrimDuration),
                                    );
                                  }
                                  _videoPlayerController!.play();
                                }
                              });
                            },
                            icon: Icon(
                              _videoPlayerController!.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
                              size: 48,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Slider(
                            activeColor: context.colorScheme.primary,
                            inactiveColor: Colors.grey,
                            value:
                                _videoPlayerController!
                                    .value
                                    .position
                                    .inMilliseconds
                                    .toDouble(),
                            max:
                                _videoPlayerController!
                                    .value
                                    .duration
                                    .inMilliseconds
                                    .toDouble(),
                            onChangeStart: (value) {
                              isSeeking = true;
                            },
                            onChanged: (value) {
                              _videoPlayerController!.seekTo(
                                Duration(milliseconds: value.toInt()),
                              );
                              setState(() {});
                            },
                            onChangeEnd: (value) {
                              isSeeking = false;
                              _videoPlayerController!.play();
                            },
                          ),
                        ),
                        Text(
                          formatDuration(
                            _videoPlayerController?.value.position ??
                                Duration(seconds: 0),
                          ),
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
                                  _videoPlayerController!.setPlaybackSpeed(
                                    playbackSpeed,
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              // Timeline editor
              Expanded(
                flex: 1,
                child: ReorderableListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: trimmedVideos.length,
                  onReorder: (int oldIndex, int newIndex) {
                    if (newIndex > oldIndex) newIndex -= 1;
                    final Map<String, String> movedClip = trimmedVideos
                        .removeAt(oldIndex);
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
                                onPressed:
                                    () => setState(() {
                                      trimmedVideos.removeAt(index);
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // TrimSlider
              TrimSlider(
                controller: _videoEditorController!,
                height: 60,
                horizontalMargin: 16,
                child: TrimTimeline(controller: _videoEditorController!),
              ),

              // Editing toolbar
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: _trimVideo,
                      icon: Icon(Icons.content_cut, color: Colors.white),
                    ),
                    IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () => _openCropRatioModal(context),
                      icon: Icon(Icons.crop, color: Colors.white),
                    ),
                    IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          isSpeedControlVisible = !isSpeedControlVisible;
                        });
                      },
                      icon: Icon(
                        Icons.speed,
                        color:
                            !isSpeedControlVisible
                                ? Colors.white
                                : Colors.green,
                      ),
                    ),
                    IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          isMuted = !isMuted;
                          _videoPlayerController!.setVolume(isMuted ? 0 : 1);
                        });
                      },
                      icon: Icon(
                        isMuted ? Icons.volume_off : Icons.volume_up,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () => _showFilterModal(context),
                      icon: Icon(Icons.filter, color: Colors.white),
                    ),
                  ],
                ),
              ),

              // Bottom Action buttons
              Padding(
                padding: EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: _mergeVideosOptimized,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Text(
                    'Merge & Export Final video',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ] else ...[
              Expanded(
                child: Center(
                  child: Text(
                    'Select a video to start editing',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 25),
                child: ElevatedButton(
                  onPressed: _pickVideo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text(
                    'Import video',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
