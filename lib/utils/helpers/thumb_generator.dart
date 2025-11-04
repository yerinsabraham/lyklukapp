import 'dart:io';
import 'dart:typed_data';

import 'package:lykluk/core/services/logger_service.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ThumbnailGenerator {
  /// Get the application documents directory for storing thumbnails
  static Future<Directory> getThumbnailDirectory() async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final Directory thumbnailDir = Directory(
      path.join(appDocDir.path, 'thumbnails'),
    );

    if (!await thumbnailDir.exists()) {
      await thumbnailDir.create(recursive: true);
    }
    return thumbnailDir;
  }

  /// Get temporary directory for cache
  static Future<Directory> getTemporaryThumbnailDirectory() async {
    final Directory tempDir = await getTemporaryDirectory();
    final Directory thumbnailDir = Directory(
      path.join(tempDir.path, 'thumbnails'),
    );

    if (!await thumbnailDir.exists()) {
      await thumbnailDir.create(recursive: true);
    }
    return thumbnailDir;
  }

  /// Generate thumbnail from video file
  static Future<File?> generateThumbnail({
    required String videoPath,
    // required String thumbnailPath,
    int quality = 75,
    int maxHeight = 0, // 0 means original height
    int maxWidth = 0, // 0 means original width
    int timeMs = 0, // timestamp in milliseconds (0 = first frame)
  }) async {
    try {
      final temp = await getTemporaryThumbnailDirectory();
      final thumbnail = await VideoThumbnail.thumbnailFile(
        video: videoPath,
        thumbnailPath: temp.path,
        imageFormat: ImageFormat.JPEG,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
        quality: quality,
        timeMs: timeMs,
      );

      if (thumbnail != null) {
        return File(thumbnail);
      }
      return null;
    } catch (e) {
      log.d('Error generating thumbnail: $e');
      return null;
    }
  }

  /// Generate thumbnail as Uint8List (in-memory)
  static Future<Uint8List?> generateThumbnailBytes({
    required String videoPath,
    int quality = 75,
    int maxHeight = 0,
    int maxWidth = 0,
    int timeMs = 0,
  }) async {
    try {
      final uint8list = await VideoThumbnail.thumbnailData(
        video: videoPath,
        imageFormat: ImageFormat.JPEG,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
        quality: quality,
        timeMs: timeMs,
      );

      return uint8list;
    } catch (e) {
      log.d('Error generating thumbnail bytes: $e');
      return null;
    }
  }
}
