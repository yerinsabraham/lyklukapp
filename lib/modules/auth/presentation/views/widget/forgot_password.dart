import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/shared_widget.dart';
import 'package:lykluk/modules/auth/presentation/view_model/state/auth_state.dart';
import 'package:lykluk/modules/auth/presentation/view_model/controller/request_controller.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/helpers/toast_notification.dart';

import '../../../../../utils/router/app_router.dart';
import '../../view_model/notifier/auth_notifier.dart';

class ForgotPasswordPage extends HookConsumerWidget {
  const ForgotPasswordPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authChoice = useState(0);
    final state = ref.watch(authNotifierProvider);
    final notifier = ref.read(authNotifierProvider.notifier);
    final controller = useTextEditingController();
    // final phoneController = useTextEditingController();

    final formKey = useMemoized(() => GlobalKey<FormState>());
    Future<void> submitForm() async {
      final form = formKey.currentState;
      if (form == null || !form.validate()) return;
      notifier.forgotPassword(email: controller.text);
    }

    ref.listen(authNotifierProvider, (p, n) {
      n.maybeWhen(
        orElse: () {},
        forgotPasswordSuccess: (m) {
          context.pushNamed(Routes.otpPageRoute);
        },
        forgotPasswordFailure: (message) {
          ToastNotification.alertError(message);
        },
      );
    });

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.sp),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.sH,
              ExitButton(),
              10.sH,
              Text('Forgot password?', style: context.title32),
              5.sH,
              Text(
                'Enter the email or phone number you used to register, a 4 - digit code will be sent to you.',
                style: context.body16Light,
              ),
              20.sH,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      authChoice.value = 0;
                      controller.text = '';
                    },
                    child: Chip(
                      backgroundColor:
                          authChoice.value == 0
                              ? context.colorScheme.primaryContainer
                              : null,
                      label: Text(
                        'Email',
                        style:
                            authChoice.value == 0
                                ? context.body14.copyWith(
                                  color: context.colorScheme.primary,
                                )
                                : context.body14Light,
                      ),
                      side: BorderSide.none,
                    ),
                  ),
                  30.sW,
                  GestureDetector(
                    onTap: () {
                      authChoice.value = 1;
                      controller.text = '';
                    },
                    child: Chip(
                      backgroundColor:
                          authChoice.value == 1
                              ? context.colorScheme.primaryContainer
                              : null,
                      label: Text(
                        'Phone Number',
                        style:
                            authChoice.value == 1
                                ? context.body14.copyWith(
                                  color: context.colorScheme.primary,
                                )
                                : context.body14Light,
                      ),
                      side: BorderSide.none,
                    ),
                  ),
                ],
              ),
              20.sH,
              Visibility(
                visible: authChoice.value == 0,
                replacement: CustomField(
                  
                  controller: controller,
                  hintText: 'Enter your phone number',
                  hintTextsize: 16.sp,
                  borderRadius: 8.r,
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                  formatter: [FilteringTextInputFormatter.digitsOnly],
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                  onChanged: (v) {
                    ref
                        .read(resetPasswordRequest.notifier)
                        .update((cb) => cb.copyWith(to: v));
                  },
                ),
                child: CustomField(
                  controller: controller,
                  hintText: 'Enter your email',
                  // hintTextsize: 20.sp,
                  borderRadius: 8.r,
                  hintTextStyle: context.body16.copyWith(fontSize: 16.sp),
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Please enter email address';
                    }
                    if (!v.isEmail) return 'Please enter a valid email address';

                    return null;
                  },
                  onChanged: (v) {
                    ref
                        .read(resetPasswordRequest.notifier)
                        .update((cb) => cb.copyWith(to: v));
                  },
                ),
              ),
              Spacer(),
              CustomButton(
                isLoading: state is AuthStateForgotPasswordLoading,
                onTap: submitForm,
                buttonText: 'Continue',
              ),
              30.sH,
            ],
          ),
        ),
      ),
    );
  }
}
