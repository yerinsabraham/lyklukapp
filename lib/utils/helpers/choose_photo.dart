// ignore_for_file: use_build_context_synchronously



import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lykluk/core/services/image_upload_service.dart';
import 'package:lykluk/modules/profile/presentation/view_model/providers/profile_provider.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';


// import 'package:images_picker/images_picker.dart';



Future<String?> chooseImageBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    constraints: BoxConstraints(maxHeight: context.height*0.3),
    builder: (_) {
      return Container(
        decoration: const BoxDecoration(
         
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        // height: 200.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 24.h),
             Text(
              'Upload from',
              style: context.body16Light
            ),
            SizedBox(height: 24.h),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () async {
                   
                    final instance = ImagePicker();
                    final res =
                        await instance.pickImage(source: ImageSource.camera);

                    debugPrint('Camera Response');
                    debugPrint(res.toString());

                    if (res != null) {
                      return context.pop(res.path);
                    } else {
                      context.pop();
                    }
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 34.w,
                        height: 40.h,
                        padding: const EdgeInsets.only(left: 5).w,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: const Icon(
                          CupertinoIcons.camera,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 12.w),
                       Text(
                        'Camera',
                        style: context.body16Light
                      ),
                    ],
                  ),
                ),
                const Divider(),
                TextButton(
                  onPressed: () async {
                 
                    final instance = ImagePicker();
                    final res = await instance.pickMultiImage();

                    if (res.isNotEmpty) {
                      return Navigator.pop(context, res[0].path);
                    } else {
                      return Navigator.pop(context);
                    }
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: const Icon(
                          CupertinoIcons.photo_on_rectangle,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 6.w),
                       Text(
                        'Gallery',
                        style: context.body16Light
                      )
                    ],
                  ),
                ),
              ],
            ),
            // SizedBox(height: .h),
            30.sH,
          ],
        ),
      );
    },
  );
}

/// choose video from camera or gallery
Future<String?> chooseVideoBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
     backgroundColor: Colors.white,
    constraints: BoxConstraints(maxHeight: context.height * 0.3),
    builder: (_) {
      return Container(
        decoration: const BoxDecoration(
        
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        // height: 200.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 24.h),
             Text(
              'Upload from',
            style: context.body16Light
            ),
            SizedBox(height: 24.h),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () async {
                    // List<Media>? res = await ImagesPicker.openCamera(
                    //   pickType: PickType.video,
                    //   cropOpt: CropOption(
                    //     aspectRatio: const CropAspectRatio(1, 1),
                    //   ),
                    // );
                    final instance = ImagePicker();
                    final res =
                        await instance.pickVideo(source: ImageSource.camera);

                    debugPrint('Camera Response');
                    debugPrint(res.toString());

                    if (res != null) {
                      return context.pop(res.path);
                    } else {
                      context.pop();
                    }
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 34.w,
                        height: 40.h,
                        padding: const EdgeInsets.only(left: 5).w,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: const Icon(
                          CupertinoIcons.camera,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 12.w),
                       Text(
                        'Camera',
                        style:context.body16Light
                      ),
                    ],
                  ),
                ),
                const Divider(),
                TextButton(
                  onPressed: () async {
                    // List<Media>? res = await ImagesPicker.pick(
                    //   count: 1,
                    //   pickType: PickType.video,
                    //   cropOpt: CropOption(
                    //     aspectRatio: const CropAspectRatio(1, 1),
                    //   ),
                    // );
                    final instance = ImagePicker();
                    final res =
                        await instance.pickVideo(source: ImageSource.gallery);

                    if (res != null) {
                      return Navigator.pop(context, res.path);
                    } else {
                      return Navigator.pop(context);
                    }
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: const Icon(
                          CupertinoIcons.photo_on_rectangle,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 6.w),
                       Text(
                        'Gallery',
                         style: context.body16Light
                      )
                    ],
                  ),
                ),
              ],
            ),
            30.sH,
          ],
        ),
      );
    },
  );
}

/// choose video from camera or gallery
Future<String?> chooseFileBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    constraints: BoxConstraints(maxHeight: context.height * 0.3),
    builder: (_) {
      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        // height: 200.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 24.h),
            Text('Upload from', style: context.body16Light),
            SizedBox(height: 24.h),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               
                TextButton(
                  onPressed: () async {
                 
                    // final res =
                    //     await FilePicker.platform.pickFiles();
                    final res =
                        await FilePicker.platform.pickFiles();

                    if (res != null) {
                      return Navigator.pop(context, res.files.single.path);
                    } else {
                      return Navigator.pop(context);
                    }
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: const Icon(
                          CupertinoIcons.photo_on_rectangle,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text('Gallery', style: context.body16Light)
                    ],
                  ),
                ),
              ],
            ),
            30.sH,
          ],
        ),
      );
    },
  );
}


