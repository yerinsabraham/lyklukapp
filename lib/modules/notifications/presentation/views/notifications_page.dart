import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/notifications/presentation/views/widgets/all_notification.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

import '../../../../core/shared/widgets/shared_widget.dart';

class NotificationsPage extends HookConsumerWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = useState('All');
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        elevation: 0,
        title: Row(
          children: [
            ExitButton(
              child: Icon(
                Icons.keyboard_backspace_rounded,
                color: context.colorScheme.primary,
                size: 24.sp,
              ),
            ),
            20.sW,
            Text(
              'Notifications',
              style: context.title24.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTab(
            scrollable: true,
            childPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            padding: EdgeInsets.symmetric(
              vertical: 20.h,
              horizontal: 8.w,
            ).copyWith(bottom: 10.w),
            tabs: ["All", "Requests", "Comments", "Suggestions"],
            onSelect: (v) {
              tab.value = v;
            },
          ),
          10.sH,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Text('New', style: context.body16Bold),
          ),
          10.sH,
          switch (tab.value) {
            'All' => AllNotification(),
            "Requests" => AllNotification(),
            "Comments" => AllNotification(),
            "Suggestions" => Container(),
            _ => AllNotification(),
          },

      
        ],
      ),
    );
  }

  
}

