import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

class AgreementChecker extends StatelessWidget {
  final TextStyle? style;
  final Color? highlightedcolor;
  const AgreementChecker({super.key, required this.iAgree, this.style, this.highlightedcolor});

  final ValueNotifier<bool> iAgree;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FormField<bool>(
          validator: (c) {
            if (!iAgree.value) {
              return 'Please agree to our Terms of Service and Privacy Policy';
            }
            return null;
          },
          builder: (state) {
            return SizedBox(
              height: 40.h,
              width: 40.w,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Checkbox(
                  visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  side: BorderSide(
                    color:
                        state.hasError
                            ? Colors.red
                            : context.colorScheme.primary,
                  ),
                  value: iAgree.value,
                  onChanged: (c) {
                    iAgree.value = !iAgree.value;
                  },
                ),
              ),
            );
          },
        ),
        Expanded(
          child: Text.rich(
            textAlign: TextAlign.start,
            TextSpan(
              text: 'By tapping "Continue", you agree to our ',
              style: style?? context.body12,

              children: [
                TextSpan(
                  text: 'Terms of Service ',
                  style:  (style??context.body12).copyWith(
                    color: highlightedcolor?? context.colorScheme.inversePrimary,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
                TextSpan(text: ' acknowledge our ', style:  style?? context.body12),
                TextSpan(
                  text: 'Privacy Policy',
                  style: ( style??context.body12).copyWith(
                    color: highlightedcolor?? context.colorScheme.inversePrimary,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
                TextSpan(
                  text: ' and confirm that you’re over 18 ',
                  style: style?? context.body12,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
