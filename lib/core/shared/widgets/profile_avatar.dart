import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/core/services/network/endpoints.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

import '../../../utils/helpers/color_helper.dart';

class ProfileAvatar extends StatelessWidget {
  final bool isProfile;
  final VoidCallback? onTap;
  final String? imageUrl;
  final int radius;
  final Widget? placeholder;
  final Widget? errorHolder;
  final String? placeholderValue;
  final Color? backgroundColor;
  final double? textSize;
  const ProfileAvatar({
    super.key,
    required this.imageUrl,
    this.radius = 20,
    this.placeholderValue,
    this.onTap,
    this.backgroundColor,
    this.textSize,
    this.placeholder,
    this.errorHolder,
    this.isProfile = true,
  });
  @override
  Widget build(BuildContext context) {
    // print("Image URL: $imageUrl");
    if (imageUrl == null) {
      return GestureDetector(
        onTap: onTap,
        child:
            placeholder ??
            RandomPlaceholder(
              value: placeholderValue?.capitalize ?? "AN",
              radius: radius,
              color: backgroundColor,
            ),
      );
    } else if (imageUrl!.isEmpty) {
      return GestureDetector(
        onTap: onTap,
        child:
            placeholder ??
            RandomPlaceholder(
              value: placeholderValue?.capitalize ?? "AN",
              radius: radius,
              color: backgroundColor,
              textSize: textSize ?? radius * 0.9,
            ),
      );
    } else {
      return GestureDetector(
        onTap: onTap,
        child: CachedNetworkImage(
          imageUrl: imageUrl!,
          // httpHeaders: {'Authorization': 'Bearer ${HiveStorage.accessToken}', "app_token":  HiveStorage.fcmToken},
          progressIndicatorBuilder:
              (context, url, downloadProgress) => CircleAvatar(
                radius: radius.r,
                child: CupertinoActivityIndicator(radius: 8.r),
              ),
          errorWidget: (context, url, error) {
            // log.d("Error loading image: $error");
            if(isProfile){
            return ProfileAvatar(
              imageUrl: Endpoints.defaultProfilePicUrl ,
              radius: radius,
              placeholder: errorHolder,
              errorHolder: errorHolder,
              isProfile: true,
              textSize: textSize,
              backgroundColor: backgroundColor,
              placeholderValue: placeholderValue,
              onTap: onTap,
            );

            }
            return errorHolder ??
                RandomPlaceholder(
                   value: placeholderValue?.capitalize ?? "AN",
                  radius: radius,
                  color: backgroundColor,
                  textSize: textSize,
                );
          },
          imageBuilder:
              (context, imageProvider) => CircleAvatar(
                radius: radius.r,
                backgroundImage: imageProvider,
              ),
        ),
      );
    }
  }
}

class RandomPlaceholder extends StatelessWidget {
  final String value;
  final int radius;
  final VoidCallback? onTap;
  final Color? color;
  final double? textSize;
  const RandomPlaceholder({
    super.key,
    required this.value,
    this.radius = 16,
    this.onTap,
    this.color,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: color ?? generateUserColor(value),
        radius: radius.r + 2,
        child: Text(
          value,
          style: TextStyle(
            fontSize: textSize ?? 12.sp,
            color: color != null ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
