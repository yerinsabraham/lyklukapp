import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/auth/presentation/views/components/agreement_sheet.dart';
import 'package:lykluk/modules/auth/presentation/view_model/notifier/auth_notifier.dart';
import 'package:lykluk/modules/auth/presentation/views/widget/auth_header.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/helpers/app_sheet.dart';
import 'package:lykluk/utils/helpers/toast_notification.dart';
import 'package:lykluk/utils/router/app_router.dart';

class SignUpSheet extends HookConsumerWidget {
  const SignUpSheet({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authNotifierProvider);
    final notifier = ref.read(authNotifierProvider.notifier);

    ref.listen(authNotifierProvider, (previous, next) {
      next.maybeWhen(
        orElse: () {},
        appleLoginSuccess: (res, msg) {
          context.pop();
        },
        appleSignInFailure: (msg) {
          ToastNotification.alertError(msg);
        },
        googleLoginSuccess: (res, msg) {
            context.pop();
        },
        googleSignInFailure: (msg) {
            ToastNotification.alertError(msg);
        },
      );
    });
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthHeader(isLogin: false, state: state, notifier: notifier),
            20.sH,
            Center(
              child: Card(
                shape: StadiumBorder(side: BorderSide.none),
                elevation: 0,
                surfaceTintColor: context.colorScheme.primaryContainer
                    .withValues(alpha: 0.1),
                color: context.colorScheme.primaryContainer.withValues(
                  alpha: 0.1,
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: Text.rich(
                    TextSpan(
                      text: 'Already have an account?',
                      style: context.body16Light.copyWith(
                        color: context.colorScheme.primary,
                      ),
                      children: [
                        TextSpan(
                          text: ' Sign in',
                          style: context.body16Bold.copyWith(
                            color: context.colorScheme.primary,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  AppRouter.router.pop();
                                  AppSheet.showLoginSheet(context);
                                },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            10.sH,
            AgreementSheet(fontSize: 14.sp),
          ],
        ),
      ),
    );
  }
}
