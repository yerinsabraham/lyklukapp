import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/router/app_router.dart';

import '../../../../../core/shared/widgets/shared_widget.dart';
import '../../../model/order_model.dart';

const _tab = ["Ongoing", "Completed", "Cancelled"];

class OrdersPage extends HookConsumerWidget {
  const OrdersPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = useState(0);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            ExitButton(
              child: Icon(
                Icons.keyboard_backspace,
                size: 24.sp,
                color: context.colorScheme.inversePrimary,
              ),
            ),
            20.sW,
            Text("Orders", style: context.title24),
          ],
        ),
        toolbarHeight: 100.h,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.h),
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 14.w,
            ).copyWith(bottom: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: context.colorScheme.onTertiaryFixed.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(_tab.length, (i) {
                return TabContainer(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 5.h,
                  ),
                  onTap: () {
                    selectedTab.value = i;
                  },
                  value: _tab[i],
                  selected: selectedTab.value == i,
                  inActiveColor: Colors.transparent,
                );
              }),
            ),
          ),
        ),
      ),

      body: IndexedStack(
        index: selectedTab.value,
        children: [ OngoiningList(), CompletedList(), CancelledOrderList()],
      ),
    );
  }
}

class CancelledOrderList extends HookConsumerWidget {
  const CancelledOrderList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return 10.sH;
      },
      itemCount: 10,
      itemBuilder: (context, index) {
        final order = OrderModel(
          id: "123456789",
          productId: "123456789",
          productName: "Amara Culture Hub",
          productImage: ImageAssets.post2mage,
          productPrice: 500000.0,
          quantity: 2,
          totalPrice: 1000000.0,
          status: "CANCELLED",
          createdAt: "2022-05-25T10:00:00.000Z",
          updatedAt: "2022-05-25T10:00:00.000Z",
        );
        return OrderTile(
          order: order,
        );
      },
    );
  }
}

class OngoiningList extends HookConsumerWidget {
  const OngoiningList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return 10.sH;
      },
      itemCount: 10,
      itemBuilder: (context, index) {
        final order = OrderModel(
          id: "123456789",
          productId: "123456789",
          productName: "Amara Culture Hub",
          productImage: ImageAssets.post2mage,
          productPrice: 500000.0,
          quantity: 2,
          totalPrice: 1000000.0,
        status: "ONGOING",
          createdAt: "2022-05-25T10:00:00.000Z",
          updatedAt: "2022-05-25T10:00:00.000Z",
        );
        return OrderTile(order: order);
      
      },
    );
  }
}

class CompletedList extends HookConsumerWidget {
  const CompletedList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return 10.sH;
      },
      itemCount: 10,
      itemBuilder: (context, index) {
         final order = OrderModel(
          id: "123456789",
          productId: "123456789",
          productName: "Amara Culture Hub",
          productImage: ImageAssets.post2mage,
          productPrice: 500000.0,
          quantity: 2,
          totalPrice: 1000000.0,
        status: "COMPLETED",
          createdAt: "2022-05-25T10:00:00.000Z",
          updatedAt: "2022-05-25T10:00:00.000Z",
        );
        return OrderTile(order: order);
      },
    );
  }
}

class CompletedItem extends StatelessWidget {
  const CompletedItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.buyerOrderViewRoute);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(10.r),
          border: Border(
            bottom: BorderSide(
              color: context.colorScheme.onSecondary.withValues(alpha: .1),
              width: 1.w,
            ),
          ),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            radius: 20.r,
            backgroundImage: AssetImage(ImageAssets.userImage),
          ),
          title: Text("Amara Culture Hub ", style: context.body16Bold),
          subtitle: Text("2 items ∙ ₦ 500K", style: context.body14Light),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Cancelled',
                style: context.body14.copyWith(
                  color: context.colorScheme.error,
                ),
              ),
              Text(
                'View timeline',
                style: context.body12.copyWith(
                  color: context.colorScheme.onSecondaryFixed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OngoingItem extends StatelessWidget {
  const OngoingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.buyerOrderViewRoute);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(10.r),
          border: Border(
            bottom: BorderSide(
              color: context.colorScheme.onSecondary.withValues(alpha: .1),
              width: 1.w,
            ),
          ),
        ),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                radius: 20.r,
                backgroundImage: AssetImage(ImageAssets.userImage),
              ),
              title: Text("Amara Culture Hub ", style: context.body16Bold),
              subtitle: Text(
                "25th May, 2022, 10:00 AM",
                style: context.body14Light,
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(' ₦ 500K', style: context.body14Bold),
                  Text('Order 123488473', style: context.body12),
                ],
              ),
            ),
            10.sH,
            LayoutBuilder(
              builder: (context, contrainst) {
                return ContainerSeparator(
                  height: 7.h,
                  count: 4,
                  index: 0,
                  onSelect: (v) {},
                  itemWidth: contrainst.maxWidth / 4.5,
                  color: context.colorScheme.onSecondary.withValues(alpha: .1),
                  activeColor: context.colorScheme.onSecondaryFixed,
                );
              },
            ),
            20.sH,
            // Row(children: [Text('On my Way', style: context.body14)])
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TabContainer(
                  value: 'On the way',
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 10.h,
                  ),
                  textSize: 12.sp,
                ),
                Row(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Track order', style: context.body12),
                    10.sW,
                    Icon(Icons.arrow_forward_ios_rounded, size: 16.sp),
                  ],
                ),
              ],
            ),
            10.sH,
          ],
        ),
      ),
    );

    // 10.sH,
  }
}

class OrderTile extends StatelessWidget {
  final OrderModel order;
  const OrderTile({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,

        border: Border(
          bottom: BorderSide(
            color: context.colorScheme.onSecondary.withValues(alpha: .1),
            width: 1.w,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 77.h,
            height: 77.h,
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(10.r),
              image: DecorationImage(
                image: AssetImage(ImageAssets.post2mage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Amara Culture Hub",
                    style: context.body10.copyWith(fontWeight: FontWeight.w400),
                  ),
                  Text("Order 6545", style: context.body10),
                  OrderStatusChip(status: order.status!),
                  Text(
                    "To be delivered between 4, Oct - 30 Nov, 2025",
                    style: context.body10,
                  ),
                ],
              ),
            ),
          ),
          Column(children: [OrderStatusChip(status: order.status! )]),
        ],
      ),
    );
  }
}

class OrderStatusChip extends StatelessWidget {
  final String status;
  const OrderStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final color = switch (status.toLowerCase()) {
      "ongoing" => context.colorScheme.primary,
      "completed" => Colors.green,
      "cancelled" => context.colorScheme.error,
      _ => context.colorScheme.primary,
    };
    return Chip(
      elevation: 0,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      label: Text(status, style: context.body10.copyWith(color: color)),
      side: BorderSide.none,
      color: WidgetStatePropertyAll(color.withValues(alpha: .1)),
      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(8.r),
      ),
      backgroundColor: context.colorScheme.onTertiary.withValues(alpha: .1),
    );
  }
}
