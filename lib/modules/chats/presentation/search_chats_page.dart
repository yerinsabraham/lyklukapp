import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/shared_widget.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

import '../../../utils/assets_manager.dart';

class SearchChatsPage extends HookConsumerWidget {
  const SearchChatsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: context.colorScheme.surface,
        shadowColor: context.colorScheme.surface,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
            decoration: BoxDecoration(color: context.colorScheme.surface),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: ExitButton(
                    child: Icon(
                      Icons.keyboard_backspace_rounded,
                      size: 24.sp,
                      color: context.colorScheme.primary,
                    ),
                  ),
                ),
                30.sW,
                Text('New message', style: context.title32),
              ],
            ),
          ),
          // 10.sH,
          Container(
            decoration: BoxDecoration(color: context.colorScheme.surface),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 14.w,
              ).copyWith(bottom: 10.h, top: 10.h),
              child: CustomField(
                borderRadius: 8.r,
                hintText: 'Search',
                fillColor: context.colorScheme.onTertiary.withValues(alpha: .1),
                borderColor: Colors.transparent,
                preffixWidget: Icon(
                  CupertinoIcons.search,
                  size: 24.sp,
                  color: context.colorScheme.onTertiary,
                ),
              ),
            ),
          ),
          10.sH,

          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 14.w,
            ).copyWith(bottom: 10.h),
            color: context.colorScheme.surface,
            child: Text(
              'Suggested',
              style: context.bodySmall18.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          SuggestionList(),
        ],
      ),
    );
  }
}

class SuggestionList extends StatelessWidget {
  const SuggestionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (c, i) {
          return SuggestionTile();
        },
      ),
    );
  }
}

class SuggestionTile extends StatelessWidget {
  const SuggestionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(
          bottom: BorderSide(color: context.colorScheme.onTertiary, width: 0.5),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,

        leading: CircleAvatar(
          radius: 25.r,
          backgroundImage: AssetImage(ImageAssets.userImage),
        ),
        title: Text(
          'Amara Culture Hub',
          style: context.body16,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          'realculturecoture',
          style: context.body14Light,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
