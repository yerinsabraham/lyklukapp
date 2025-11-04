import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/utils/extensions/context_ext.dart';

class CustomRadio<T> extends StatelessWidget {
  final T value;
  final void Function(T)? onTap;
  final T groupValue;

  const CustomRadio({
    super.key,
    required this.groupValue,
    required this.onTap,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;

    return GestureDetector(
      onTap: () {
        onTap?.call(value);
      },
      child: Container(
        width: 30.w,
        height: 30.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              isSelected
                  ? context.colorScheme.primary
                  : context.colorScheme.surface,
          border: Border.all(color: context.colorScheme.primary, width: 2),
        ),
        child: Center(
          child:
              isSelected
                  ? Container(
                    width: 12.w,
                    height: 12.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.colorScheme.surface,
                    ),
                  )
                  : null,
        ),
      ),
    );
  }
}
