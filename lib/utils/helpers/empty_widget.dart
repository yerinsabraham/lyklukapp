import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

class EmptyWidget extends StatelessWidget {
  final Widget? title;
  final Widget? subTitle;
  const EmptyWidget({super.key, this.subTitle, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // mainAxisSize: MainAxisSize.min,
      children: [
        10.sH,
        title ?? Icon(Icons.hourglass_empty, size: 50),
        10.sH,
        Center(
          child:
              subTitle ??
              Text(
                'Nothing to see here yet',
                style: context.body16.copyWith(
                  fontSize: 18.sp,
                  color: context.colorScheme.inversePrimary,
                ),
              ),
        ),
      ],
    );
  }
}
