import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/theme/theme.dart';

class WalletTabs extends StatefulWidget {
  final int initialIndex;
  final ValueChanged<int>? onTabChanged;

  const WalletTabs({super.key, this.initialIndex = 0, this.onTabChanged});

  @override
  State<WalletTabs> createState() => _WalletTabsState();
}

class _WalletTabsState extends State<WalletTabs> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;

    final tabs = ["Earnings", "Payments"];

    return Row(
      children: List.generate(tabs.length, (i) {
        final isSelected = selectedIndex == i;
        return Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() => selectedIndex = i);
              widget.onTabChanged?.call(i);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? context.colorScheme.primary.withValues(alpha: .1)
                        : Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: Text(
                  tabs[i],
                  style:
                      isSelected
                          ? context.body14Bold.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: cs.primary,
                          )
                          : context.body14Bold.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(AppColors.black),
                          ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
