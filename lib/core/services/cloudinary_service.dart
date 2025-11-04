import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart' as crypto;
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:lykluk/core/services/network/endpoints.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/key.dart';
import 'package:lykluk/utils/storage/local_storage.dart';

import 'services.dart';

enum CloudinaryType { image, video, document }

class CloudinaryService {
  static const String cloudName = 'dja8bhkad';
  static const String cloudinaryBaseUrl =
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload';
  static const String cloudinaryVideoUrl =
      'https://api.cloudinary.com/v1_1/$cloudName/video/upload';
  static const String cloudinaryDocumentUrl =
      'https://api.cloudinary.com/v1_1/$cloudName/raw/upload';

  /// upload image to cloudinary and return the url
  static Future<ApiResponse> getImageUrl({
    required String publicId,
    required File file,
    required String preset,
    Function(double)? onSendProgress,
  }) async {
    try {
      // final timeStamp = DateTime.now().millisecondsSinceEpoch;

      final request = await Dio().post(
        cloudinaryBaseUrl,
        onSendProgress: (sent, total) {
          log.d('Sent: $sent, Total: $total');
          onSendProgress?.call((sent / total));
        },
        data: FormData.fromMap({
          'file': await MultipartFile.fromFile(file.path),
          'upload_preset': preset,
          'public_id': publicId,
          'api_key': cloudinaryApikey,
          'q_auto': 'good',
        }),
      );
      log.d(request.data);
      return ApiResponse.response(request, request.headers);
    } on DioException catch (e, s) {
      log
        ..d('Dio Exception')
        ..d(e, stackTrace: s);
      return e.toApiError();
    } on SocketException catch (e, s) {
      log
        ..d('socket Exception')
        ..d(e, stackTrace: s);
      return ApiResponse(
        isSuccessful: false,
        message: 'Please check your internet connection or try again later',
      );
    } on Exception catch (e, s) {
      log
        ..d('Exception')
        ..d(e, stackTrace: s);
      return ApiResponse(isSuccessful: false, message: e.toString());
    }
  }

  static Future<ApiResponse> getImageUrlFromPath({
    required String publicId,
    required String filepath,
    required String preset,
  }) async {
    try {
      final file = File(filepath);
      // final timeStamp = DateTime.now().millisecondsSinceEpoch;
      final request = await Dio().post(
        cloudinaryBaseUrl,
        data: FormData.fromMap({
          'file': await MultipartFile.fromFile(file.path),
          'upload_preset': preset,
          'public_id': publicId,
          'api_key': cloudinaryApikey,
          'q_auto': 'good',
        }),

        // 'transformation': 'q_auto:good',
        // 'transformation': 'q_60',
        // 'timestamp': timeStamp,
        // 'signature':
        // generateSignature(timeStamp.toString(), cloudinaryApiSecretkey),
      );
      log.d(request.data);
      return ApiResponse.response(request, request.headers);
    } on DioException catch (e, s) {
      log
        ..d('Dio Exception')
        ..d(e, stackTrace: s);
      return e.toApiError();
    } on SocketException catch (e, s) {
      log
        ..d('socket Exception')
        ..d(e, stackTrace: s);
      return ApiResponse(
        isSuccessful: false,
        message: 'Please check your internet connection or try again later',
      );
    } on Exception catch (e, s) {
      log
        ..d('Exception')
        ..d(e, stackTrace: s);
      return ApiResponse(isSuccessful: false, message: e.toString());
    }
  }

  static String generateSignature(String timestamp, String apiSecret) {
    var digest = utf8.encode("timestamp=$timestamp$apiSecret");
    var sha1 = crypto.sha1;
    var hmac = crypto.Hmac(sha1, apiSecret.codeUnits);
    var signedBytes = hmac.convert(digest);
    return signedBytes.toString();
  }

  //// upload video
  static Future<ApiResponse> uploadVideo({
    required File file,
    required String publicId,
    Function(double)? onSendProgress,
  }) async {
    try {
      final request = await Dio().post(
        cloudinaryVideoUrl,
        onSendProgress: (sent, total) {
          log.d('Sent: $sent, Total: $total');
          onSendProgress?.call((sent / total));
        },
        data: FormData.fromMap({
          'file': await MultipartFile.fromFile(file.path),
          'public_id': publicId,
          'upload_preset': cloudinaryChallengePreset,
          'resource_type': 'video',
          'api_key': cloudinaryApikey,
          // 'transformation': 'q_auto:good',
          'q_auto': 'good',
        }),
      );
      log.d(request.data);
      // final f = Dio().post('').asStream();
      return ApiResponse.response(request, request.headers);
    } on DioException catch (e, s) {
      log
        ..d('Dio Exception')
        ..d(e, stackTrace: s);
      return e.toApiError();
    } on SocketException catch (e, s) {
      log
        ..d('socket Exception')
        ..d(e, stackTrace: s);
      return ApiResponse(
        isSuccessful: false,
        message: 'Please check your internet connection or try again later',
      );
    } catch (e, s) {
      log
        ..d('Exception')
        ..d(e, stackTrace: s);
      return ApiResponse(isSuccessful: false, message: e.toString());
    }
  }

