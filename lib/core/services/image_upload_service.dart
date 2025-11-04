import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lykluk/core/services/services.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:uuid/uuid.dart';

import 'cloudinary_service.dart';

final uploaderProvider = Provider((ref) {
  final mediaService = ref.watch(mediaUploadRepoProvider);
  return Uploader(mediaService, ref);
});

class Uploader {
  final MediaUploadRepo _mediaUploadRepo;
  final Ref ref;
  const Uploader(this._mediaUploadRepo, this.ref);

  /// upload video
  Future<String?> uploadVideo() async {
    try {
      // List<Media>? res = await ImagesPicker.pick(
      //   count: 1,
      //   pickType: PickType.video,
      //   cropOpt: CropOption(
      //     aspectRatio: const CropAspectRatio(1, 1),
      //   ),
      // );
      final instance = ImagePicker();
      final res = await instance.pickVideo(source: ImageSource.gallery);
      if (res == null) {
        return null;
      }
      final uuid = const Uuid().v4();
      final response = await _mediaUploadRepo.imageVideo(
        data: {
          "fileType": "video",
          "fileName": "folder/$uuid.${File(res.path)}.mp4",
          "fileContent": File(res.path).toBase64,
        },
      );
      if (response.isSuccessful) {
        return response.data;
      } else {
        throw response.message ?? "Unable to upload video, try again later";
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: 'user cant upload video to cloudinary',
      );
      rethrow;
    }
  }

  /// upload image
  Future<String?> uploadImage({Function(double)? onSendProgress}) async {
    try {
      // List<Media>? res = await ImagesPicker.pick(
      //   count: 1,
      //   pickType: PickType.image,
      //   cropOpt: CropOption(
      //     aspectRatio: const CropAspectRatio(1, 1),
      //   ),
      // );
      final instance = ImagePicker();
      final res = await instance.pickImage(source: ImageSource.gallery);

      if (res == null) {
        return null;
      }

      File imageFile = File(res.path);
      Uint8List imageBytes = await imageFile.readAsBytes();

      // Get image dimensions
      ui.Codec codec = await ui.instantiateImageCodec(imageBytes);
      ui.FrameInfo frameInfo = await codec.getNextFrame();
      int width = frameInfo.image.width;
      int height = frameInfo.image.height;

      // Convert image to base64
      String base64Image = base64Encode(imageBytes);
      final uuid = const Uuid().v4();
      final data = {
        "fileType": "image",
        "fileName": "folder/$uuid.${imageFile.path.split('.').last}",
        "newDimensions": '${width}x$height',
        "fileContent": base64Image,
      };
      log.d(data);
      final response = await _mediaUploadRepo.imageUpload2(data: data);
      return response;

      // if (response.isSuccessful) {
      //   return response.data;
      // } else {
      //   throw response.message ?? "Unable to upload image, try again later";
      // }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: 'User cannot upload image to cloudinary',
      );
      rethrow;
    }
  }

   /// upload image
  Future<String?> uploadImageWithPicker({
    required File imagePath,
    String? dimension,
    Function(double)? onProgress,
  }) async {
    try {
      final uuid = const Uuid().v4();

      // Read image bytes
      Uint8List imageBytes = await imagePath.readAsBytes();
      ui.Codec codec = await ui.instantiateImageCodec(imageBytes);
      ui.FrameInfo frameInfo = await codec.getNextFrame();

      int width = frameInfo.image.width;
      int height = frameInfo.image.height;

      // Convert image to base64
      String base64Image = base64Encode(imageBytes);

      // Upload Image
      final response = await _mediaUploadRepo.imageUpload(
        onSendProgress: onProgress,
        data: {
          "fileType": "image",
          "fileName": "folder/$uuid.${imagePath.path.split('.').last}",
          "newDimensions": dimension ?? '${width}x$height',
          "fileContent": base64Image,
        },
      );

      if (response.isSuccessful) {
        return response.data;
      } else {
        throw response.message ?? "Unable to upload image, try again later";
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: 'User cannot upload image to cloudinary',
      );
      rethrow;
    }
  }

  /// Upload profile image
  Future<String?> uploadProfileImage({
    required File imagePath,
    String? dimension,
    Function(double)? onProgress,
  }) async {
    try {
      final uuid = const Uuid().v4();

      FormData formData = FormData.fromMap({
        'pic' : await MultipartFile.fromFile(imagePath.path, filename: "$uuid.${imagePath.path.split('.').last}"),
      });

      // Upload Image
      final response = await _mediaUploadRepo.imageFileUpload(
        onSendProgress: onProgress,
        data: formData,
      );

      if (response.isSuccessful) {
        return response.data;
      } else {
        throw response.message ?? "Unable to upload image, try again later";
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: 'User cannot upload image to cloudinary',
      );
      rethrow;
    }
  }
}
