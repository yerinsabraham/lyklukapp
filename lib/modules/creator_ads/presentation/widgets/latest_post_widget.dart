import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/utils/theme/theme.dart';

/// Widget for displaying latest post stats
class LatestPostWidget extends StatelessWidget {
  final String title;
  final String views;
  final String likes;
  final VoidCallback? onTap;

  const LatestPostWidget({
    super.key,
    required this.title,
    required this.views,
    required this.likes,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 200.w,
              child: Opacity(
                opacity: 0.80,
                child: AppText(
                  text: title,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(AppColors.textColor3),
                  fontFamily: 'Figtree',
                  height: 1.79,
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Views
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 20.w,
                      height: 20.h,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: Icon(
                        Icons.play_arrow_outlined,
                        size: 20.sp,
                        color: const Color(AppColors.dividerColor3),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    AppText(
                      text: views,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(AppColors.dividerColor3),
                      fontFamily: 'Figtree',
                      height: 1.22,
                    ),
                  ],
                ),
                SizedBox(width: 15.w),
                // Likes
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 14.w,
                      height: 14.h,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: Icon(
                        Icons.favorite_outline,
                        size: 14.sp,
                        color: const Color(AppColors.dividerColor3),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Container(
                      margin: EdgeInsets.only(right: 4.w),
                      child: AppText(
                        text: likes,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(AppColors.dividerColor3),
                        fontFamily: 'Figtree',
                        height: 1.22,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
