import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/shared_widget.dart';
import 'package:lykluk/modules/profile/presentation/view_model/state/profile_state.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

import '../../../../../utils/helpers/toast_notification.dart';
import '../../view_model/notifiers/profile_notifier.dart';
import '../../view_model/providers/profile_provider.dart';

class BioEdit extends HookConsumerWidget {
  const BioEdit({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bio = ref.watch(
      profileProvider.select((v) => v.valueOrNull?.profile?.bio),
    );
    final controller = useTextEditingController(text: bio);

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
              'Bio',
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
            Container(
              padding: EdgeInsets.only(bottom: 5.h),
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: CustomField(
                controller: controller,
                fillColor: context.colorScheme.surface,
                // hintText: 'Enter your name',
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                textCapitalization: TextCapitalization.sentences,
                borderColor: Colors.transparent,
                hintTextStyle: context.body16.copyWith(color: Colors.grey),
                textStyle: context.body16.copyWith(color: Colors.black),
                maxLines: 4,
                borderRadius: 10.r,
                maxLength: 150,
              ),
            ),
            20.sH,
            Container(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
              decoration: BoxDecoration(
                color: context.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(IconAssets.exclamationIcon),
                  10.sW,
                  Expanded(
                    child: Text(
                      "Your bio is visible to everyone on and off LykLuk",
                      style: context.body12.copyWith(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.w500,
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
                    .editProfile(data: {'bio': controller.text.trimRight()});
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
