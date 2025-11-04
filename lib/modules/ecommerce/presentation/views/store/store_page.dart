import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/bottom_loader.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/notifers/product_notifier.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/notifers/store_notifier.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/providers/store_provider.dart';
import 'package:lykluk/modules/ecommerce/presentation/views/ecommerce.dart';
import 'package:lykluk/modules/ecommerce/presentation/widgets/market_grid.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/hooks/scroll_hook.dart';
import 'package:lykluk/utils/router/app_router.dart';

import '../../../../../core/shared/widgets/shared_widget.dart';
import '../../../model/order_model.dart';
import '../../../model/product_model.dart';
import '../../view_model/providers/stores_provider.dart';
import 'widget/store_line_chart.dart';

class StorePage extends HookConsumerWidget {
  final int storeId;
  const StorePage({super.key, required this.storeId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = useState(0);
    final asyncItem = ref.watch(storeProvider(storeId));

    return asyncItem.when(
      error: (error, stackTrace) {
        final notVerified = error.toString().contains("not verified");
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                ExitButton(
                  onTap: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.goNamed(Routes.navBarRoute);
                    }
                  },
                  child: Icon(
                    Icons.keyboard_backspace_rounded,
                    size: 20.w,
                    color: context.colorScheme.inversePrimary,
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: RefreshIndicator(
              onRefresh: () {
                return ref.refresh(storeProvider(storeId).future);
              },
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    70.sH,
                
                    SvgPicture.asset(IconAssets.timerFrameIcon),
                    30.sH,
                    Text(
                      'We are verifying your store',
                      style: context.title24.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "We are reviewing your information to ensure everything is in order. This usually takes 24-48 hours. We'll notify you via email once your store is approved and ready to go live.",
                      style: context.body16Light.copyWith(
                        color: context.colorScheme.inversePrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    20.sH,
                    CustomButton(
                      onTap: () {
                        context.pushNamed(Routes.verifyStoreRoute, extra: storeId);
                      },
                      buttonText: 'Verify Store',
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      loading: () {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                ExitButton(
                  onTap: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.goNamed(Routes.navBarRoute);
                    }
                  },
                  child: Icon(
                    Icons.keyboard_backspace_rounded,
                    size: 20.w,
                    color: context.colorScheme.inversePrimary,
                  ),
                ),
              ],
            ),
          ),

          body: Center(
            child: CircularProgressIndicator(
              color: context.colorScheme.primary,
            ),
          ),
        );
      },
      data: (store) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(currentStoreProvider.notifier).state = store;
        });
        return Scaffold(
          // backgroundColor: context.colorScheme.surface,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            scrolledUnderElevation: 0,
            // backgroundColor: context.colorScheme.surface,
            surfaceTintColor: context.colorScheme.surface,
            shadowColor: context.colorScheme.surface,
            centerTitle: false,
            title: Row(
              children: [
                ExitButton(
                  onTap: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.goNamed(Routes.navBarRoute);
                    }
                  },
                  child: Icon(
                    Icons.keyboard_backspace_rounded,
                    size: 20.w,
                    color: context.colorScheme.inversePrimary,
                  ),
                ),
                10.sW,
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 240.w),
                  child: Text(
                    // 'Beauty Hut',
                    store.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.title24Bold.copyWith(
                      height: 1,
                      color: context.colorScheme.inversePrimary,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Icon(
                  Icons.more_vert_rounded,
                  size: 35.w,
                  color: context.colorScheme.inversePrimary,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: RefreshIndicator(
              onRefresh: () {
                return ref.refresh(storeProvider(storeId).future);
              },
              child: CustomScrollView(
                slivers: [
                  20.sHs,
                  SliverToBoxAdapter(
                    child: Row(
                      children: [
                        ProfileAvatar(
                          imageUrl: store.image,
                          placeholderValue: store.name.firstTwo,
                          radius: 12,
                        ),

                        10.sW,
                        Expanded(
                          child: Text(store.name, style: context.title24Bold),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Text(
                      // 'About the store About About the store About the store About the store the stpyuu... ',
                      store.description ?? "",
                      style: context.body12,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  20.sHs,
                  SliverToBoxAdapter(
                    child: StoreStats(
                      totalProducts: store.count.products,
                      activeOrders: store.count.orders,
                      pendingOrders: store.count.orders,
                      totalSales: 0,
                    ),
                  ),
                  20.sHs,

                  /// tabs
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    floating: false,
                    snap: false,
                    elevation: 0,
                    // backgroundColor: context.colorScheme.surface,
                    flexibleSpace: StoreTab(
                      tabs: ["Products", "Orders", "Analytics"],
                      selectedIndex: selected.value,
                      products: store.count.products,
                      orders: store.count.orders,

                      onTabTap: (e) {
                        selected.value = e;
                      },
                    ),
                  ),
                  10.sHs,
                  SliverFillRemaining(
                    hasScrollBody: true,
                    child: IndexedStack(
                      index: selected.value,
                      children: [
                        StoreProductList(storeId: storeId),
                        StoreOrderList(storeId: storeId),
                        StoreAnalytics(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class StoreStats extends StatelessWidget {
  final int totalProducts;
  final double totalSales;
  final int activeOrders;
  final int pendingOrders;

  const StoreStats({
    super.key,
    this.totalProducts = 0,
    this.totalSales = 0,
    this.activeOrders = 0,
    this.pendingOrders = 0,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      {"title": "Total Sales", "value": "\$$totalSales"},
      {"title": "Total Products", "value": "$totalProducts"},
      {"title": "Active orders", "value": "$activeOrders"},
      {"title": "Pending orders", "value": "$pendingOrders"},
    ];
    return ProductsGrid(
      childAspectRatio: 3 / 2,
      count: items.length,
      builder: (c, i) {
        return _buildTile(
          context: context,
          title: items[i]['title'] as String,
          value: items[i]['value'] as String,
        );
      },
    );
  }

  Widget _buildTile({
    required BuildContext context,
    required String title,
    required String value,
    Widget? icon,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: context.colorScheme.onSecondary.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(IconAssets.productHouseIcon),
              10.sW,
              Text(title, style: context.body14),
            ],
          ),
          10.sH,
          Text(value, style: context.title24Bold),
        ],
      ),
    );
  }
}

////
class StoreTab extends StatelessWidget {
  final List<String> tabs;
  final Function(int) onTabTap;
  final int products;
  final int orders;
  final int selectedIndex;
  const StoreTab({
    super.key,
    required this.tabs,
    required this.onTabTap,
    this.selectedIndex = 0,
    this.products = 0,
    this.orders = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        color: Color(0xffF1F0F1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(3, (i) {
          return GestureDetector(
            onTap: () {
              onTabTap(i);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color: i == selectedIndex ? context.colorScheme.primary : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    tabs[i],
                    style: context.body14Bold.copyWith(
                      color:
                          i == selectedIndex
                              ? context.colorScheme.surface
                              : context.colorScheme.inversePrimary,
                    ),
                  ),
                  3.sW,
                  Visibility(
                    visible: i <= 1,
                    child: Badge.count(
                      count:
                          i == 0
                              ? products
                              : i == 1
                              ? orders
                              : 0,
                      backgroundColor: context.colorScheme.surface,
                      textColor: context.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class StoreProductList extends HookConsumerWidget {
  final int storeId;
  const StoreProductList({super.key, required this.storeId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItems = ref.watch(storeProductsProvider(storeId));
    final notifier = ref.read(storeProductsProvider(storeId).notifier);
    final scrollController = usePagination(
      notifier.loadMore,
      notifier.canLoadMore,
    );
    return Column(
      children: [
        10.sH,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Product Catalogue',
              style: context.body14.copyWith(
                color: context.colorScheme.inversePrimary,
              ),
            ),
            CustomElevatedButton(
              height: 30.h,
              // width: 115.w,
              onTap: () {
                context.pushNamed(Routes.createProductRoute);
              },
              textSize: 12.sp,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add_rounded,
                    size: 16.w,
                    color: context.colorScheme.surface,
                  ),
                  4.sW,
                  Text(
                    'Add Product',
                    style: context.body12.copyWith(
                      color: context.colorScheme.surface,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        asyncItems.when(
          error: (error, stackTrace) {
            return Center(
              child: AppErrorWidget(
                errorText: error.toString(),
                asyncValue: asyncItems,
                onRetry: () {
                  ref.invalidate(storeProductsProvider(storeId));
                },
              ),
            );
          },
          loading: () {
            return Expanded(
              child: ShimmerList(
                child: StoreProductCard(product: ProductModel.empty()),
              ),
            );
          },
          data: (data) {
            if (data.dataList.isEmpty) {
              return Expanded(
                child: EmptyProductGrid2(
                  message: 'No product found in this store',
                ),
              );
            }
            return Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  return ref.refresh(storeProductsProvider(storeId).future);
                },
                child: ListView.separated(
                  controller: scrollController,
                  separatorBuilder: (c, i) => 10.sH,
                  itemCount: data.dataList.length + 1,
                  itemBuilder: (c, i) {
                    if (i == data.dataList.length) {
                      return BottomLoader(
                        isLoading: asyncItems.isLoading && asyncItems.hasValue,
                      );
                    } else {
                      final prod = data.dataList[i];
                      return StoreProductCard(product: prod);
                    }
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class StoreProductCard extends HookConsumerWidget {
  final ProductModel product;
  const StoreProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.productDetailsRoute, extra: product.id);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(10.r),
          border: Border(
            bottom: BorderSide(
              color: context.colorScheme.onSecondary.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Consumer(
              builder: (_, WidgetRef ref, __) {
                final progress = ref.watch(
                  productImageUploaderProgress(product.id.toString()),
                );
                return Container(
                  height: 92.h,
                  width: 92.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color:
                        product.imageUrls.isEmpty ? Colors.grey.shade400 : null,
                    image:
                        product.imageUrls.isNotEmpty
                            ? DecorationImage(
                              image: CachedNetworkImageProvider(
                                product.imageUrls.first,
                              ),
                              fit: BoxFit.cover,
                            )
                            : null,
                  ),
                  child: Stack(
                    children: [
                      if (product.imageUrls.isEmpty)
                        Center(
                          child: Icon(
                            Icons.image_not_supported_rounded,
                            size: 40.w,
                            color: Colors.black,
                          ),
                        ),
                      progress.maybeWhen(
                        orElse: () => SizedBox.shrink(),
                        // orElse: () => Align(
                        //    alignment: Alignment.center,
                        //   child: CircularProgressIndicator()),
                        data:
                            (data) => Center(
                              child: Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(
                                  value: data,
                                  color: context.colorScheme.primary,
                                ),
                              ),
                            ),
                      ),
                    ],
                  ),
                );
              },
            ),
            10.sW,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  // 'Stanley cup',
                  product.name ?? "",
                  style: context.body16Bold.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'Stocks: ${product.inventory}',

                  style: context.body12,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Colour:',
                  style: context.body12,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                20.sH,

                Text(
                  // '\$5,000,848455',
                  "\$${product.priceString}",
                  style: context.body12Bold.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                // 10.sW,
              ],
            ),
            Spacer(),
            Icon(
              Icons.more_vert_rounded,
              size: 28.w,
              color: context.colorScheme.inversePrimary,
            ),

            // CustomElevatedButton(
            //   height: 30.h,
            //   // width: 115.w,
            //   onTap: () {},
            //   buttonText: 'Edit',
            //   textSize: 12.sp,
            // ),
          ],
        ),
      ),
    );
  }
}

class StoreOrderList extends HookConsumerWidget {
  final int storeId;
  const StoreOrderList({super.key, required this.storeId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItems = ref.watch(storeOrdersProvider(storeId));
    final notifier = ref.read(storeOrdersProvider(storeId).notifier);
    final scrollController = usePagination(
      notifier.loadMore,
      notifier.canLoadMore,
    );
    final tabs = ["All", "New", "Pending", "Ongoing", "Completed"];
    final selected = useState(3);
    return Column(
      children: [
        10.sH,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${asyncItems.valueOrNull?.total ?? 0} ongoing orders',
              style: context.body14.copyWith(
                color: context.colorScheme.inversePrimary,
              ),
            ),
            PopupMenuButton(
              color: context.colorScheme.surface,
              icon: Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.r),
                  color: context.colorScheme.surface,
                  border: Border.all(
                    width: 0.5,
                    color: context.colorScheme.onSecondary.withValues(
                      alpha: 0.1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      tabs[selected.value],
                      style: context.body12.copyWith(
                        color: context.colorScheme.inversePrimary,
                      ),
                    ),
                    4.sW,
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 16.w,
                      color: context.colorScheme.inversePrimary,
                    ),
                  ],
                ),
              ),
              itemBuilder: (c) {
                return List.generate(tabs.length, (i) {
                  final item = tabs[i];
                  return PopupMenuItem(
                    onTap: () {
                      selected.value = i;
                    },
                    child: Text(item, style: context.body12),
                  );
                });
              },
            ),
          ],
        ),
        asyncItems.when(
          error: (error, stackTrace) {
            return Center(
              child: AppErrorWidget(
                errorText: error.toString(),
                asyncValue: asyncItems,
                onRetry: () {
                  ref.invalidate(storeProductsProvider(storeId));
                },
              ),
            );
          },
          loading: () {
            return Expanded(
              child: ShimmerList(
                child: StoreProductCard(product: ProductModel.empty()),
              ),
            );
          },
          data: (data) {
            if (data.dataList.isEmpty) {
              return Expanded(
                child: EmptyProductGrid2(
                  message: 'No product found in this store',
                ),
              );
            }
            return Expanded(
              child: ListView.separated(
                controller: scrollController,
                separatorBuilder: (c, i) => 10.sH,
                itemCount: data.dataList.length + 1,
                itemBuilder: (c, i) {
                  if (i == data.dataList.length) {
                    return BottomLoader(
                      isLoading: asyncItems.isLoading || asyncItems.hasValue,
                    );
                  } else {
                    final prod = data.dataList[i];
                    return StoreOrderCard(order: prod);
                  }
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class StoreOrderCard extends StatelessWidget {
  final OrderModel order;
  const StoreOrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border(
          bottom: BorderSide(
            color: context.colorScheme.onSecondary.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: context.colorScheme.onSecondary.withValues(alpha: 0.1),
                ),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'ORD-002',
                  style: context.title20.copyWith(fontWeight: FontWeight.bold),
                ),
                10.sW,
                Chip(
                  side: BorderSide.none,
                  color: WidgetStatePropertyAll(Color(0xffFFF6E4)),
                  label: Text('Pending', style: context.body12Bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                Spacer(),
                Text('30-06-25', style: context.body14Light),
              ],
            ),
          ),
          10.sH,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Container(
                  height: 92.h,
                  width: 92.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    image: DecorationImage(
                      image: AssetImage(ImageAssets.post2mage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                10.sW,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Stanley cup', style: context.body16),
                    Text(
                      'Stocks: 100',
                      style: context.body12,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Spacer(),
                    20.sH,

                    Text(
                      '\$5,000,848455',
                      style: context.body12Bold.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    // 10.sW,
                  ],
                ),
              ],
            ),
          ),
          10.sH,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    height: 30.h,
                    onTap: () {
                      context.pushNamed(Routes.sellerOrderviewRoute);
                    },
                    buttonText: 'View order',
                    color: context.colorScheme.primaryContainer,
                    textSize: 12.sp,
                    textColor: context.colorScheme.primary,
                  ),
                ),
                30.sW,
                Expanded(
                  child: CustomElevatedButton(
                    height: 30.h,

                    onTap: () {},
                    buttonText: 'Process order',
                    textSize: 12.sp,
                    color: context.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StoreAnalytics extends HookConsumerWidget {
  const StoreAnalytics({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [10.sH, StoreChart(), 10.sH, RateCard(), 20.sH, RateCard()],
      ),
    );
  }
}

class StoreChart extends HookConsumerWidget {
  const StoreChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ["This week", "This month", "This year"];
    final selected = useState(0);
    return Container(
      width: double.infinity,
      // padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          width: 1,
          color: context.colorScheme.onSecondary.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: context.colorScheme.onSecondary.withValues(alpha: 0.1),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total revenue(USD)',
                  style: context.body16.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                  ),
                ),
                Spacer(),
                PopupMenuButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                  ),
                  iconColor: Colors.transparent,
                  icon: OutlinedButton(
                    style: ButtonStyle(
                      visualDensity: VisualDensity(
                        horizontal: -4,
                        vertical: -4,
                      ),
                      padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                      ),
                      // backgroundColor: WidgetStateProperty.all(
                      //   context.colorScheme.primary,
                      // ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                    onPressed: null,
                    child: Row(
                      children: [
                        Text(
                          filters[selected.value],
                          style: context.body14DarkLight,
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 20.w,
                          color: context.colorScheme.inversePrimary,
                        ),
                      ],
                    ),
                  ),
                  itemBuilder: (c) {
                    return List.generate(3, (i) {
                      final item = filters[i];
                      return PopupMenuItem(
                        onTap: () {
                          selected.value = i;
                        },
                        child: Text(item, style: context.body14DarkLight),
                      );
                    });
                  },
                ),
              ],
            ),
          ),

          // Divider(),
          10.sH,
          // Expanded(child: )
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: RevenueChart(),
          ),

          // 20.sH,
        ],
      ),
    );
  }
}

class RateCard extends StatelessWidget {
  const RateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          width: 1,
          color: context.colorScheme.onSecondary.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Total Visitors',
                style: context.body12.copyWith(color: Colors.black),
              ),
              Spacer(),
              Chip(
                side: BorderSide.none,
                avatar: Icon(Icons.arrow_outward_rounded, size: 16.w),
                label: Text('12%'),
              ),
            ],
          ),
          20.sH,
          Text(157367.00.toCurrency, style: context.title24Bold),
          10.sH,
          Text('+158 since yesterday'),
        ],
      ),
    );
  }
}
