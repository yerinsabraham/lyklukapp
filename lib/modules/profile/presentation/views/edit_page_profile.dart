import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/shared_widget.dart';
import 'package:lykluk/modules/profile/data/models/user_profile.dart';
import 'package:lykluk/modules/profile/presentation/view_model/providers/profile_provider.dart';
import 'package:lykluk/core/services/image_upload_service.dart';
import 'package:lykluk/modules/profile/presentation/view_model/notifiers/profile_notifier.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/helpers/app_sheet.dart';
import 'package:lykluk/utils/helpers/choose_photo.dart';
import 'package:lykluk/utils/router/app_router.dart';

class EditPageProfile extends HookConsumerWidget {
  const EditPageProfile({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItem = ref.watch(profileProvider).valueOrNull;
    final uploader = ref.read(uploaderProvider);
    final profileNotifier = ref.read(profileNotifierProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            ExitButton(),
            20.sW,
            Text('Edit profile', style: context.title24Bold),
          ],
        ),
      ),
      body: Column(
        children: [
          Spacer(flex: 3),
          Stack(
            alignment: Alignment.center,
            children: [
              ProfileAvatar(
                radius: 70,
                imageUrl: asyncItem?.imageUrl,
                placeholder: SvgPicture.asset(IconAssets.emptyProfileIcon),
                onTap: () async {
                  await pickImageBottomSheet(context, ref, uploader, profileNotifier);                
                },
              ),
              // semi-transparent circular camera icon in the center
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () async {
                      await pickImageBottomSheet(context, ref, uploader, profileNotifier);
                    },
                    child: CircleAvatar(
                      radius: 22.r,
                      backgroundColor:
                          context.colorScheme.surface.withOpacity(0.35),
                      child: Icon(
                        Icons.camera_alt,
                        size: 22.r,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Spacer(flex: 2),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 14.w),
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(15.r),
            ),

            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    context.pushNamed(Routes.nameEditProfileRoute);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      border: Border(
                        bottom: BorderSide(
                          color: context.colorScheme.onSecondary.withValues(
                            alpha: 0.1,
                          ),
                        ),
                      ),
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Name',
                          style: context.body16Bold.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                asyncItem
                                        ?.profile
                                        ?.name
                                        .capitalizeFirstLetter ??
                                    'Add name',
                                style: context.body16.copyWith(
                                  color:
                                      asyncItem?.profile?.name == null
                                          ? context.colorScheme.primary
                                          : null,
                                ),
                              ),
                              5.sW,
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 20.r,
                                color: context.colorScheme.onSecondary
                                    .withValues(alpha: 0.3),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    context.pushNamed(Routes.usernameEditProfileRoute);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      border: Border(
                        bottom: BorderSide(
                          color: context.colorScheme.onSecondary.withValues(
                            alpha: 0.1,
                          ),
                        ),
                      ),
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Username',
                          style: context.body16Bold.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              asyncItem?.username ?? 'Add username',
                              style: context.body16.copyWith(
                                color:
                                    asyncItem?.username == null
                                        ? context.colorScheme.primary
                                        : null,
                              ),
                            ),
                            5.sW,
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20.r,
                              color: context.colorScheme.onSecondary.withValues(
                                alpha: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    AppSheet.showSettingOptionsSheet(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      border: Border(
                        bottom: BorderSide(
                          color: context.colorScheme.onSecondary.withValues(
                            alpha: 0.1,
                          ),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Chip(
                          backgroundColor: context.colorScheme.primary
                              .withValues(alpha: 0.3),
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                IconAssets.link2Icon,
                                height: 24.h,
                                width: 24.w,
                              ),
                              2.sW,
                              Text(
                                'lykluk.com/${asyncItem?.username}',
                                style: context.body14.copyWith(
                                  color: context.colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          visualDensity: VisualDensity(
                            horizontal: -4,
                            vertical: -4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    context.pushNamed(Routes.bioEditProfileRoute);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    decoration: BoxDecoration(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Bio',
                          style: context.body16Bold.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: context.width * 0.6,
                              ),
                              child: Text(
                                asyncItem?.profile?.bio ?? '+Add bio',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,

                                style: context.body14.copyWith(
                                  color:
                                      asyncItem?.profile?.bio == null
                                          ? context.colorScheme.primary
                                          : null,
                                ),
                              ),
                            ),
                            // 5.sW,
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20.r,
                              color: context.colorScheme.onSecondary.withValues(
                                alpha: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(flex: 7),
        ],
      ),
    );
  }
}