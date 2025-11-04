import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/theme/theme.dart';

class TrackModel {
  final String title;
  final String artist;
  final String duration;
  const TrackModel({
    required this.title,
    required this.artist,
    required this.duration,
  });
}

class TrackTile extends StatelessWidget {
  const TrackTile({super.key, required this.track, this.onAdd});
  final TrackModel track;
  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 45.w,
        height: 45.h,
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade200,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: const Icon(Icons.album_rounded),
      ),
      title: AppText(
        text: track.title,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: const Color(AppColors.black),
      ),
      subtitle: AppText(
        text: '${track.artist} • ${track.duration}',
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: const Color(AppColors.textColor2),
      ),

      trailing: InkWell(
        onTap: onAdd,
        child: SvgPicture.asset(IconAssets.bookmark2Icon),
      ),
    );
  }
}
