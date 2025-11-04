import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/widgets/bottom_sheet_wrapper.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/theme/theme.dart';

class DraftSettingsSheet extends HookConsumerWidget {
  const DraftSettingsSheet({super.key, this.onDiscard, this.onSaveDraft});

  final VoidCallback? onDiscard;
  final VoidCallback? onSaveDraft;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomSheetWrapper(
      title: '',
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(AppColors.white),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Discard
            ListTile(
              onTap: onDiscard,
              trailing: SvgPicture.asset(IconAssets.deleteIcon),
              title: AppText(
                text: 'Discard',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color(AppColors.black),
              ),
            ),
            Divider(
              indent: 20.w,
              endIndent: 20.w,
              height: .5.h,
              thickness: 1,
              color: Color(AppColors.buttonColor2),
            ),
            // Save draft
            ListTile(
              onTap: onSaveDraft,
              trailing: SvgPicture.asset(IconAssets.draftIcon),
              title: AppText(
                text: 'Save draft',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color(AppColors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
