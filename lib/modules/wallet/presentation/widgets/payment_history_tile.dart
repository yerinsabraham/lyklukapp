import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/theme/theme.dart';

/// SECTION with header + list of payment history
class PaymentHistorySection extends StatelessWidget {
  final List<Map<String, String>> items;

  const PaymentHistorySection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
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
          /// Header
          AppText(
            text: "Payment history",
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Color(AppColors.black),
          ),
          10.sH,
          Divider(height: 1, color: Color(AppColors.dividerColor2)),

          /// List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder:
                (_, __) =>
                    Divider(height: 1, color: Color(AppColors.dividerColor2)),
            itemBuilder: (_, i) {
              final item = items[i];
              return PaymentHistoryTile(
                title: item['title'] ?? '',
                amount: item['amount'] ?? '',
                status: item['status'] ?? '',
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Single payment tile
class PaymentHistoryTile extends StatelessWidget {
  final String title;
  final String amount;
  final String status;

  const PaymentHistoryTile({
    super.key,
    required this.title,
    required this.amount,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
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

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      title: Text(title, style: context.body14Light),
      subtitle: Text(
        amount,
        style: context.body16.copyWith(fontWeight: FontWeight.bold),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: AppText(
              text: status,
              color: textColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          8.sW,
          const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
        ],
      ),
    );
  }
}
