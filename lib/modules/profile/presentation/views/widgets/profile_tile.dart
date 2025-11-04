import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lykluk/core/shared/widgets/profile_avatar.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

import '../../../../../utils/router/app_router.dart';
import '../../../data/models/other_user.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({super.key, required this.profile , required this.onConnectTap});

  final OtherUser profile;
  final Function onConnectTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          Routes.otherUserProfileRoute,
          extra: profile.following?.username!,
        );
      },
      child: Container(
        // height: 70.h,
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          border: Border(
            bottom: BorderSide(
              color: context.colorScheme.onTertiary,
              width: 0.5,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // CircleAvatar(
            //   radius: 22.r,
            //   backgroundImage: AssetImage(ImageAssets.userImage),
            // ),
            ProfileAvatar(
              radius: 22,
              imageUrl: profile.profileUrl,
              placeholderValue: profile.abbrev,
              textSize: 16.sp,
            ),
            10.sW,
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.following?.profile?.name ??
                      "${profile.following?.username}",
                  style: context.body16,
                ),
                // 3.sH,
                Text(
                  // 'realculturecoture',
                  profile.following?.username ?? "",

                  style: context.body14.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
              ],
            ),
            Spacer(),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide.none,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                backgroundColor: (profile.following?.isFollowedByCurrentUser ?? false) ? context.colorScheme.onSecondary.withValues(
                        alpha: 0.07,
                      ) : context.colorScheme.primaryFixedDim.withValues(
                  alpha: .1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              onPressed: () {
                onConnectTap();
              },
              child: Text(
                (profile.following?.isFollowedByCurrentUser ?? false) ? "Requested" : "Connect",
                  style: (profile.following?.isFollowedByCurrentUser ?? false) ? context.body14Light : context.body14Light.copyWith(
                  color: context.colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
