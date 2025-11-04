import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/shared_widget.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

import '../../../../../utils/helpers/toast_notification.dart';
import '../../view_model/notifiers/profile_notifier.dart';
import '../../view_model/providers/profile_provider.dart' show profileProvider;
import '../../view_model/state/profile_state.dart';

class UserNameEdit extends HookConsumerWidget {
  const UserNameEdit({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userName = ref.watch(
      profileProvider.select((v) => v.valueOrNull?.username),
    );
    final controller = useTextEditingController(text: userName);

    ref.listen(profileNotifierProvider, (p, n) {
      n.maybeWhen(
        orElse: () {},
        updated: (data, message) {
          context.pop();
          ToastNotification.showCustomNotification(
            title: "Alert",
            subtitle: message,
            isSuccess: true,
          );
        },
        updatingFailed: (e) {
          ToastNotification.showCustomNotification(
            title: "Alert",
            subtitle: e,
            isSuccess: false,
          );
        },
      );
    });
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            ExitButton(),
            20.sW,
            Text(
              'Username',
              style: context.title24Bold.copyWith(
                color: context.colorScheme.inversePrimary,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Column(
          children: [
            30.sH,
            CustomField(
              controller: controller,
              hintText: 'Enter your username',
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
              // textCapitalization: TextCapitalization.sentences,
              borderColor: Colors.transparent,
              hintTextStyle: context.body16.copyWith(color: Colors.grey),
              textStyle: context.body16.copyWith(color: Colors.black),
              borderRadius: 10.r,
            ),
            20.sH,
            Container(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
              decoration: BoxDecoration(
                color: context.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(IconAssets.exclamationIcon),
                  10.sW,
                  Expanded(
                    child: Text(
                      "Help people find your account by using the name you’re known by; either your full name, nickname, or business name.\n\nYou can only change your name twice within 14 days.\n\nYour name is visible to everyone on and off LykLuk.",
                      style: context.body12.copyWith(
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            CustomButton(
              isLoading:
                  ref.watch(profileNotifierProvider) is ProfileStateUpdating,
              onTap: () {
                ref
                    .read(profileNotifierProvider.notifier)
                    .editProfile(data: {'username': controller.text.trimRight()});
              },
              buttonText: 'Done',
            ),
            20.sH,
          ],
        ),
      ),
    );
  }
}
