import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/auth/presentation/view_model/controller/request_controller.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/helpers/app_sheet.dart';
import 'package:lykluk/utils/router/app_router.dart';
import 'package:lykluk/utils/theme/app_colors.dart';

import '../../../../core/shared/widgets/shared_widget.dart';

class CreatePassword extends HookConsumerWidget {
  const CreatePassword({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVisible = useState(true);
    final passwordController = useTextEditingController();

    // Keep a stable key; no rebuild side-effects.
    final formKey = useMemoized(() => GlobalKey<FormState>());

    useListenable(passwordController);

    final password = passwordController.text.trim();

    final hasEight = password.length >= 8;
    final hasOnlyAllowedChars = RegExp(
      r'^[a-zA-Z0-9@$!%*?&]+$',
    ).hasMatch(password);

    void onContinue() {
      if(formKey.currentState!.validate()){
      context.pushNamed(Routes.dateOfBirthRoute);
      }
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
              Text('Create Password', style: context.title32),
              5.sH,
              Text(
                'Make sure password is at least 8 characters.',
                style: context.body16Light,
              ),
              20.sH,

              // Confirm password
              CustomField(
                controller: passwordController,
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
                onFieldSubmitted: (_) => onContinue(),
                onChanged: (v) {
                  ref
                      .read(signUpRequest.notifier)
                      .update((cb) => cb.copyWith(password: v.trim()));
                },
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
                onTap: onContinue,
                buttonText: 'Done',
                // isLoading: state is AuthStateSignUpLoading,
              ),
              30.sH,
            ],
          ),
        ),
      ),
    );
  }
}
