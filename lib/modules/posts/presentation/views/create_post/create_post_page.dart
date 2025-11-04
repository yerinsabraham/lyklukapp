// ignore_for_file: unused_element

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/providers/auth_status_provider.dart';
import 'package:lykluk/core/shared/widgets/exit_button.dart';
import 'package:lykluk/modules/posts/presentation/view_model/state/post_state.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/components/post_settings_sheet.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/controllers/post_controller.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/controllers/video_sign_url_controller.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/constant/font_constant.dart';
import 'package:lykluk/utils/extensions/context_ext.dart';
import 'package:lykluk/utils/helpers/app_sheet.dart';
import 'package:lykluk/utils/helpers/toast_notification.dart';
import 'package:lykluk/utils/router/app_router.dart';
import 'package:lykluk/utils/theme/theme.dart';

import '../../../../../core/shared/widgets/auth_opt.dart';
import '../../../../../utils/helpers/show_sheet.dart';
import '../../view_model/notifiers/post_notifier.dart';

class CreatePostPage extends HookConsumerWidget {
  final VoidCallback? onOpenSettings;
  final VoidCallback? onOpenLocation;
  final VoidCallback? onPreview;
  // final File? videoFile;
  // final File? thumbnail;

  const CreatePostPage({
    super.key,
    this.onOpenSettings,
    this.onOpenLocation,
    this.onPreview,
    // this.videoFile,
    // this.thumbnail,
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStatus = ref.watch(authStateProvider);
    final notifier = ref.watch(postVideoSignUrlParamsController.notifier);
    final postNotifier = ref.watch(postParamsController.notifier);
       
    // Colors tuned to the mock
    const pageBg = Color(0xFFF6F7FB);
    final cs = Theme.of(context).colorScheme.primary;
    final primary = const Color(AppColors.primaryColor);
    final textStrong = const Color(AppColors.textColor3);
    final textSubtle = const Color(AppColors.textColor2);
    final descriptionText = useState<String?>(null);

    ref.listen(postNotifierProvider, (p, n) {
      n.maybeWhen(
        orElse: () {},
        uploaded: (m) {
          context.goNamed(Routes.navBarRoute);
          ToastNotification.showCustomNotification(
            title: 'Post uploaded',
            subtitle: "You have successfully uploaded your post",
            isSuccess: true,
          );
        },
        uploadError: (msg) {
          ToastNotification.showCustomNotification(
            title: 'Post uploaded Failed',
            subtitle: msg,
            isSuccess: false,
          );
        },
      );
    });
    final formkey = useState(GlobalKey<FormState>());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      postNotifier.state = postNotifier.state.copyWith(
        visibilty: 'Everyone',
        privacy: 1,
        allowLike: true,
        allowComment: true,
        allowShare: true,
      );
    });

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: pageBg,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75.h),
          child: _HeaderBar(
            onBack: () {
              if (Navigator.of(context).canPop()) {
                AppSheet.showDraftSettingsSheet(
                  context,
                  onDiscard: () {
                    AppRouter.router.pop();
                    AppRouter.router.pop();
                  },
                  onSaveDraft: () {
                    // Draft logic
                  },
                );
              } else {
                AppRouter.router.pop();
              }
            },
            onPreview:
                onPreview ??
                () {
                  AppRouter.router.pushNamed(Routes.previewRoute);
                },
          ),
        ),
        body:
            !authStatus
                ? const AuthOpt()
                : SafeArea(
                  top: false,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                       
                          child: Form(
                            key: formkey.value,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                8.verticalSpace,
                                Consumer(
                                  builder: (_, WidgetRef ref, __) {
                                    final state = ref.watch(postParamsController);
                                    return _ComposerCard(
                                      primary: cs,
                                      thumbnail: state.thumbnail,
                                      onChanged: (v) {
                                        descriptionText.value = v;
                                      },
                                    );
                                  },
                                ),
                                14.verticalSpace,
                                _ListCard(
                                  onSong:
                                      () =>
                                          AppSheet.showSongPickerSheet(context),
                                  onLocation:
                                      onOpenLocation ??
                                      () => AppSheet.showLocationSettingsSheet(
                                        context,
                                      ),
                                  onSettings:
                                      onOpenSettings ??
                                      () {
                                        showSheet(
                                          context,
                                          showDragHandle: false,
                                          // maxHeight: context.height * 0.75,
                                          scrollControlDisabledMaxHeightRatio:
                                              0.78,
                                          child: PostSettingsSheet(),
                                        );
                                      },
                                  textStrong: textStrong,
                                  textSubtle: textSubtle,
                                ),
                                20.verticalSpace,
                              ],
                            ),
                          ),
                        ),
                      ),

                      // bottom action bar with rounded corners
                      ref.watch(postNotifierProvider) is PostUploading
                          ? PostProgress()
                          : BottomActionBar(
                            onSaveDraft: () {},
                            onShare: () async {
                             if (formkey.value.currentState!.validate()) {
                                String videoPath =
                                    ref.read(postParamsController).video!.path;
                                String imagePath =
                                    ref
                                        .read(postParamsController)
                                        .thumbnail!
                                        .path;
                                int privacy =
                                    ref.read(postParamsController).privacy;
                                bool allowComment =
                                    ref.read(postParamsController).allowComment;
                                bool allowShare =
                                    ref.read(postParamsController).allowShare;

                                notifier.state = notifier.state.copyWith(
                                  description: descriptionText.value,
                                  allowComment: allowComment,
                                  allowShare: allowShare,
                                  privacy: privacy,
                                  videoFilename:
                                      formkey.value.currentState!.validate()
                                          ? videoPath.split('/').last
                                          : null,
                                  videoMime: 'video/mp4',
                                  thumbnailFilename:
                                      formkey.value.currentState!.validate()
                                          ? imagePath.split('/').last
                                          : null,
                                  thumbnailMime: 'image/jpeg',
                                );
                                debugPrint(
                                  "Image Path For Signed Url : $imagePath",
                                );
                                ref
                                    .read(postNotifierProvider.notifier)
                                    .getVideoSignedUrl(videoPath, imagePath);
                              }
                            },
                            primary: primary,
                          ),
                    ],
                  ),
                ),
      ),
    );
  }
}

