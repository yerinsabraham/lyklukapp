import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/custom_button.dart';
import 'package:lykluk/core/shared/widgets/custom_field.dart';
import 'package:lykluk/core/shared/widgets/exit_button.dart';
import 'package:lykluk/modules/auth/presentation/view_model/notifier/auth_notifier.dart';
import 'package:lykluk/modules/auth/presentation/view_model/state/auth_state.dart';
import 'package:lykluk/modules/auth/presentation/view_model/controller/request_controller.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/theme/app_colors.dart';

import '../../../../utils/router/app_router.dart';

class OtpPage extends HookConsumerWidget {
  final bool isReseting;
  const OtpPage({super.key, this.isReseting = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authNotifierProvider);
    final notifier = ref.read(authNotifierProvider.notifier);
    final colorScheme = context.colorScheme;
    final contact =
        isReseting
            ? ref.read(resetPasswordRequest).to
            : ref.read(signUpRequest).isEmailUsed
            ? ref.read(signUpRequest).email
            : ref.read(signUpRequest).phone;
    // void handleOtpCompleted(String code) {
    //   if (code.length != 4) return;

    //   final nextReq =
    //       signUpReq.isReseting == true
    //           ? SignUpRequest(
    //             to: signUpReq.email,
    //             email: signUpReq.email,
    //             phone: signUpReq.phone,
    //             code: int.parse(code),
    //             isReseting: true,
    //           )
    //           : SignUpRequest(
    //             email: signUpReq.email,
    //             phone: signUpReq.phone,
    //             name: signUpReq.name,
    //             terms: signUpReq.terms,
    //             code: int.parse(code),
    //             isReseting: false,
    //           );

    //   AppRouter.router.pushNamed(
    //     Routes.createPasswordRoute,
    //     extra: nextReq.toJson(),
    //   );
    // }

    void handleOtpCompleted(String code) {
      if (code.length != 4) return;
      if (isReseting) {
        context.pushNamed(Routes.resetPasswordRoute);
      } else {
        context.pushNamed(Routes.createPasswordRoute);
      }
    }

    ref.listen(authNotifierProvider, (p, n) {
      n.maybeWhen(
        orElse: () {},
        sendOtpSuccess: (message, otpCode) {
          isReseting
              ? ref
                  .read(resetPasswordRequest.notifier)
                  .update((v) => v.copyWith(code: otpCode))
              : ref
                  .read(signUpRequest.notifier)
                  .update((v) => v.copyWith(code: int.parse(otpCode)));
        },
      );
    });

    return Scaffold(
      backgroundColor: const Color(AppColors.backgroundColor),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.sH,
              ExitButton(
                child: Icon(
                  Icons.keyboard_backspace_rounded,
                  color: colorScheme.primary,
                ),
              ),
              10.sH,
              Text('Enter the 4-digit code', style: context.title32),
              5.sH,
              Text.rich(
                TextSpan(
                  style: context.body16Light,
                  children: [
                    const TextSpan(text: 'A code has been sent to '),
                    TextSpan(
                      text: contact,
                      style: context.body16Light.copyWith(
                        color: const Color(AppColors.primaryColor),
                      ),
                    ),
                    const TextSpan(text: ' Paste the code sent to you here.'),
                  ],
                ),
              ),
              20.sH,
              CustomPinField(
                onChanged: (v) {
                  if (v.length == 4) handleOtpCompleted(v);
                },
              ),
              const Spacer(),
              CustomButton(
                onTap: () {
                  notifier.sendCode(
                    to: contact!,
                    isEmail: contact.contains('@'),
                  );
                },
                isLoading: state is AuthStateSendOtpLoading,
                buttonText: 'Reset code',
                indicatorColor: colorScheme.primary,
                color: colorScheme.onTertiaryFixed.withValues(alpha: .5),
                textColor: colorScheme.primary,
                weight: FontWeight.w500,
                textSize: 16.sp,
                icon: Icon(
                  Icons.refresh_rounded,
                  color: colorScheme.primary,
                  size: 35.r,
                ),
              ),
              20.sH,
              CustomButton(
                onTap: () {},
                isLoading: false,
                buttonText: 'Open mail app',
                weight: FontWeight.w500,
                textSize: 16.sp,
                icon: Icon(
                  Icons.mail_outline_rounded,
                  color: colorScheme.surface,
                ),
              ),
              20.sH,
            ],
          ),
        ),
      ),
    );
  }
}
