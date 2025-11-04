import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/shared_widget.dart';
import 'package:lykluk/modules/auth/presentation/view_model/controller/request_controller.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/router/app_router.dart';
import 'package:lykluk/utils/theme/app_colors.dart';

import '../../view_model/notifier/auth_notifier.dart';
import '../../view_model/state/auth_state.dart';

// enum _AuthMethod { email, phone }

class AuthHeader extends HookConsumerWidget {
  final bool isLogin;
  final AuthState state;
  final AuthNotifier notifier;

  const AuthHeader({
    required this.isLogin,
    super.key,
    required this.state,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = context.colorScheme;
    final formKey = useMemoized(GlobalKey<FormState>.new);

    Future<void> onGoogle() async {
      ref.read(authNotifierProvider.notifier).googleSignIn();
    }

    Future<void> onApple() async {
      ref.read(authNotifierProvider.notifier).appleSignIn();
    }

    return Form(
      key: formKey,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const ExitButton(),
          10.sH,
          Center(
            child: Text.rich(
              TextSpan(
                text: isLogin ? 'Sign in for Lyk' : 'Sign up for Lyk',
                style: context.title32,
                children: [
                  TextSpan(
                    text: 'Luk',
                    style: context.title32.copyWith(
                      color: cs.primary.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
          10.sH,
          Center(
            child: Text(
              "Represent your culture. \nSee what's trending.",
              textAlign: TextAlign.center,
              style: context.body16Light.copyWith(
                color: Color(AppColors.textColor2),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          20.sH,
          isLogin ? LoginForm(formKey: formKey) : SignUpForm(formKey: formKey),
          20.sH,
          Row(
            children: [
              Expanded(child: Divider(color: cs.onTertiary)),
              10.sW,
              Text('Or', style: context.body14Light),
              10.sW,
              Expanded(child: Divider(color: cs.onTertiary)),
            ],
          ),
          20.sH,

          // Google
          CustomButton(
            borderColor: cs.onTertiaryFixed,
            color: cs.surface,
            radius: 30.r,
            onTap: onGoogle,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  SvgPicture.asset(IconAssets.google),
                  50.sW,
                  Text('Continue with Google', style: context.body14Light),
                ],
              ),
            ),
          ),
          10.sH,

          // Apple
          CustomButton(
            borderColor: cs.onTertiaryFixed,
            color: cs.surface,
            radius: 30.r,
            onTap: onApple,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  SvgPicture.asset(IconAssets.appleIcon),
                  50.sW,
                  Text('Continue with Apple', style: context.body14Light),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginForm extends HookConsumerWidget {
  final GlobalKey<FormState> formKey;
  const LoginForm({super.key, required this.formKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authChoice = ref.watch(loginRequest.select((b) => b.isEmail));
    final emailCtrl = useTextEditingController();
    final passwordCtrl = useTextEditingController();
    final phoneCtrl = useTextEditingController();
    final showPassword = useState(false);
    final notifier = ref.read(loginRequest.notifier);

    String? validateEmail(String? v) {
      if (v == null || v.isEmpty) return 'Please enter email address';
      if (!v.isEmail) return 'Please enter a valid email address';
      return null;
    }

    String? validatePhone(String? v) {
      if (v == null || v.isEmpty) return 'Please enter a valid phone number';
      return null;
    }

    String? validatePassword(String? v) {
      if (v == null || v.isEmpty) return 'Please enter password';
      if (v.length < 6) return 'Password must be at least 6 characters';
      return null;
    }

    Future<void> onContinue() async {
      if (!(formKey.currentState?.validate() ?? false)) return;

      ref
          .read(authNotifierProvider.notifier)
          .login(request: ref.watch(loginRequest));
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: AuthSwitch(
            index: authChoice ? 0 : 1,
            onSwitch: (index) {
              // authChoice.value = index;
              notifier.update((cb) => cb.copyWith(isEmail: index == 0));
            },
          ),
        ),
        20.sH,
        authChoice
            ? CustomField(
              controller: emailCtrl,
              hintText: 'Enter your email',
              hintTextsize: 16.sp,
              borderRadius: 8.r,
              padding: EdgeInsets.all(15.r),
              validator: validateEmail,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onChanged: (v) {
                ref
                    .read(loginRequest.notifier)
                    .update((cb) => cb.copyWith(email: v));
              },
            )
            : CustomField(
              controller: phoneCtrl,
              hintText: 'Enter your phone number',
              hintTextsize: 16.sp,
              borderRadius: 8.r,
              padding: EdgeInsets.all(15.r),
              formatter: [FilteringTextInputFormatter.digitsOnly],
              validator: validatePhone,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              onChanged: (v) {
                ref
                    .read(loginRequest.notifier)
                    .update((cb) => cb.copyWith(phone: v));
              },
            ),
        12.sH,
        CustomField(
          controller: passwordCtrl,
          hintText: 'Enter your password',
          hintTextsize: 16.sp,
          obscureText: !showPassword.value,
          borderRadius: 8.r,
          padding: EdgeInsets.all(15.r),
          validator: validatePassword,
          textInputAction: TextInputAction.next,
          // If your CustomField uses `suffix` instead, rename this to `suffix`.
          onChanged: (v) {
            ref
                .read(loginRequest.notifier)
                .update((cb) => cb.copyWith(password: v));
          },
          suffixWidget: GestureDetector(
            onTap: () => showPassword.value = !showPassword.value,
            child: Icon(
              showPassword.value ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
          ),
        ),
        20.sH,
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              AppRouter.router.pop();
              AppRouter.router.pushNamed(Routes.forgotPasswordRoute);
            },
            child: Text(
              "Forgot password?",
              textAlign: TextAlign.center,
              style: context.body16Light.copyWith(
                color: context.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        20.sH,
        CustomButton(
          onTap: onContinue,
          buttonText: 'Continue',
          isLoading: ref.watch(authNotifierProvider) is AuthStateLoginLoading,
        ),
      ],
    );
  }
}

class AuthSwitch extends HookConsumerWidget {
  final Function(int) onSwitch;
  final int index;
  const AuthSwitch({super.key, required this.onSwitch, this.index = 0});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final authChoice = useState(0);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => onSwitch(0),
          child: Chip(
            label: Text(
              'Email',
              style:
                  index == 0
                      ? context.body14.copyWith(
                        color: context.colorScheme.primary,
                      )
                      : context.body14Light,
            ),
            backgroundColor:
                index == 0
                    ? context.colorScheme.primary.withValues(alpha: 0.12)
                    : context.colorScheme.surface,
            side: BorderSide.none,
          ),
        ),
        GestureDetector(
          onTap: () => onSwitch(1),
          child: Chip(
            label: Text(
              'Phone Number',
              style:
                  index == 1
                      ? context.body14.copyWith(
                        color: context.colorScheme.primary,
                      )
                      : context.body14Light,
            ),
            backgroundColor:
                index == 1
                    ? context.colorScheme.primary.withValues(alpha: 0.12)
                    : context.colorScheme.surface,
            side: BorderSide.none,
          ),
        ),
      ],
    );
  }
}

class SignUpForm extends HookConsumerWidget {
  final GlobalKey<FormState> formKey;
  const SignUpForm({super.key, required this.formKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authChoice = ref.watch(loginRequest.select((b) => b.isEmail));
    final emailCtrl = useTextEditingController();
    final fullnameCtrl = useTextEditingController();
    final phoneCtrl = useTextEditingController();

    final notifier = ref.read(loginRequest.notifier);

    String? validateEmail(String? v) {
      if (v == null || v.isEmpty) return 'Please enter email address';
      if (!v.isEmail) return 'Please enter a valid email address';
      return null;
    }

    String? validatePhone(String? v) {
      if (v == null || v.isEmpty) return 'Please enter a valid phone number';
      return null;
    }

    String? validateFullname(String? v) {
      if (v == null || v.isEmpty) return 'Please enter your fullname';
      if (v.length < 3) return 'Name must be at least 3 characters';
      return null;
    }

    void onContinue() {
      if (!(formKey.currentState?.validate() ?? false)) return;
      context.pop();
      // context.pushNamed(Routes.otpPageRoute, extra: false);
      context.pushNamed(Routes.createPasswordRoute);
      // context.pushNamed(
      //    Routes.createPasswordRoute,

      //        );

      //  AppRouter.router.pushNamed(
      //         Routes.createPasswordRoute,
      //         extra: req.toJson(),
      //       );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: AuthSwitch(
            index: authChoice ? 0 : 1,
            onSwitch: (index) {
              // authChoice.value = index;
              notifier.update((cb) => cb.copyWith(isEmail: index == 0));
            },
          ),
        ),
        20.sH,
        authChoice
            ? CustomField(
              borderColor: context.colorScheme.onSecondary.withValues(
                alpha: 0.12,
              ),
              controller: emailCtrl,
              hintText: 'Enter your email',
              hintTextsize: 16.sp,
              borderRadius: 8.r,
              padding: EdgeInsets.all(15.r),
              validator: validateEmail,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onChanged: (v) {
                ref
                    .read(signUpRequest.notifier)
                    .update((cb) => cb.copyWith(email: v));
              },
            )
            : CustomField(
              borderColor: context.colorScheme.onSecondary.withValues(
                alpha: 0.12,
              ),

              controller: phoneCtrl,
              hintText: 'Enter your phone number',
              hintTextsize: 16.sp,
              borderRadius: 8.r,
              padding: EdgeInsets.all(15.r),
              formatter: [FilteringTextInputFormatter.digitsOnly],
              validator: validatePhone,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              onChanged: (v) {
                ref
                    .read(signUpRequest.notifier)
                    .update((cb) => cb.copyWith(phone: v));
              },
            ),
        12.sH,
        CustomField(
          borderColor: context.colorScheme.onSecondary.withValues(alpha: 0.12),
          controller: fullnameCtrl,
          hintText: 'Enter your fullname',
          hintTextsize: 16.sp,
          borderRadius: 8.r,
          padding: EdgeInsets.all(15.r),
          validator: validateFullname,
          textInputAction: TextInputAction.next,
          onChanged: (v) {
            ref
                .read(signUpRequest.notifier)
                .update((cb) => cb.copyWith(name: v));
          },
        ),
        20.sH,

        CustomButton(onTap: onContinue, buttonText: 'Continue'),
      ],
    );
  }
}