// Pick image from gallery or camera and upload
Future<void> pickImageBottomSheet(
  BuildContext context,
  WidgetRef ref,
  Uploader uploader,
  profileNotifier,
) async {
  final picker = ImagePicker();

  await showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (c) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 50.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            SizedBox(height: 20.h),

            // Choose from gallery
            ListTile(
              trailing: Padding(
                padding: const EdgeInsets.fromLTRB(0,0, 15, 0),
                child: SvgPicture.asset(
                IconAssets.galleryIcon,
                height: 24.h,
                width: 24.w,
              ),
              ),    
                title: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Text('Choose from library', style: context.body16Bold),
              ),
              onTap: () async {
                Navigator.of(c).pop();
                final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
                if (picked != null) await _uploadImage(context, ref, uploader, profileNotifier, File(picked.path));
              },
            ),

            // Take a photo
            ListTile(
              trailing: Padding(
                padding: const EdgeInsets.fromLTRB(0,0, 15, 0),
                child: SvgPicture.asset(
                IconAssets.cameraIcons,
                height: 24.h,
                width: 24.w,
              ),
              ),
              title: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Text('Take photo', style: context.body16Bold),
              ),
              onTap: () async {
                Navigator.of(c).pop();
                final picked = await picker.pickImage(source: ImageSource.camera, imageQuality: 85);
                if (picked != null) await _uploadImage(context, ref, uploader, profileNotifier, File(picked.path));
              },
            ),

            // Delete
            ListTile(
              trailing: Padding(
                padding: const EdgeInsets.fromLTRB(0,0, 15, 0),
                child: SvgPicture.asset(
                  IconAssets.deleteIcon,
                  height: 24.h,
                  width: 24.w,
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Text('Delete', style: context.body16Bold.copyWith(color: Colors.red)),
              ),
              onTap: () async {
                Navigator.of(c).pop();
                final confirm = await showDialog(
                  context: context,
                  builder: (d) => AlertDialog(
                    backgroundColor: Colors.white,
                    title: Text('Remove Profile Picture?',style: context.body16Bold),
                    content: Text('Are you sure you want to delete your profile picture?'),
                    actions: [
                      TextButton(onPressed: () => Navigator.of(d).pop(false), child: Text('Cancel')),
                      TextButton(onPressed: () => Navigator.of(d).pop(true), child: Text('Delete')),
                    ],
                  ),
                );
                if (confirm == true) {
                  await profileNotifier.editProfilePic(avatar: null);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Profile picture removed',style: context.body16Bold.copyWith(color: context.colorScheme.primary))),
                  );
                }
              },
            ),

            SizedBox(height: 12.h),

            // Info note
            Container(
              padding: EdgeInsets.all(12.h),
              decoration: BoxDecoration(
                color: const Color(0xFFF4EDF7),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.purple, size: 20.r),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Your profile picture is visible to everyone on and off LykLuk',
                      style: context.body14.copyWith(
                  color: context.colorScheme.primary
                    ),
                  )),
                ],
              ),
            ),
             SizedBox(height: 12.h),
          ],
        ),
      );
    },
  );
}

// Upload image to server and update profile picture
Future<void> _uploadImage(
  BuildContext context,
  WidgetRef ref,
  Uploader uploader,
  profileNotifier,
  File file,
) async {
  final snack = ScaffoldMessenger.of(context);
  try {
    
     snack.showSnackBar(SnackBar(content: Text('Uploading image...',style: context.body14.copyWith(
                  color: context.colorScheme.primary))));

    final uploadedUrl = await uploader.uploadProfileImage(
      imagePath: file,
      onProgress: (p) {
        snack.hideCurrentSnackBar();
      },
    );

    if (uploadedUrl == null) {
      snack.hideCurrentSnackBar();
      return;
    }

    ref.invalidate(profileProvider);
    
    snack.hideCurrentSnackBar();
    snack.showSnackBar(SnackBar(content: Text('Profile picture updated',style: context.body14.copyWith(
                  color: context.colorScheme.primary))));
  } catch (e) {
    snack.hideCurrentSnackBar();
    snack.showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
  }
}

