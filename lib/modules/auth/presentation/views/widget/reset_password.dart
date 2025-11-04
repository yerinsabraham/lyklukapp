import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/auth/presentation/view_model/state/auth_state.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/helpers/app_sheet.dart';
import 'package:lykluk/utils/router/app_router.dart';
import 'package:lykluk/utils/theme/app_colors.dart';
import '../../../../../core/shared/widgets/shared_widget.dart';
import '../../view_model/notifier/auth_notifier.dart';

class ResetPassword extends HookConsumerWidget {
  final String email;

  /// this can be email or phone number
  final String code;
  const ResetPassword({super.key, required this.email, required this.code});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVisible = useState(true);
    final state = ref.watch(authNotifierProvider);
    final notifier = ref.read(authNotifierProvider.notifier);
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    // Keep a stable key; no rebuild side-effects.
    final formKey = useMemoized(() => GlobalKey<FormState>());
    // Rebuild when text changes — no manual listener or setState needed.
    useListenable(passwordController);
    useListenable(confirmPasswordController);

    final password = passwordController.text.trim();

    final hasEight = password.length >= 8;
    final hasOnlyAllowedChars = RegExp(
      r'^[a-zA-Z0-9@$!%*?&]+$',
    ).hasMatch(password);

    void submitForm() {
      notifier.updatePassword(
        email: email,
        password: passwordController.text.trim(),
        code: code,
      );
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color(AppColors.backgroundColor),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.sH,
              ExitButton(
                onTap: () {
                  AppRouter.router.pop();
                  AppSheet.showSignUpSheet(context);
                },
              ),
              10.sH,
              Text('Reset Password', style: context.title32),
              5.sH,
              Text(
                'Make sure password is at least 8 characters.',
                style: context.body16Light,
              ),
              5.sH,

              // Password
              CustomField(
                controller: passwordController,
                obscuringCharacter: '·',
                hintText: "···········",
                borderRadius: 8.r,
                obscureText: isVisible.value,
                suffixWidget: GestureDetector(
                  onTap: () => isVisible.value = !isVisible.value,
                  child: Icon(
                    isVisible.value
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 16.sp,
                    color: context.colorScheme.onTertiaryFixed,
                  ),
                ),
                validator: (v) {
                  final value = (v ?? '').trim();
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters.';
                  }
                  if (!RegExp(r'^[a-zA-Z0-9@$!%*?&]+$').hasMatch(value)) {
                    return 'Use only letters, numbers, and @\$!%*?&.';
                  }
                  return null;
                },
              ),

              20.sH,

              // Confirm password
              CustomField(
                controller: confirmPasswordController,
                obscureText: isVisible.value,
                obscuringCharacter: '·',
                hintText: "···········",
                borderRadius: 8.r,
                suffixWidget: GestureDetector(
                  onTap: () => isVisible.value = !isVisible.value,
                  child: Icon(
                    isVisible.value
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 16.sp,
                    color: context.colorScheme.onTertiaryFixed,
                  ),
                ),
                validator: (v) {
                  final value = (v ?? '').trim();
                  if (value.isEmpty || value != password) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                onFieldSubmitted: (_) => submitForm(),
              ),

              20.sH,

              // Tips — derived, no ValueListenableBuilder needed
              Visibility(
                visible: hasEight || hasOnlyAllowedChars,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 15.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: context.colorScheme.primaryFixedDim.withValues(
                      alpha: .1,
                    ),
                  ),
                  child: Column(
                    children: [
                      if (hasEight) ...[
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 10.r,
                              backgroundColor: context.colorScheme.primaryFixed
                                  .withValues(alpha: .1),
                              child: Icon(
                                Icons.check,
                                color: context.colorScheme.primary,
                                size: 15.r,
                              ),
                            ),
                            20.sW,
                            Text(
                              '8 to 20 characters',
                              style: context.body14Light.copyWith(
                                color: context.colorScheme.primaryFixedDim,
                              ),
                            ),
                          ],
                        ),
                        10.sH,
                      ],
                      if (hasOnlyAllowedChars)
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 10.r,
                              backgroundColor: context.colorScheme.primaryFixed
                                  .withValues(alpha: .1),
                              child: Icon(
                                Icons.check,
                                color: context.colorScheme.primary,
                                size: 15.r,
                              ),
                            ),
                            20.sW,
                            Text(
                              'Letters, numbers, and special characters',
                              style: context.body14Light.copyWith(
                                color: context.colorScheme.primaryFixedDim,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              CustomButton(
                onTap: submitForm,
                buttonText: 'Done',
                isLoading: state is UpdatePasswordLoading,
              ),
              30.sH,
            ],
          ),
        ),
      ),
    );
  }
}
