import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/utils/theme/texts.dart';

class TabSwitch extends StatelessWidget {
  const TabSwitch({
    super.key,
    required this.items,
    required this.index,
    required this.onChanged,
  });

  final List<String> items;
  final int index;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(items.length, (i) {
        final selected = i == index;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: GestureDetector(
            onTap: () => onChanged(i),
            child: AppText(
              text: items[i],
              fontSize: 12.sp,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              color: selected ? cs.tertiary : cs.primary.withValues(alpha: .6),
            ),
          ),
        );
      }),
    );
  }
}