  //// upload video
  static Future<ApiResponse> uploadVideoFromPath({
    required String filepath,
    required String publicId,
  }) async {
    final file = File(filepath);
    try {
      final request = await Dio().post(
        cloudinaryVideoUrl,
        data: FormData.fromMap({
          'file': await MultipartFile.fromFile(file.path),
          'public_id': publicId,
          'upload_preset': cloudinaryChallengePreset,
          'resource_type': 'video',
          'api_key': cloudinaryApikey,
          // 'transformation': 'q_auto:good',
          'q_auto': 'good',
        }),
      );
      log.d(request.data);
      return ApiResponse.response(request, request.headers);
    } on DioException catch (e, s) {
      log
        ..d('Dio Exception')
        ..d(e, stackTrace: s);
      return e.toApiError();
    } on SocketException catch (e, s) {
      log
        ..d('socket Exception')
        ..d(e, stackTrace: s);
      return ApiResponse(
        isSuccessful: false,
        message: 'Please check your internet connection or try again later',
      );
    } catch (e, s) {
      log
        ..d('Exception')
        ..d(e, stackTrace: s);
      return ApiResponse(isSuccessful: false, message: e.toString());
    }
  }

  /// upload from path
  static Future<ApiResponse> uploadFileFromPath({
    required String filepath,
    required String publicId,
    required String preset,
    required CloudinaryType type,
  }) async {
    log.d('file type ${type == CloudinaryType.video ? 'video' : 'image'}');

    try {
      if (type == CloudinaryType.video) {
        final request = await uploadVideo(
          file: File(filepath),
          publicId: publicId,
        );
        log.d(request.data);
        return request;
      } else {
        final request = await getImageUrlFromPath(
          publicId: publicId,
          filepath: filepath,
          preset: preset,
        );
        log.d(request.data);
        return request;
      }
    } catch (e) {
      LoggerService.logError(
        error: e,
        reason: 'CloudinaryService-- Error uploading asset',
      );
      return ApiResponse(
        isSuccessful: false,
        message: 'An error occurred, please try again later',
      );
    }
  }

  /// upload Document
  static Future<ApiResponse> uploadDocument({
    required File file,
    required String publicId,
    Function(double)? onSendProgress,
  }) async {
    try {
      final request = await Dio().post(
        cloudinaryDocumentUrl,
        onSendProgress: (sent, total) {
          log.d('Sent: $sent, Total: $total');
          onSendProgress?.call((sent / total));
        },
        data: FormData.fromMap({
          'file': await MultipartFile.fromFile(file.path),
          'public_id': publicId,
          'upload_preset': cloudinaryChallengePreset,
          'resource_type': 'auto',
          'api_key': cloudinaryApikey,
          'q_auto': 'good',
        }),
      );
      log.d(request.data);
      return ApiResponse.response(request, request.headers);
    } on DioException catch (e, s) {
      log
        ..d('Dio Exception')
        ..d(e, stackTrace: s);
      return e.toApiError();
    } on SocketException catch (e, s) {
      log
        ..d('socket Exception')
        ..d(e, stackTrace: s);
      return ApiResponse(
        isSuccessful: false,
        message: 'Please check your internet connection or try again later',
      );
    } catch (e, s) {
      log
        ..d('Exception')
        ..d(e, stackTrace: s);
      return ApiResponse(isSuccessful: false, message: e.toString());
    }
  }

  /// upload to Firebase storage
  static Future<ApiResponse> uploadToFirebaseStorage({
    required File file,
    required String publicId,
    Function(double)? onSendProgress,
  }) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child(
        'uploads/$publicId${file.path.split('/').last}',
      );

