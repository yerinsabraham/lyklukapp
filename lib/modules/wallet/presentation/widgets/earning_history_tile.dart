import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/theme/theme.dart';

/// Section for monthly earnings
class EarningsHistorySection extends StatelessWidget {
  final String monthTitle;
  final String status;
  final List<Map<String, String>> items;

  const EarningsHistorySection({
    super.key,
    required this.monthTitle,
    required this.status,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    /// Status pill color (for header only)
    Color bgColor;
    Color textColor;

    switch (status) {
      case "Completed":
        bgColor = HexColor('#EAFBF1');
        textColor = Colors.green;
        break;
      case "Failed":
        bgColor = HexColor('#FEEEEE');
        textColor = Colors.red;
        break;
      default: // Pending
        bgColor = HexColor('#FEFAEE');
        textColor = Colors.orange;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: context.colorScheme.outline.withValues(alpha: .2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: monthTitle,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Color(AppColors.black),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            height: 1,
            color: context.colorScheme.outline.withValues(alpha: .1),
          ),

          /// Earnings list
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder:
                (_, __) =>
                    Divider(height: 1, color: Color(AppColors.dividerColor2)),
            itemBuilder: (_, i) {
              final item = items[i];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: item['date'] ?? '',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(AppColors.black),
                    ),
                    AppText(
                      text: "+ ${item['amount']}",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(AppColors.textColor2),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
