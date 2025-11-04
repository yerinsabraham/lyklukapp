import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomLoader extends StatelessWidget {
  final bool isLoading;
  const BottomLoader({
    super.key,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      replacement: const SizedBox.shrink(),
      child: Padding(
        padding: EdgeInsets.only(bottom: 30.h),
        child: SizedBox(
          height: 20.h,
          width: 20.w,
          child: const CupertinoActivityIndicator(),
        ),
      ),
    );
  }
}
