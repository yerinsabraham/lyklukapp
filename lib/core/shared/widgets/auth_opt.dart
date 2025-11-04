import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lykluk/modules/auth/presentation/views/components/login_sheet.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

import 'custom_button.dart';

class AuthOpt extends StatelessWidget {
  const AuthOpt({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50.r,
              backgroundColor: context.colorScheme.primaryFixedDim.withValues(
                alpha: 0.2,
              ),
              child: SvgPicture.asset(IconAssets.personIcon, height: 50.h),
            ),
            20.sH,
            Text('Sign in to your account', style: context.body16Light),
            20.sH,
            CustomButton(
              width: context.width * 0.6,
              height: 60.h,
              onTap: () {
                showAuthSheet(context);
              },
              radius: 10.r,
              buttonText: 'Sign in',
              weight: FontWeight.w500,
              textSize: 16.sp,
            ),
          ],
        ),
      ),
    );
  }

  
}

void showAuthSheet(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.r),
        topRight: Radius.circular(20.r),
      ),
    ),
    backgroundColor: Colors.transparent,
    constraints: BoxConstraints(
      minHeight: 500.h,
      maxHeight: context.height * 0.90,
    ),
    builder: (context) {
      return LoginSheet();
    },
  );
}