      // Start the upload task
      UploadTask uploadTask = ref.putFile(file);
      // Listen to the progress of the upload
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        double progress = snapshot.bytesTransferred / snapshot.totalBytes;
        onSendProgress?.call(progress);
        if (snapshot.state == TaskState.success) {
          onSendProgress?.call(1.0);
        }
      });

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return ApiResponse(
        message: 'Upload successful',
        statusCode: 200,
        isSuccessful: true,
        data: {'url': downloadUrl},
      );
    } on SocketException catch (e, s) {
      log
        ..d('socket Exception')
        ..d(e, stackTrace: s);
      return ApiResponse(
        isSuccessful: false,
        message: 'Please check your internet connection or try again later',
      );
    } catch (e, s) {
      log
        ..d('Exception')
        ..d(e, stackTrace: s);
      return ApiResponse(isSuccessful: false, message: e.toString());
    }
  }
}

abstract class MediaUploadRepo {
  Future<ApiResponse> imageUpload({
    required Map<String, dynamic> data,
    Function(double)? onSendProgress,
  });
  Future<String> imageUpload2({
    required Map<String, dynamic> data,
    Function(double)? onSendProgress,
  });
  Future<ApiResponse> imageVideo({
    required Map<String, dynamic> data,
    Function(double)? onSendProgress,
  });
  Future<ApiResponse> imageFileUpload({
    required FormData data,
    Function(double)? onSendProgress,
  });
}

final mediaUploadRepoProvider = Provider<MediaUploadRepo>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return MediaUploadRepoImpl(apiService);
});

class MediaUploadRepoImpl implements MediaUploadRepo {
  final ApiService apiService;
  // final HttpService httpService;

  const MediaUploadRepoImpl(this.apiService);

  @override
  Future<ApiResponse> imageUpload({
    required Map<String, dynamic> data,
    Function(double)? onSendProgress,
  }) async {
    try {
      // final request = await http.post(
      //   Uri.parse(Endpoints.mediaUploadBaseUrl + Endpoints.mediaUploadPath),
      //   body: json.encode(data),
      // );
      final request = await Dio().post(
        Endpoints.mediaUploadBaseUrl + Endpoints.mediaUploadPath,
        data: data,
        onSendProgress: (received, total) {
          onSendProgress?.call((received / total));
        },
        options: Options(
          responseType: ResponseType.plain,
          receiveTimeout: const Duration(seconds: 6000),
          sendTimeout: const Duration(seconds: 6000),
        ),
      );
      if ((request.statusCode ?? 0) >= 200) {
        log.d(request.data);
        // log.d('This is response ${request.body}');
        return ApiResponse(
          isSuccessful: true,
          message: 'Upload successful',
          data: request.data,
          statusCode: request.statusCode,
        );
      } else if (request.statusCode == 413) {
        return ApiResponse(
          isSuccessful: false,
          message: 'File too large',
          data: request.data,
          statusCode: request.statusCode,
        );
      } else {
        return ApiResponse(
          isSuccessful: false,
          message: 'Upload failed',
          // data: json.decode(request.body),
          data: request.data,
          statusCode: request.statusCode,
        );
      }
    } on DioException catch (e, s) {
      log
        ..d('Dio Exception')
        ..d(e, stackTrace: s);
      return e.toApiError();
    } on SocketException catch (e, s) {
      log
        ..d('socket Exception')
        ..d(e, stackTrace: s);
      return ApiResponse(
        isSuccessful: false,
        message: 'Please check your internet connection or try again later',
      );
    } catch (e, s) {
      log
        ..d('Exception')
        ..d(e, stackTrace: s);
      return ApiResponse(isSuccessful: false, message: e.toString());
    }
  }

  @override
  Future<String> imageUpload2({
    required Map<String, dynamic> data,
    Function(double)? onSendProgress,
  }) async {
    try {
      final request = await http.post(
        Uri.parse(Endpoints.mediaUploadBaseUrl + Endpoints.mediaUploadPath),
        body: json.encode(data),
      );
      if (request.statusCode == 200) {
        // final data = json.decode(request.body);
        // log.d(data);
        // log.d('This is response ${request.body}');
        // return ApiResponse(
        //   isSuccessful: true,
        //   message: 'Upload successful',
        //   data: data,
        //   statusCode: request.statusCode,
        // );
        return request.body;
      } else if (request.statusCode == 413) {
        // return ApiResponse(
        //   isSuccessful: false,
        //   message: 'File too large',
        //   data: data,
        //   statusCode: request.statusCode,
        // );
        throw "File too large";
      } else {
        // return ApiResponse(
        //   isSuccessful: false,
        //   message: 'Upload failed',
        //   // data: json.decode(request.body),
        //   data: json.decode(request.body),
        //   statusCode: request.statusCode,
        // );
        throw "Upload file failed";
      }
    } on SocketException catch (e, s) {
      log
        ..d('socket Exception')
        ..d(e, stackTrace: s);
      // return ApiResponse(
      //   isSuccessful: false,
      //   message: 'Please check your internet connection or try again later',
      // );
      throw "Please check your internet connection or try again later";
    } catch (e, s) {
      log
        ..d('Exception')
        ..d(e, stackTrace: s);
      // return ApiResponse(
      //   isSuccessful: false,
      //   message: e.toString(),
      // );
      // throw e.toString();
      rethrow;
    }
  }

