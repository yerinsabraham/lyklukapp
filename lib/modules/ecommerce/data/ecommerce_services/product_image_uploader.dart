import 'dart:async';
import 'dart:isolate';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:lykluk/core/services/network/endpoints.dart';
import 'package:lykluk/utils/storage/local_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'upload_event.dart';

class ProductImageUploadService {
  static final ProductImageUploadService _instance =
      ProductImageUploadService._internal();
  factory ProductImageUploadService() => _instance;
  ProductImageUploadService._internal();

  late Box _cacheBox;
  final StreamController<UploadEvent> _uploadStream =
      StreamController.broadcast();

  Stream<UploadEvent> get stream => _uploadStream.stream;

  Future<void> init() async {
    _cacheBox = await Hive.openBox('pending_uploads');
    _resumePending();
  }

  Future<void> _resumePending() async {
    for (final key in _cacheBox.keys) {
      final upload = PendingUpload.fromJson(
        Map<String, dynamic>.from(_cacheBox.get(key)),
      );
      startUpload(HiveStorage.accessToken, upload);
    }
  }

  Future<void> enqueueUpload(String token, PendingUpload upload) async {
    await _cacheBox.put(upload.productId, upload.toJson());
    startUpload(token, upload);
  }

  Future<void> startUpload(String token, PendingUpload upload) async {
    final receivePort = ReceivePort();

    await Isolate.spawn(_uploadWorker, [
      token,
      upload.productId,
      upload.imagePaths,
      receivePort.sendPort,
    ]);

    receivePort.listen((message) async {
      if (message['type'] == 'progress') {
        _uploadStream.add(
          UploadEvent.progress(
            productId: upload.productId,
            progress: message['progress'],
          ),
        );
      } else if (message['type'] == 'success') {
        await _cacheBox.delete(upload.productId);
        final urls = List<String>.from(message['data']['imageUrls']);
        _uploadStream.add(
          UploadEvent.success(
            productId: upload.productId,
            imageUrls: urls,
            storeId: upload.storeId,
          ),
        );
        receivePort.close();
      } else if (message['type'] == 'error') {
        if (upload.retryCount < 3) {
          upload.retryCount++;
          await Future.delayed(
            Duration(seconds: pow(2, upload.retryCount).toInt()),
          );
          startUpload(token, upload);
        } else {
          _uploadStream.add(
            UploadEvent.error(
              productId: upload.productId,
              error: message['error'],
            ),
          );
          receivePort.close();
        }
      }
    });
  }
}

/// 🔄 Worker runs in separate isolate
Future<void> _uploadWorker(List<dynamic> args) async {
  final String token = args[0];
  final String productId = args[1];
  final List<String> imagePaths = List<String>.from(args[2]);
  final SendPort sendPort = args[3];

  final dio = Dio(BaseOptions(
    baseUrl: Endpoints.apiV1,
    headers: {'Authorization': 'Bearer $token'}));
  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      compact: true,
      enabled: kDebugMode,
    ),
  );
  final formData = FormData();

  for (final path in imagePaths) {
    formData.files.add(MapEntry('images', await MultipartFile.fromFile(path, filename: path.split('/').last)));
  }

  try {
    final response = await dio.post(
      '/ecommerce/products/$productId/upload-images',
      data: formData,
      onSendProgress: (sent, total) {
        sendPort.send({'type': 'progress', 'progress': sent / total});
      },
    );
   
    sendPort.send({
      'type': 'success',
      'data': {'imageUrls': response.data['data']['product']['images']},
    });
  } catch (e) {
    sendPort.send({'type': 'error', 'error': e.toString()});
  }
}
