import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/widgets/comment_bar.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/helpers/app_sheet.dart';
import 'package:lykluk/utils/storage/local_storage.dart';
import 'package:lykluk/utils/theme/expandable_text.dart';
import 'package:lykluk/utils/theme/theme.dart';

class PreviewScreen extends HookConsumerWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          /// Background video
          // Positioned.fill(
          //   child: LykLukVodPlayer(
          //     url: VideoConstant.ttVImageSource,
          //     cacheKey: VideoConstant.ttVImageCache,
          //     bottomSeek: 50,
          //   ),
          // ),

          /// Close icon (top-left)
          Positioned(
            top: 50.h,
            left: 16.w,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: .35),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ),

          /// Right actions
          Positioned(
            right: 5.w,
            bottom: 1.sh * .09.h,
            child: const _PreviewActions(),
          ),

          /// Bottom details (profile + caption)
          Positioned(
            left: 0.w,
            right: 0.w,
            bottom: 70.h,
            child: const _PreviewDetails(),
          ),

          /// Comment input (at very bottom)
          Positioned(left: 0, right: 0, bottom: 0, child: CommentBar()),
        ],
      ),
    );
  }
}

/// —— Right-side stacked actions
class _PreviewActions extends StatelessWidget {
  const _PreviewActions();

  @override
  Widget build(BuildContext context) {
    final avatar = const AssetImage(ImageAssets.userImage);
    final author = HiveStorage.fullName.toString();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap:
              () => AppSheet.showPostOptionsSheet(
                context,
                authorName: author,
                avatar: avatar,
              ),
          child: SvgPicture.asset(IconAssets.bookmarkIcon),
        ),
        20.sH,

        // Like
        SvgPicture.asset(IconAssets.loveIcon),
        20.sH,

        // Comments
        GestureDetector(
          onTap:
              () => AppSheet.showCommentsSheet(
                context,
                coverAssetOrUrl: ImageAssets.userImage,
                totalComments: 500200,
              ),
          child: SvgPicture.asset(IconAssets.commentChatIcon),
        ),
        20.sH,

        // Share
        SvgPicture.asset(IconAssets.sendWhiteIcon),
        20.sH,

        // More (OPTIONS)
        GestureDetector(
          onTap:
              () => AppSheet.showPostOptionsSheet(
                context,
                authorName: author,
                avatar: avatar,
              ),
          child: SvgPicture.asset(IconAssets.moreBlurIcon),
        ),
      ],
    );
  }
}

/// —— Profile + caption block
class _PreviewDetails extends StatelessWidget {
  const _PreviewDetails();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 14.w, right: 14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(backgroundImage: AssetImage(ImageAssets.userImage)),
              SizedBox(width: 10.w),
              _UserMeta(),
              SizedBox(width: 10.w),
              _ConnectButton(),
              Spacer(),
            ],
          ),
          10.sH,
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: context.width * 0.8),
            child: ExpandableText(
              text:
                  "Dive into a vibrant community where we bring cultural stories to life.",
              style: context.body16.copyWith(
                fontSize: 12.sp,
                color: context.colorScheme.surface,
              ),
              trimLines: 2,
              buttonStyle: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                foregroundColor: context.colorScheme.surface.withValues(
                  alpha: .9,
                ),
              ),
              moreText: 'More',
              lessText: 'Less',
            ),
          ),
        ],
      ),
    );
  }
}

class _UserMeta extends StatelessWidget {
  const _UserMeta();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: context.width * 0.4),
          child: Text(
            "Block Global Roots",
            style: context.body16.copyWith(color: context.colorScheme.surface),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        AppText(
          text: "10 mins ago",
          style: context.body14Light.copyWith(
            color: context.colorScheme.surface,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _ConnectButton extends StatelessWidget {
  const _ConnectButton();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: const BorderSide(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      ),
      onPressed: () {},
      child: AppText(text: "Connect", color: Color(AppColors.white)),
    );
  }
}
