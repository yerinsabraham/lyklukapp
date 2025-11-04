import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lykluk/modules/posts/presentation/view_model/state/video_upload_state.dart';

final isRecordingProvider = StateProvider<bool>((ref) => false);

final videoRefreshProvider = StateProvider<bool>((ref) => false);

final videoUploadProvider =
    StateNotifierProvider<VideoUploadNotifier, VideoUploadState>(
      (ref) => VideoUploadNotifier(),
    );

class VideoUploadNotifier extends StateNotifier<VideoUploadState> {
  VideoUploadNotifier() : super(const VideoUploadState());

  final ImagePicker _picker = ImagePicker();

  Future<File?> pickFirstVideo() async {
    final picker = ImagePicker();
    final XFile? file = await picker.pickVideo(source: ImageSource.gallery);
    if (file == null) return null;
    return File(file.path);
  }

  /// Pick a video file safely without blocking on wrong permission
  Future<File?> pickFromGallery() async {
    // Request platform-specific permissions
    // if (Platform.isAndroid) {
    //   // On Android 13+ use READ_MEDIA_VIDEO, before that use storage
    //   final videoStatus = await Permission.videos.request();
    //   final storageStatus = await Permission.storage.request();

    //   if (!videoStatus.isGranted && !storageStatus.isGranted) {
    //     state = state.copyWith(error: "Storage or video permission denied");
    //     return null;
    //   }
    // } else if (Platform.isIOS) {
    //   final photosStatus = await Permission.photos.request();
    //   if (!photosStatus.isGranted) {
    //     state = state.copyWith(error: "Photos permission denied");
    //     return null;
    //   }
    // }

    // Open gallery for picking video
    final XFile? picked = await _picker.pickVideo(source: ImageSource.gallery);
    if (picked == null) return null;
    state = state.copyWith(filePath: picked.path);
    return File(picked.path);
  }

  /// Pick + upload in one go
  Future<void> pickAndUpload() async {
    final file = await pickFromGallery();
    if (file != null) {
      await _startUpload(file.path);
    }
  }

  /// Upload a file directly
  Future<void> uploadFromFile(File file) async {
    if (!file.existsSync()) {
      state = state.copyWith(error: "Recorded file not found");
      return;
    }
    await _startUpload(file.path);
  }

  /// Core uploader
  Future<void> _startUpload(String path) async {
    state = state.copyWith(
      isUploading: true,
      filePath: path,
      progress: 0,
      error: null,
    );

    // final options = VideoUploaderOptions(
    //   accessKey: VideoConstant.accessKey,
    //   secretKey: VideoConstant.secretKey,
    //   sessionToken: VideoConstant.sessionToken,
    //   serviceID: VideoConstant.serviceId,
    //   filePaths: [path],
    // );

    // final BDVideoUploader uploader = await initVideoUploader(options);

    // uploader.setListener(
    // VideoUploaderInfoCallback(
    //   onUploadSuccess: (uploadInfo) async {
    //     log.i('Upload success: ${jsonEncode(uploadInfo)}');
    //     state = state.copyWith(isUploading: false, progress: 1.0);
    //   },
    //   onUploadFail: (errorCode, errorMsg, uploadInfo) async {
    //     log.e(
    //       'Upload fail: $errorCode, $errorMsg, ${jsonEncode(uploadInfo)}',
    //     );
    //     state = state.copyWith(isUploading: false, error: errorMsg);
    //   },
    //   onUpdateProgress: (progress) {
    //     state = state.copyWith(progress: progress.toDouble());
    //   },
    // ),
    // );

    // await uploader.start();
  }
}
