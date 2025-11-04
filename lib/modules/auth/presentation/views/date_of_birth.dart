import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/custom_button.dart';
import 'package:lykluk/core/shared/widgets/custom_field.dart';
import 'package:lykluk/core/shared/widgets/exit_button.dart';
import 'package:lykluk/modules/auth/presentation/view_model/state/auth_state.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/helpers/toast_notification.dart';
import 'package:lykluk/utils/theme/app_colors.dart';

import '../../../../utils/router/app_router.dart';
import '../view_model/notifier/auth_notifier.dart';
import '../view_model/controller/request_controller.dart';

class DateOfBirthScreen extends HookConsumerWidget {
  // final SignUpRequest signUpReq;
  const DateOfBirthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authNotifierProvider);
    final notifier = ref.read(authNotifierProvider.notifier);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final dobController = useTextEditingController();
    final selectedDate = useState<DateTime?>(null);
    final cs = context.colorScheme;
    final selectedBg = cs.primary.withValues(alpha: .12);
    String fmt(DateTime d) {
      // yyyy-MM-dd without intl dependency
      final m = d.month.toString().padLeft(2, '0');
      final day = d.day.toString().padLeft(2, '0');
      return '${d.year}-$m-$day';
    }

    int ageInYears(DateTime dob) {
      final now = DateTime.now();
      int years = now.year - dob.year;
      final hasHadBirthday =
          (now.month > dob.month) ||
          (now.month == dob.month && now.day >= dob.day);
      if (!hasHadBirthday) years -= 1;
      return years;
    }

    ref.listen(authNotifierProvider, (p, n) {
      n.maybeWhen(
        orElse: () {},
        signUpSuccess: (authResponse, message) {
          context.goNamed(Routes.navBarRoute);
        },
        signUpFailure: (message) {
          ToastNotification.showCustomNotification(
            title: "Error",
            subtitle: message,
            isSuccess: false,
          );
        },
      );
    });

    Future<void> pickDate() async {
      final now = DateTime.now();
      final initial = DateTime(now.year - 18, now.month, now.day); // Suggest 18
      final first = DateTime(1900, 1, 1);
      final last = now;

      final picked = await showDatePicker(
        context: context,
        barrierColor: selectedBg,
        initialDate: selectedDate.value ?? initial,
        firstDate: first,
        lastDate: last,
        helpText: 'Select your date of birth',

        builder: (ctx, child) {
          // Keep theme consistent with app
          return Theme(data: ThemeData.light(), child: child!);
        },
      );

      if (picked != null) {
        selectedDate.value = picked;
        dobController.text = fmt(picked);
        ref
            .read(signUpRequest.notifier)
            .update((cb) => cb.copyWith(dob: fmt(picked)));
        // Trigger validation update
        formKey.currentState?.validate();
      }
    }

    void createAccount() {
      if (formKey.currentState?.validate() == true) {
        notifier.signUp(request: ref.read(signUpRequest));
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
              ExitButton(),
              10.sH,
              Text('What’s your date of birth?', style: context.title32),
              5.sH,
              Text(
                'You must be at least 13 years old to continue.',
                style: context.body16Light,
              ),
              20.sH,

              // DOB field (read-only, opens date picker)
              CustomField(
                controller: dobController,
                readOnly: true,
                hintText: 'YYYY-MM-DD',
                borderRadius: 8.r,
                onTap: pickDate,
                suffixWidget: GestureDetector(
                  onTap: pickDate,
                  // onPressed: pickDate,
                  child: Icon(
                    Icons.calendar_month_outlined,
                    size: 18.sp,
                    color: context.colorScheme.onTertiaryFixed,
                  ),
                ),
                validator: (_) {
                  final d = selectedDate.value;
                  if (d == null) return 'Please select your date of birth';
                  final age = ageInYears(d);
                  if (age < 13) return 'You must be at least 13 years old';
                  return null;
                },
              ),

              20.sH,

              // Helper card (optional tips)
              Visibility(
                visible: selectedDate.value != null,
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
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 10.r,
                        backgroundColor: context.colorScheme.primaryFixed
                            .withValues(alpha: .1),
                        child: Icon(
                          Icons.info_outline,
                          color: context.colorScheme.primary,
                          size: 15.r,
                        ),
                      ),
                      12.sW,
                      Expanded(
                        child: Text(
                          'We’ll only use your birthday to verify your age.',
                          style: context.body14Light.copyWith(
                            color: context.colorScheme.primaryFixedDim,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),
              CustomButton(
                onTap: createAccount,
                buttonText: 'Continue',
                isLoading: state is AuthStateSignUpLoading,
              ),
              20.sH,
            ],
          ),
        ),
      ),
    );
  }
}
