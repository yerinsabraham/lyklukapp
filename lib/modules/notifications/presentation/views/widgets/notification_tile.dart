import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/core/shared/widgets/connect_button.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../data/models/notifcation_model.dart';

class NotificitionTile extends StatelessWidget {
  final NotificationModel notif;
  const NotificitionTile({super.key, required this.notif});

  @override
  Widget build(BuildContext context) {
    return switch (notif.type) {
      NotificationType.request => NotificationRequestTile(notif: notif),
      NotificationType.comment => NotificationCommentTile(notif: notif),
      NotificationType.suggestion => NotificationSuggestionTile(
        suggestion: notif,
      ),
      NotificationType.none => Container(),
    };
  }
}


class NotificationRequestTile extends StatelessWidget {
  final NotificationModel notif;
  const NotificationRequestTile({super.key, required this.notif});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          border: Border(
            top: BorderSide(color: context.colorScheme.onTertiary, width: 0.5),
            bottom: BorderSide(
              color: context.colorScheme.onTertiary,
              width: 0.5,
            ),
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
            style: context.body14Bold,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            'Hi there, nice to meet you, let’s conn.',
            style: context.body14,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: ConnectButton(),
        ),
      ),
    );
  }
}

class NotificationCommentTile extends StatelessWidget {
  final NotificationModel notif;
  const NotificationCommentTile({super.key, required this.notif});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          border: Border(
            top: BorderSide(color: context.colorScheme.onTertiary, width: 0.5),
            bottom: BorderSide(
              color: context.colorScheme.onTertiary,
              width: 0.5,
            ),
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
            style: context.body14Bold,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            'Hi there, nice to meet you, let’s conn.',
            style: context.body14,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: ConnectButton(),
        ),
      ),
    );
  }
}

class NotificationSuggestionTile extends StatelessWidget {
  final NotificationModel suggestion;
  const NotificationSuggestionTile({super.key, required this.suggestion});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          border: Border(
            top: BorderSide(color: context.colorScheme.onTertiary, width: 0.5),
            bottom: BorderSide(
              color: context.colorScheme.onTertiary,
              width: 0.5,
            ),
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
            style: context.body14Bold,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text.rich(
            TextSpan(
              text: 'Hi there, nice to meet you, let’s conn.',
              style: context.body14,
              children: [
                WidgetSpan(child: Text(timeago.format(suggestion.createdAt))),
              ],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          trailing: ConnectButton(),
        ),
      ),
    );
  }
}
