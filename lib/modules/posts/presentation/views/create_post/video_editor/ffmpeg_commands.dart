import 'dart:io';

import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:ffmpeg_kit_flutter_new/return_code.dart';


class FFmpegCommandsHelper {
  /// Trim video between [start] and [end] (seconds)
  static Future<void> trimVideo({
    required String inputPath,
    required String outputPath,
    required int start,
    required int end,
    bool accurate = false,
  }) async {
    final command =
        accurate
            ? "-i $inputPath -ss $start -to $end -c:v libx264 -c:a aac $outputPath"
            : "-i $inputPath -ss $start -to $end -c copy $outputPath";

    await FFmpegKit.execute(command);
  }

  /// Apply filter (brightness, contrast, saturation)
  static Future<void> applyColorFilter({
    required String inputPath,
    required String outputPath,
    double brightness = 0.0,
    double contrast = 1.0,
    double saturation = 1.0,
  }) async {
    final command =
        "-i $inputPath -vf eq=brightness=$brightness:contrast=$contrast:saturation=$saturation $outputPath";

    await FFmpegKit.execute(command);
  }

  /// Convert video to grayscale
  static Future<void> applyGrayscale({
    required String inputPath,
    required String outputPath,
  }) async {
    final command = "-i $inputPath -vf hue=s=0 $outputPath";
    await FFmpegKit.execute(command);
  }

  /// Add music (replace original audio)
  static Future<void> addMusic({
    required String videoPath,
    required String audioPath,
    required String outputPath,
  }) async {
    final command =
        "-i $videoPath -i $audioPath -c:v copy -c:a aac -shortest $outputPath";

    await FFmpegKit.execute(command);
  }

  /// Mix original video audio with background music
  static Future<void> mixAudio({
    required String videoPath,
    required String audioPath,
    required String outputPath,
  }) async {
    final command =
        "-i $videoPath -i $audioPath -filter_complex [0:a][1:a]amix=inputs=2:duration=shortest -c:v copy $outputPath";

    await FFmpegKit.execute(command);
  }

  /// Overlay image (like sticker or watermark)
  static Future<void> addOverlay({
    required String videoPath,
    required String imagePath,
    required String outputPath,
    int x = 10,
    int y = 10,
  }) async {
    final command =
        "-i $videoPath -i $imagePath -filter_complex overlay=$x:$y $outputPath";

    await FFmpegKit.execute(command);
  }

  /// Change playback speed
  static Future<void> changeSpeed({
    required String inputPath,
    required String outputPath,
    double speed = 1.0, // <1 = slow, >1 = fast
  }) async {
    final setpts = 1 / speed; // FFmpeg uses multiplier of PTS
    final command = "-i $inputPath -filter:v setpts=$setpts*PTS $outputPath";

    await FFmpegKit.execute(command);
  }

  /// Adjust volume
  static Future<void> changeVolume({
    required String inputPath,
    required String outputPath,
    double factor = 1.0, // 0.5 = half, 2.0 = double
  }) async {
    final command = "-i $inputPath -filter:a volume=$factor $outputPath";

    await FFmpegKit.execute(command);
  }

  /// Resize video to [width] x [height]
  static Future<void> resizeVideo({
    required String inputPath,
    required String outputPath,
    int width = 1280,
    int height = 720,
  }) async {
    final command = "-i $inputPath -vf scale=$width:$height $outputPath";

    await FFmpegKit.execute(command);
  }

  /// Crop video
  static Future<void> cropVideo({
    required String inputPath,
    required String outputPath,
    required int width,
    required int height,
  }) async {
    final command = "-i $inputPath -vf crop=$width:$height $outputPath";

    await FFmpegKit.execute(command);
  }