  @override
  Future<ApiResponse> imageVideo({
    required Map<String, dynamic> data,
    Function(double)? onSendProgress,
  }) async {
    try {
      final request = await Dio(
        BaseOptions(
          responseType: ResponseType.plain,
          connectTimeout: const Duration(seconds: 6000),
          receiveTimeout: const Duration(seconds: 6000),
          sendTimeout: const Duration(seconds: 6000),
        ),
      ).post(
        Endpoints.mediaUploadBaseUrl + Endpoints.mediaUploadPath,
        data: data,
        onSendProgress: (received, total) {
          onSendProgress?.call((received / total));
        },
      );
      if ((request.statusCode ?? 0) >= 200) {
        // log.d('This is response ${request.body}');
        log.d(request.data);
        return ApiResponse(
          isSuccessful: true,
          message: 'Upload successful',
          data: request.data,
          statusCode: request.statusCode,
        );
      } else {
        return ApiResponse(
          isSuccessful: false,
          message: 'Upload failed',
          // data: json.decode(request.body),
          data: request.data,
          statusCode: request.statusCode,
        );
      }
    } on DioException catch (e, s) {
      log
        ..d('Dio Exception')
        ..d(e, stackTrace: s);
      return e.toApiError();
    } on SocketException catch (e, s) {
      log
        ..d('socket Exception')
        ..d(e, stackTrace: s);
      return ApiResponse(
        isSuccessful: false,
        message: 'Please check your internet connection or try again later',
      );
    } catch (e, s) {
      log
        ..d('Exception')
        ..d(e, stackTrace: s);
      return ApiResponse(isSuccessful: false, message: e.toString());
    }
  }
  
  @override
  Future<ApiResponse> imageFileUpload({required FormData data, Function(double p1)? onSendProgress}) async{
     try {
       final staticHeaders =
          {
            "app_token":
                "Date: eyyryyegdujc${DateTime.now().toUtc().microsecondsSinceEpoch}",
            'Authorization':
                HiveStorage.accessToken.isEmpty
                    ? null
                    : 'Bearer ${HiveStorage.accessToken}',
          }.removeNullValues;
      final head = staticHeaders;

      final request = await Dio().post(
        Endpoints.mediaUploadBaseUrl + Endpoints.editProfilePic,
        data: data,
        onSendProgress: (received, total) {
          onSendProgress?.call((received / total));
        },
        options: Options(
          headers: head,
          responseType: ResponseType.plain,
          receiveTimeout: const Duration(seconds: 6000),
          sendTimeout: const Duration(seconds: 6000),
        ),
      );
      if ((request.statusCode ?? 0) >= 200) {
        log.d(request.data);
        // log.d('This is response ${request.body}');
        return ApiResponse(
          isSuccessful: true,
          message: 'Upload successful',
          data: request.data,
          statusCode: request.statusCode,
        );
      } else if (request.statusCode == 413) {
        return ApiResponse(
          isSuccessful: false,
          message: 'File too large',
          data: request.data,
          statusCode: request.statusCode,
        );
      } else {
        return ApiResponse(
          isSuccessful: false,
          message: 'Upload failed',
          // data: json.decode(request.body),
          data: request.data,
          statusCode: request.statusCode,
        );
      }
    } on DioException catch (e, s) {
      log
        ..d('Dio Exception')
        ..d(e, stackTrace: s);
      return e.toApiError();
    } on SocketException catch (e, s) {
      log
        ..d('socket Exception')
        ..d(e, stackTrace: s);
      return ApiResponse(
        isSuccessful: false,
        message: 'Please check your internet connection or try again later',
      );
    } catch (e, s) {
      log
        ..d('Exception')
        ..d(e, stackTrace: s);
      return ApiResponse(isSuccessful: false, message: e.toString());
    }
  }
}
