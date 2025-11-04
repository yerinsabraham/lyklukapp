import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/shared_widget.dart';
import 'package:lykluk/modules/wallet/presentation/components/wallet_tabs.dart';
import 'package:lykluk/modules/wallet/presentation/components/withdraw_page.dart';
import 'package:lykluk/modules/wallet/presentation/widgets/balance_card.dart';
import 'package:lykluk/modules/wallet/presentation/widgets/coin_wallet_header.dart';
import 'package:lykluk/modules/wallet/presentation/widgets/earning_history_tile.dart';
import 'package:lykluk/modules/wallet/presentation/widgets/payment_history_tile.dart';
import 'package:lykluk/modules/wallet/presentation/widgets/performance_section.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/theme/theme.dart';

class WalletPage extends HookConsumerWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMainTab = useState(0); // Regular / Coins
    final selectedSubTab = useState(0); // Earnings / Payments

    return Scaffold(
      backgroundColor: Color(AppColors.buttonColor),
      appBar: AppBar(
        toolbarHeight: 100.h,
        backgroundColor: Color(AppColors.white),
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const ExitButton(),
                20.sW,
                Text('Wallet', style: context.title24),
              ],
            ),
            12.sH,
            CoinWalletHeader(
              initialIndex: selectedMainTab.value,
              onTabChanged: (i) => selectedMainTab.value = i,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WalletTabs(
                initialIndex: selectedSubTab.value,
                onTabChanged: (i) => selectedSubTab.value = i,
              ),

              16.sH,
              const BalanceCard(),
              16.sH,

              selectedSubTab.value == 0
                  ? const PerformanceSection()
                  : const WithdrawPage(),
              16.sH,

              /// Transactions section
              if (selectedSubTab.value == 0)
                EarningsHistorySection(
                  monthTitle: "November 2025",
                  status: "Pending",
                  items: List.generate(
                    7,
                    (_) => {"date": "20/11/2025", "amount": "N 50,000"},
                  ),
                )
              else
                PaymentHistorySection(
                  items: [
                    {
                      "title": "Nov 2025",
                      "amount": "N 6.5M",
                      "status": "Pending",
                    },
                    {
                      "title": "Nov 2025",
                      "amount": "N 6.5M",
                      "status": "Completed",
                    },
                    {
                      "title": "Nov 2025",
                      "amount": "N 6.5M",
                      "status": "Failed",
                    },
                    {
                      "title": "Nov 2025",
                      "amount": "N 6.5M",
                      "status": "Completed",
                    },
                    {
                      "title": "Nov 2025",
                      "amount": "N 6.5M",
                      "status": "Completed",
                    },
                    {
                      "title": "Nov 2025",
                      "amount": "N 6.5M",
                      "status": "Completed",
                    },
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
