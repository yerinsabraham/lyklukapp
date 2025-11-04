import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/shared_widget.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/controllers/post_controller.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/widgets/bottom_sheet_wrapper.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/theme/theme.dart';

class PostSettingsSheet extends HookConsumerWidget {
  const PostSettingsSheet({super.key, this.scrollController});

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final audience = useState(0); // 0 = Everyone, 1 = Mutuals, 2 = Only you
    // final like = useState(true);
    // final comment = useState(true);
    // final share = useState(true);
    // final postVisibility = useState<String?>(null);
    final state = ref.watch(postParamsController);
    final notifier = ref.watch(postParamsController.notifier);

    return BottomSheetWrapper(
      hasDrag: true,
      title: 'Settings',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 15.w),
            decoration: BoxDecoration(
              color: Color(AppColors.white),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SectionHeader(title: 'Who can view this post'),
                AppText(
                  text: "Who can view this post",
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                ),
                ActionTile(
                  titleStyle: context.body16,
                  onTap: () {
                    notifier.state = notifier.state.copyWith(
                      visibilty: 'Everyone',
                      privacy: 1,
                    );
                  },
                  title: "Everyone",
                  trailing: CustomRadio(
                    radius: 20.r,
                    groupValue: state.visibilty,
                    onTap: (v) {
                      notifier.state = notifier.state.copyWith(
                        visibilty: 'Everyone',
                        privacy: 1,
                      );
                    },
                    value: 'Everyone',
                  ),
                ),
                ActionTile(
                  titleStyle: context.body16,
                  onTap: () {
                    notifier.state = notifier.state.copyWith(
                      visibilty: 'Mutuals',
                      privacy: 2,
                    );
                  },
                  title: "Mutuals",
                  subtitle: "People you follow back · 10k mutuals",
                  trailing: CustomRadio(
                    radius: 20.r,
                    groupValue: state.visibilty,
                    onTap: (v) {
                      notifier.state = notifier.state.copyWith(
                        visibilty: 'Mutuals',
                        privacy: 2,
                      );
                    },
                    value: 'Mutuals',
                  ),
                ),
                ActionTile(
                  titleStyle: context.body16,
                  onTap: () {
                    notifier.state = notifier.state.copyWith(
                      visibilty: 'Only you',
                      privacy: 3,
                    );
                  },
                  title: "Only you",
                  trailing: CustomRadio(
                    radius: 20.r,
                    groupValue: state.visibilty,
                    onTap: (v) {
                      notifier.state = notifier.state.copyWith(
                        visibilty: 'Only you',
                        privacy: 3,
                      );
                    },
                    value: 'Only you',
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 15.w),
            decoration: BoxDecoration(
              color: Color(AppColors.white),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SectionHeader(title: 'Who can view this post'),
                AppText(
                  text: "Video privacy",
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                ),
                ActionTile(
                  titleStyle: context.body16,
                  onTap: () {
                    // like.value = !like.value;
                    notifier.state = notifier.state.copyWith(
                      allowLike: !state.allowLike,
                    );
                  },
                  title: "Allow like",
                  trailing: CustomSwitch(
                    value: state.allowLike,
                    onChanged: (v) {
                      notifier.state = notifier.state.copyWith(allowLike: v);
                    },
                  ),
                ),
                ActionTile(
                  titleStyle: context.body16,
                  onTap: () {
                    // comment.value = !comment.value;
                    notifier.state = notifier.state.copyWith(
                      allowComment: !state.allowComment,
                    );
                  },
                  title: "Allow comment",

                  trailing: CustomSwitch(
                    value: state.allowComment,
                    onChanged: (v) {
                      notifier.state = notifier.state.copyWith(allowComment: v);
                    },
                  ),
                ),
                ActionTile(
                  titleStyle: context.body16,
                  onTap: () {
                    notifier.state = notifier.state.copyWith(
                      allowShare: !state.allowShare,
                    );
                  },
                  title: "Allow share",
                  trailing: CustomSwitch(
                    value: state.allowShare,
                    onChanged: (v) {
                      notifier.state = notifier.state.copyWith(allowShare: v);
                    },
                  ),
                ),
              ],
            ),
          ),

          // 16.verticalSpace,
        ],
      ),
    );
  }
}

class CustomSwitch extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;
  const CustomSwitch({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 39.w,
      height: 22.h,
      child: FittedBox(
        fit: BoxFit.cover,
        child: CupertinoSwitch(
          value: value,
          inactiveThumbColor: Color(AppColors.primaryColor),
          thumbColor: context.colorScheme.surface,
          inactiveTrackColor: Colors.grey.withValues(alpha: 0.5),
          activeTrackColor: Color(AppColors.primaryColor),
          trackOutlineWidth: WidgetStatePropertyAll(5),

          // activeColor: Color(AppColors.primaryColor),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
