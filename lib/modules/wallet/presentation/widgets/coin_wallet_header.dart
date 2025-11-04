import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/theme/theme.dart';

class CoinWalletHeader extends StatefulWidget {
  final int initialIndex;
  final ValueChanged<int>? onTabChanged;

  const CoinWalletHeader({super.key, this.initialIndex = 0, this.onTabChanged});

  @override
  State<CoinWalletHeader> createState() => _CoinWalletHeaderState();
}

class _CoinWalletHeaderState extends State<CoinWalletHeader> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = ["Regular Wallet", "Lyk Coins"];

    return Row(
      children: List.generate(tabs.length, (i) {
        final isSelected = selectedIndex == i;
        return Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() => selectedIndex = i);
              widget.onTabChanged?.call(i);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                /// Tab text
                AppText(
                  text: tabs[i],
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color:
                      isSelected
                          ? Color(AppColors.primaryColor)
                          : Color(AppColors.textColor2),
                ),
                5.sH,
                Divider(
                  height: 2.h,
                  color:
                      isSelected
                          ? Color(AppColors.primaryColor)
                          : Colors.transparent,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
