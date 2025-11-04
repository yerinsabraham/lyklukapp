import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/utils/extensions/extensions.dart';


import '../../../data/models/notifcation_model.dart';
import 'notification_tile.dart';

class AllNotification extends StatelessWidget {
  const AllNotification({super.key});

  @override
  Widget build(BuildContext context) {
     return Expanded(
      child: CustomScrollView(
        slivers: [
          SliverList.builder(
            itemCount: demoNotifications.length,
            itemBuilder: (c, i) {
              final notif = demoNotifications[i];
              return NotificitionTile(notif: notif);
            },
          ),
          10.sHs,
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Text('Last 7 days', style: context.body16Bold),
            ),
          ),
          10.sHs,
          SliverList.builder(
            itemCount: demoNotifications.length,
            itemBuilder: (c, i) {
              final notif = demoNotifications[i];
              return NotificitionTile(notif: notif);
            },
          ),
        ],
      ),
    );
  }
}