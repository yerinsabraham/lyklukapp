import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

String getImageContentType(String filePath) {
  final ext = path.extension(filePath).toLowerCase().replaceFirst('.', '');

  switch (ext) {
    case 'jpg':
    case 'jpeg':
      return 'image/jpeg';
    case 'png':
      return 'image/png';
    case 'gif':
      return 'image/gif';
    case 'webp':
      return 'image/webp';
    case 'bmp':
      return 'image/bmp';
    case 'heic':
      return 'image/heic';
    default:
      return 'application/octet-stream'; // fallback for unknown types
  }
}

// Dynamic video content-type
String getVideoContentType(String filePath) {
  final ext = path.extension(filePath).toLowerCase().replaceFirst('.', '');
  return 'video/$ext';
}

/// Rename the .temp file to .mp4 and save it
  Future<File> renameTempToMp4(XFile file) async {
    final directory = await getTemporaryDirectory(); // Use temporary directory
    final tempFile = File(file.path);

    // Create a new file path with .mp4 extension
    final newFilePath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.mp4';

    // Rename the file
    final newFile = await tempFile.rename(newFilePath);

    return newFile;
  }