class PostProgress extends HookConsumerWidget {
  const PostProgress({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postNotifierProvider);
    if (state is PostUploading) {
     final value = state.progress.isNaN ? 0.0 : state.progress;
      return Slider(
        onChanged: (v) {},
        value: value,
        min: 0.0,
        max: 100.0,
        activeColor: context.colorScheme.primary,
        inactiveColor: context.colorScheme.secondary,
      );
    } else {
      return SizedBox.shrink();
    }
  }
}

/// ————————————————— HEADER —————————————————
class _HeaderBar extends StatelessWidget {
  const _HeaderBar({required this.onBack, required this.onPreview});

  final VoidCallback onBack;
  final VoidCallback onPreview;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20.h,
        left: 16.w,
        right: 16.w,
        bottom: 12.h,
      ),
      child: Row(
        children: [
          // back pill
          ExitButton(
            child: Icon(
              Icons.keyboard_backspace_rounded,
              color: context.colorScheme.primary,
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: AppText(
              text: 'New post',
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: const Color(AppColors.black),
            ),
          ),
          // _PreviewPill(onTap: onPreview),
          OutlinedButton(
            style: ButtonStyle(
              side: WidgetStatePropertyAll(
                BorderSide(
                  color: context.colorScheme.onSecondary.withValues(alpha: 0.2),
                  width: 1.w,
                ),
              ),
            ),
            onPressed: () {},
            child: Text(
              'Preview',
              style: context.body14.copyWith(
                color: context.colorScheme.onSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewPill extends StatelessWidget {
  const _PreviewPill({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF0F1F5),
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: AppText(
            text: 'Preview',

            fontWeight: FontWeight.w600,
            color: const Color(0xFF6B7280), // gray-500ish
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}

/// ——————————————— COMPOSER CARD ———————————————
class _ComposerCard extends StatelessWidget {
  final File? thumbnail;
  final Function(String?)? onChanged;
  const _ComposerCard({required this.primary, this.thumbnail, this.onChanged});
  final Color primary;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.all(12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Thumb(file: thumbnail),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  children: [
                    TextFormField(
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Please enter a description";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUnfocus,
                      onChanged: onChanged,
                      textCapitalization: TextCapitalization.sentences,
                      maxLines: 6,
                      minLines: 6,
                      decoration: InputDecoration(
                        hintText: 'Add description…',
                        hintStyle: TextStyle(
                          color: Color(
                            AppColors.primaryTextColor,
                          ).withValues(alpha: .5),
                          fontSize: 14.sp,
                          fontFamily: FontConstant.bricolage,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 5.h,
                          horizontal: 5.w,
                        ),
                      ),
                    ),
                    10.verticalSpace,
                    Row(
                      spacing: 10.w,
                      children: const [
                        _Chip(text: '# Hashtags'),
                        _Chip(text: '@ Mention'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: const Color(0xFF19101A).withValues(alpha: .5),
        borderRadius: BorderRadius.circular(8.r),
      ),
      alignment: Alignment.center,
      child: AppText(
        text: text,
        fontWeight: FontWeight.w600,
        color: Color(AppColors.white),
        fontSize: 12.sp,
      ),
    );
  }
}

/// ——————————————— LIST CARD ———————————————
class _ListCard extends StatelessWidget {
  const _ListCard({
    required this.onSong,
    required this.onLocation,
    required this.onSettings,
    required this.textStrong,
    required this.textSubtle,
  });

  final VoidCallback onSong;
  final VoidCallback onLocation;
  final VoidCallback onSettings;
  final Color textStrong;
  final Color textSubtle;

  @override
  Widget build(BuildContext context) {
    final divider = Divider(
      height: 1,
      thickness: .6,
      color: const Color(0xFFE8E9EE),
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          ListTile(
            onTap: onSong,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.asset(
                ImageAssets.post1mage,
                width: 44.w,
                height: 44.w,
                fit: BoxFit.cover,
              ),
            ),
            title: AppText(
              text: 'Sweet Love',
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              color: textStrong,
            ),
            subtitle: AppText(
              text: 'Burna boy · 3:32',
              fontSize: 14.sp,
              color: textSubtle,
              fontWeight: FontWeight.w500,
            ),
            trailing: const Icon(
              Icons.chevron_right_rounded,
              color: Color(AppColors.textColor2),
            ),
          ),
          divider,
          ListTile(
            onTap: onLocation,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
            leading: const Icon(
              Icons.place_outlined,
              color: Color(AppColors.black),
            ),
            title: AppText(
              text: 'Add location',

              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: textStrong,
            ),

            trailing: const Icon(
              Icons.chevron_right_rounded,
              color: Color(AppColors.textColor2),
            ),
          ),
          divider,
          ListTile(
            onTap: onSettings,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
            leading: SvgPicture.asset(
              IconAssets.gearIcon,
              // ignore: deprecated_member_use
              color: context.colorScheme.inversePrimary,
            ),
            title: AppText(
              text: 'Post settings',

              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: textStrong,
            ),
            trailing: const Icon(
              Icons.chevron_right_rounded,
              color: Color(AppColors.textColor2),
            ),
          ),
        ],
      ),
    );
  }
}

/// ——————————————— BOTTOM BAR ———————————————
class BottomActionBar extends StatelessWidget {
  const BottomActionBar({
    super.key,
    required this.onSaveDraft,
    required this.onShare,
    required this.primary,
    this.isLoading = false,
  });

  final bool isLoading;
  final VoidCallback onSaveDraft;
  final VoidCallback onShare;
  final Color primary;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(color: context.colorScheme.primary),
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.fromLTRB(
        16.w,
        14.h,
        16.w,
        16.h + MediaQuery.of(context).padding.bottom,
      ),
      child: Row(
        children: [
          Expanded(
            child: _LightButton(
              label: 'Save draft',
              onTap: onSaveDraft,
              textColor: primary,
            ),
          ),
          14.horizontalSpace,
          Expanded(
            child: _FilledButton(
              label: 'Share',
              onTap: onShare,
              background: primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _LightButton extends StatelessWidget {
  const _LightButton({
    required this.label,
    required this.onTap,
    required this.textColor,
  });

  final String label;
  final VoidCallback onTap;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF5F6FA),
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: onTap,
        child: Container(
          height: 52.h,
          alignment: Alignment.center,
          child: AppText(
            text: label,

            color: textColor,
            fontWeight: FontWeight.w700,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}

class _FilledButton extends StatelessWidget {
  const _FilledButton({
    required this.label,
    required this.onTap,
    required this.background,
  });

  final String label;
  final VoidCallback onTap;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: onTap,
        child: Container(
          height: 52.h,
          alignment: Alignment.center,
          child: AppText(
            text: label,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}

/// ——————————————— THUMBNAIL ———————————————
class Thumb extends HookConsumerWidget {
final File? file;
  const Thumb({super.key, this.file});



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final uploadState = ref.watch(videoUploadProvider);
    return SizedBox(
      width: 1.sw * .27.w, // wider like the mock
      child: AspectRatio(
        aspectRatio: 9 / 16,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child:
                  file != null
                      ? Image.file(
                        File(file!.path),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      )
                      : Container(
                          color: Colors.grey,
                          width: 1.sw * .27.w,
                          height:double.infinity,
                        ),  
            ),
            Positioned(
              left: 10.w,
              bottom: 10.h,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: .5),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: AppText(
                  text: 'Edit cover',
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
