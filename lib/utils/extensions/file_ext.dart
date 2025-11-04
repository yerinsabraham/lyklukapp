import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

extension FileExt on File {
  Future<MultipartFile> get fromMultiPart {
    return MultipartFile.fromFile(
      path,
      filename: path.split('/').last,
      contentType: MediaType('image', path.split('/').last.split('.').last),
    );
  }

  String get toBase64 {
    return base64Encode(readAsBytesSync());
  }

  String get fileExtension {
    return path.split('.').last;
  }

  String get fileName {
    return path.split('/').last;
  }

  /// in either KB.MB.GB format
  String get size {
    double size = lengthSync() / 1024;
    if (size < 1024) {
      return "${size.toStringAsFixed(2)} KB";
    } else {
      size /= 1024;
      if (size < 1024) {
        return "${size.toStringAsFixed(2)} MB";
      } else {
        size /= 1024;
        return "${size.toStringAsFixed(2)} GB";
      }
    }
  }
}
