import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/theme/app_colors.dart';

class MediaChoiceSheet extends StatelessWidget {
  const MediaChoiceSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.w).copyWith(bottom: 30.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w).copyWith(bottom: 40.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(10.r), // optional
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTile(
            title: 'Image',
            icon: SvgPicture.asset(IconAssets.imageIcon),
            onTap: () {
              // TODO: Implement image picker
            },
          ),

          CustomTile(
            title: 'Document',
            icon: SvgPicture.asset(IconAssets.docIcon),
            onTap: () {
              // TODO: Implement document picker
            },
          ),
          CustomTile(
            title: 'Sticker',
            icon: SvgPicture.asset(IconAssets.fileIcon),
            onTap: () {
              // TODO: Implement sticker picker
            },
          ),
        ],
      ),
    );
  }
}

class ChatActions extends StatelessWidget {
  const ChatActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: CustomTile(
              title: 'Mute',
              icon: SvgPicture.asset(IconAssets.muteIcon),
              color: context.colorScheme.surface,
            ),
          ),
        ),
        10.sH,
        Container(
          margin: EdgeInsets.symmetric(horizontal: 14.w).copyWith(bottom: 30.h),
          padding: EdgeInsets.symmetric(
            // horizontal: 14.w,
          ),
          decoration: BoxDecoration(
            color: context.colorScheme.onPrimaryFixed,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTile(
                title: 'Delete',
                icon: SvgPicture.asset(IconAssets.deleteIcon),
                onTap: () {},
              ),
        
              CustomTile(
                title: 'Block',
                icon: SvgPicture.asset(IconAssets.blockIcon),
                onTap: () {},
              ),
              CustomTile(
                title: 'Report',
                icon: SvgPicture.asset(IconAssets.reportIcon),
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomTile extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback? onTap;
  final Color? color;
  const CustomTile({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
        decoration: BoxDecoration(
          color: color?? context.colorScheme.surface,
          border: Border(
            bottom: BorderSide(
              color: context.colorScheme.onTertiaryFixed,
              width: 0.5,
            ),
          ),
          // borderRadius: BorderRadius.circular(8), // optional
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: context.body16.copyWith(
                color:
                    title.toLowerCase() == 'mute'
                        ? Color(AppColors.black)
                        : context.colorScheme.error,
              ),
            ),
            icon,
          ],
        ),
      ),
    );
  }
}