  /// Add text overlay
  static Future<void> addText({
    required String inputPath,
    required String outputPath,
    required String text,
    int x = 50,
    int y = 50,
    int fontSize = 24,
    String fontColor = "white",
  }) async {
    final command =
        "-i $inputPath -vf drawtext=text='$text':x=$x:y=$y:fontsize=$fontSize:fontcolor=$fontColor $outputPath";

    await FFmpegKit.execute(command);
  }
  /// Add text overlay to a video using FFmpeg
  static Future<String?> addTextToVideo({
    required String inputPath,
    required String text,
    String fontColor = "white",
    int fontSize = 40,
    int x = 50,
    int y = 50,
    bool withBox = false,
  }) async {
    try {
      // Get temporary output directory
      final dir = await getTemporaryDirectory();
      final outputPath =
          "${dir.path}/video_with_text_${DateTime.now().millisecondsSinceEpoch}.mp4";

      // FFmpeg drawtext filter
      final drawText =
          withBox
              ? "drawtext=text='$text':fontcolor=$fontColor:fontsize=$fontSize:box=1:boxcolor=black@0.5:boxborderw=10:x=$x:y=$y"
              : "drawtext=text='$text':fontcolor=$fontColor:fontsize=$fontSize:x=$x:y=$y";

      final command =
          "-i $inputPath -vf \"$drawText\" -codec:a copy $outputPath";

      // Run FFmpeg
      final session = await FFmpegKit.execute(command);
      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        return outputPath; // success
      } else {
        debugPrint("❌ FFmpeg failed with code: $returnCode");
        return null;
      }
    } catch (e) {
      debugPrint("⚠️ Error in addTextToVideo: $e");
      return null;
    }
  }

  /// Generate a thumbnail (JPG) from video
  static Future<String?> generateThumbnail({
    required String inputPath,
    int timeInSeconds = 1,
  }) async {
    try {
      // Save thumbnail in temporary directory
      final dir = await getTemporaryDirectory();
      final outputPath =
          "${dir.path}/thumb_${DateTime.now().millisecondsSinceEpoch}.jpg";

      // FFmpeg command to extract a frame
      final command =
          "-i $inputPath -ss $timeInSeconds -vframes 1 -q:v 2 $outputPath";

      final session = await FFmpegKit.execute(command);
      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        return outputPath; // ✅ success
      } else {
        debugPrint("❌ Thumbnail generation failed with code: $returnCode");
        return null;
      }
    } catch (e) {
      debugPrint("⚠️ Error in generateThumbnail: $e");
      return null;
    }
  }
  /// Generate a thumbnail image (File) from a video
  static Future<File?> generateThumbnailImage({
    required String inputPath,
    int timeInSeconds = 1,
    String format = "jpg", // jpg or png
  }) async {
    try {
      // Save thumbnail in temporary directory
      final dir = await getTemporaryDirectory();
      final outputPath =
          "${dir.path}/thumb_${DateTime.now().millisecondsSinceEpoch}.$format";

      // FFmpeg command to extract one frame
      final command =
          "-i $inputPath -ss $timeInSeconds -vframes 1 -q:v 2 $outputPath";

      final session = await FFmpegKit.execute(command);
      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        return File(outputPath); // ✅ Return image file
      } else {
       debugPrint("❌ Thumbnail generation failed with code: $returnCode");
        return null;
      }
    } catch (e) {
      debugPrint("⚠️ Error in generateThumbnail: $e");
      return null;
    }
  }

  /// resize a video to a given size


static Future<File?> resizeVideoForMobile(File inputFile) async {
    try {
      final dir = await getTemporaryDirectory();
      final outputPath =
          '${dir.path}/${DateTime.now().millisecondsSinceEpoch}_resized.mp4';

      final command =
          '-i "${inputFile.path}" -vf "scale=-2:720" -c:v libx264 -preset ultrafast -crf 28 -c:a copy "$outputPath"';

      final session = await FFmpegKit.execute(command);
      final returnCode = await session.getReturnCode();

      if (returnCode != null && returnCode.isValueSuccess()) {
        return File(outputPath);
      } else {
        debugPrint("❌ Resize video failed with code: $returnCode");
        return null;
      }
    } catch (e) {
      debugPrint("Error in resizeVideoForMobile $e");
      return null;
    }
  }
}
