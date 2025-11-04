import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

import '../../../../../../core/shared/widgets/shared_widget.dart';
import '../../../../../../utils/helpers/show_sheet.dart';
import '../../../../data/model/post_model.dart';
import 'report_post_sheet.dart';

class PostActionSheet extends HookConsumerWidget {
  final PostModel post;
  const PostActionSheet({super.key, required this.post});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 10.h, bottom: 20.h),
              decoration: BoxDecoration(
                color: context.colorScheme.onSecondary.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(10.r),
              ),
              height: 8.h,
              width: 100.w,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 14.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16.r)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ActionTile(
                //   onTap: () {
                //     ref
                //         .read(postNotifierProvider.notifier)
                //         .savePost(post: post);
                //   },
                //   title: 'Save',
                //   trailing: post.isSaved? Icon(
                //             Icons.bookmark,
                //             color: context.colorScheme.primary,
                //             size: 32.r,
                //           ) :SvgPicture.asset(IconAssets.bookmark2Icon),
                // ),
                ActionTile(
                  title: 'Not interested',
                  trailing: SvgPicture.asset(IconAssets.eyeIcon),
                ),
                ActionTile(
                  title: 'Hide icons',
                  trailing: SvgPicture.asset(IconAssets.phoneIcon),
                  hasBorder: false,
                ),
              ],
            ),
          ),
          10.sH,
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 14.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16.r)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ActionTile(
                  title: 'Copy link',
                  trailing: SvgPicture.asset(IconAssets.linkHyperIcon),
                ),
                ActionTile(
                  title: 'Share to',
                  trailing: SvgPicture.asset(IconAssets.shareUploadIcon),
                  hasBorder: false,
                ),
              ],
            ),
          ),
          10.sH,
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 14.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16.r)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ActionTile(
                  title: 'Mute',
                  trailing: SvgPicture.asset(IconAssets.mute2Icon),
                ),
                ActionTile(
                  title: 'Block',
                  trailing: SvgPicture.asset(
                    IconAssets.blockCircleIcon,
                    color: Colors.red,
                  ),
                ),
                ActionTile(
                  title: 'Report',
                  trailing: SvgPicture.asset(
                    IconAssets.report2Icon,
                    color: Colors.red,
                  ),
                  hasBorder: false,
                  onTap: () async {
                    context.pop();
                    await showSheet(
                      context,
                      isScrollControlled: true,
                      showDragHandle: false,
                      scrollControlDisabledMaxHeightRatio: 0.9,
                      constraints: BoxConstraints(maxHeight: 0.9.sh),
                      child: ReportPostSheet(),
                    );
                  },
                ),
              ],
            ),
          ),
          20.sH,
          // ActionTile(title: 'Report', trailing: Icon(Icons.report)),
        ],
      ),
    );
  }
}
