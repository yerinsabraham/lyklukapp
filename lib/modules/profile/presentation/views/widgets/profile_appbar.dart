import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/shared_widget.dart';
import 'package:lykluk/modules/profile/data/models/user_profile.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/router/app_router.dart';
import 'package:lykluk/utils/storage/local_storage.dart';

class ProfileAppBar extends HookConsumerWidget {
  final UserProfile? user;
  const ProfileAppBar({super.key, this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final user = ref.watch(profileProvider).valueOrNull;
    return SliverToBoxAdapter(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              10.sH,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (user?.username != HiveStorage.username)
                    Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: ExitButton(child: Icon(Icons.keyboard_backspace)),
                    ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Visibility(
                        visible: user?.profile?.name != null,
                        replacement: Card(
                          elevation: 0,
                          surfaceTintColor: context.colorScheme.primary
                              .withValues(alpha: 0.1),
                          shadowColor: context.colorScheme.primary.withValues(
                            alpha: 0.1,
                          ),
                          shape: StadiumBorder(),
                          color: context.colorScheme.primary.withValues(
                            alpha: 0.1,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  color: context.colorScheme.primary,
                                  size: 20,
                                ),
                                2.sW,
                                Text(
                                  "Add name",
                                  style: context.body14.copyWith(
                                    color: context.colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        child: Text(
                          user?.profile?.name?.capitalizeFirstLetter ?? "",
                          style: context.title24.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        user?.plainUsername ?? '',
                        style: context.body16.copyWith(
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: InkWell(
                      onTap: () {
                        // AppSheet.showSettingOptionsSheet(context);
                        context.pushNamed(Routes.profileSettingsRoute);
                      },
                      child: SvgPicture.asset(IconAssets.optionDashIcon),
                    ),
                  ),
                ],
              ),
              10.sH,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                visible: user?.profile?.bio != null,
                                replacement: SizedBox.shrink(),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: context.width * 0.7,
                                  ),
                                  child: Text(
                                    // 'Dive into a vibrant community where we bring cultural stories to life.',
                                    user?.profile?.bio ?? "",

                                    style: context.body16Light.copyWith(
                                      color: context.colorScheme.inversePrimary,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              10.sH,
                              GestureDetector(
                                onTap: () {
                                  context.pushNamed(
                                    Routes.connectionsRoute,
                                    extra: user?.id.toString(),
                                  );
                                },
                                child: Text.rich(
                                  TextSpan(
                                    text:
                                        user?.count?.followedBy.toGroup ?? '0',
                                    children: [
                                      TextSpan(
                                        text: " connections |",
                                        style: context.body16Light,
                                      ),
                                      TextSpan(
                                        text:
                                            " ${user?.count?.likes.toGroup ?? '0'}",
                                      ),
                                      TextSpan(
                                        text: " impact",
                                        style: context.body16Light,
                                      ),
                                    ],
                                  ),
                                  style: context.body16.copyWith(
                                    color: context.colorScheme.inversePrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      10.sH,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: user?.username == HiveStorage.username,
                            replacement: ConnectButton(),
                            child: CustomElevatedButton(
                              height: 50.h,
                              width: context.width * 0.5,
                              onTap: () {
                                context.pushNamed(Routes.editProfileRoute);
                              },
                              textColor: context.colorScheme.inversePrimary,
                              color: context.colorScheme.onPrimaryFixedVariant,
                              buttonText:
                                  user?.isSetup != null
                                      ? ' Edit Profile'
                                      : "Set up profile",
                            ),
                          ),
                          10.sW,
                          CustomElevatedButton(
                            height: 50.h,
                            width: 50.w,
                            onTap: () {},
                            textColor: context.colorScheme.inversePrimary,
                            color: context.colorScheme.onPrimaryFixedVariant,
                            child: Icon(
                              Icons.reply_rounded,
                              // Icons.,
                              size: 30.r,
                              color: context.colorScheme.inversePrimary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Visibility(
                    visible: user?.imageUrl != null,
                    replacement: CircleAvatar(
                      radius: 40.r,
                      child: SvgPicture.asset(
                        IconAssets.emptyProfileIcon,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ProfileAvatar(
                      isProfile: true,
                      imageUrl: user?.imageUrl,
                      radius: 40,
                      textSize: 20.sp,
                      placeholderValue:
                          user?.username.capitalizeTwoRandomLetters,
                    ),
                  ),

                  // CircleAvatar(
                  //   radius: 40.r,
                  //   backgroundImage: AssetImage(ImageAssets.post1mage),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
