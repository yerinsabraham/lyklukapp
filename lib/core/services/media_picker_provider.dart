import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lykluk/utils/theme/theme.dart';
import 'package:permission_handler/permission_handler.dart';

enum MediaTypes { image, video }

enum MediaSource { camera, gallery }

final mediaPickerProvider =
    StateNotifierProvider<MediaPickerNotifier, MediaPickerState>(
      (ref) => MediaPickerNotifier(),
    );

class MediaPickerState {
  final String? base64Data;
  final MediaTypes? mediaType;
  final File? file;
  final bool isLoading;
  final String? error;

  MediaPickerState({
    this.base64Data,
    this.mediaType,
    this.file,
    this.isLoading = false,
    this.error,
  });

  MediaPickerState copyWith({
    String? base64Data,
    MediaTypes? mediaType,
    File? file,
    bool? isLoading,
    String? error,
  }) {
    return MediaPickerState(
      base64Data: base64Data ?? this.base64Data,
      mediaType: mediaType ?? this.mediaType,
      file: file ?? this.file,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class MediaPickerNotifier extends StateNotifier<MediaPickerState> {
  MediaPickerNotifier() : super(MediaPickerState());

  final ImagePicker _picker = ImagePicker();

  Future<void> pickMedia(MediaTypes type, MediaSource source) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final ImageSource imageSource =
          source == MediaSource.camera
              ? ImageSource.camera
              : ImageSource.gallery;

      XFile? pickedFile;

      if (type == MediaTypes.image) {
        pickedFile = await _picker.pickImage(source: imageSource);
      } else {
        pickedFile = await _picker.pickVideo(source: imageSource);
      }

      if (pickedFile == null) {
        state = state.copyWith(isLoading: false, error: 'No file selected.');
        return;
      }

      final file = File(pickedFile.path);
      final bytes = await file.readAsBytes();
      final base64String = base64Encode(bytes);

      state = state.copyWith(
        isLoading: false,
        file: file,
        mediaType: type,
        base64Data: base64String,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void reset() {
    state = MediaPickerState();
  }

  Future<void> showMediaPickerBottomSheet({
    required BuildContext context,
    required MediaPickerNotifier mediaNotifier,
    MediaTypes mediaType = MediaTypes.image,
  }) async {
    Future<void> requestPermissions() async {
      await [Permission.camera, Permission.photos].request();
    }

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 10.h,
                ),
                leading: const Icon(
                  Icons.camera_alt,
                  color: Color(AppColors.primaryColor),
                ),
                title: AppText(text: 'Take a Picture'),
                onTap: () async {
                  Navigator.pop(context);
                  await requestPermissions();
                  await mediaNotifier.pickMedia(mediaType, MediaSource.camera);
                },
              ),
              Divider(indent: 20.w, endIndent: 20.w, thickness: .2.h),
              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                  color: Color(AppColors.primaryColor),
                ),
                title: AppText(text: 'Choose from Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  await requestPermissions();
                  await mediaNotifier.pickMedia(mediaType, MediaSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
