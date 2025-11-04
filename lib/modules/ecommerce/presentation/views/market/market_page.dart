import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/shared_widget.dart';
import 'package:lykluk/modules/ecommerce/model/market_models.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/providers/product_recommendations_providers.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/providers/saved_provider.dart';
import 'package:lykluk/modules/ecommerce/presentation/views/ecommerce.dart';
import 'package:lykluk/modules/ecommerce/presentation/widgets/market_grid.dart';
import 'package:lykluk/modules/ecommerce/presentation/widgets/product_tile.dart';
import 'package:lykluk/modules/home/presentation/widgets/home_tab.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/router/app_router.dart';

final showMarketController = StateProvider((_) => false);
const _tab = ["For you", "Following", "Popular", "Saved"];

class MarketPage extends HookConsumerWidget {
  const MarketPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedValue = useState(0);
    final isLive = useState(false);
    // ref.listen(productNotifierProvider, (p, n) {
    //   n.maybeWhen(
    //     orElse: () {},
    //     saveProductFailed: (msg, _) {
    //       ToastNotification.alertError(msg);
    //     },
    //   );
    // });
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(30.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
            color: Colors.grey.withValues(alpha: .1),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2), // blur effect

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomElevatedButton(
                  height: 38.h,
                  onTap: () {
                    isLive.value = false;
                  },
                  buttonText: "Shop",
                  textColor:
                      isLive.value
                          ? context.colorScheme.primary
                          : context.colorScheme.surface,
                  radius: 30.r,
                  // width: 100.w,
                  color:
                      isLive.value
                          ? Colors.transparent
                          : context.colorScheme.primary,
                ),
                20.sW,
                CustomElevatedButton(
                  height: 38.h,
                  onTap: () {
                    isLive.value = true;
                  },
                  buttonText: "Live",
                  textColor:
                      isLive.value
                          ? context.colorScheme.surface
                          : context.colorScheme.primary,
                  radius: 30.r,
                  color:
                      isLive.value
                          ? context.colorScheme.primary
                          : Colors.transparent,
                ),
              ],
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            snap: false,
            floating: true,
            backgroundColor: context.colorScheme.surface,
            automaticallyImplyLeading: false,
            scrolledUnderElevation: 0,
            expandedHeight: 77.h,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: EdgeInsets.only(top: 60.h),
                child: HomeTab(
                  backgroundColor: context.colorScheme.surface,
                  activeIndicator: context.colorScheme.primary,
                  inactiveIndicator: context.colorScheme.surface,
                ),
              ),
            ),
          ),

          MarketPlaceWidget(
            selected: _tab[selectedValue.value],
            onIndexChanged: (i) {
              selectedValue.value = i;
            },
            // onTabSelected: (v) {
            //   selectedValue.value = v;
            // },
            tabs: _tab,
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            sliver: SliverFillRemaining(
              child: IndexedStack(
                index: selectedValue.value,
                children: [
                  ForYouGrid(isLive: isLive.value),
                  FollowingGrid(isLive: isLive.value),
                  PopularGrid(isLive: isLive.value),
                  SavedGrid(isLive: isLive.value),
                ],
              ),
            ),
          ),

          // IndexedStack()

          //
        ],
      ),
    );
  }
}

// class MarketEntryPages extends HookConsumerWidget {
//   const MarketEntryPages({super.key});
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final pageController = usePageController();
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             pinned: false,
//             snap: false,
//             floating: true,

//             backgroundColor: context.colorScheme.surface,
//             automaticallyImplyLeading: false,
//             scrolledUnderElevation: 0,
//             expandedHeight: 77.h,
//             flexibleSpace: FlexibleSpaceBar(
//               background: Padding(
//                 padding: EdgeInsets.only(top: 60.h),
//                 child: HomeTab(
//                   backgroundColor: context.colorScheme.surface,
//                   activeIndicator: context.colorScheme.primary,
//                   inactiveIndicator: context.colorScheme.surface,
//                 ),
//               ),
//             ),
//           ),
//           SliverFillRemaining(
//             child: PageView(
//               physics: NeverScrollableScrollPhysics(),
//               controller: pageController,
//               children: [
//                 MarketIntroPage(controller: pageController),
//                 MarketGenderPage(controller: pageController),
//                 MarketChoicePage(controller: pageController),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class ForYouGrid extends HookConsumerWidget {
  final bool isLive;
  const ForYouGrid({super.key, this.isLive = false});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItems = ref.watch(fypProductsProvider);

    // return ProductsGrid(
    //   count: 10,
    //   builder: (c, i) {
    //     final p = singleDemoproduct;
    //     return isLive ? ProductLiveTile(product: p) : ProductTile(product: p);
    //     // return SizedBox(width: 100.w, height: 100.h);
    //   },
    // );

    return asyncItems.when(
      loading:
          () => ShimmerGrid(
            childAspectRatio: 3 / 3.18,
            child: ProductTile(product: ProductModel.empty()),
          ),
      error:
          (e, s) => Center(
            child: AppErrorWidget(
              errorText: e.toString(),
              asyncValue: asyncItems,
              onRetry: () {
                ref.invalidate(fypProductsProvider);
              },
            ),
          ),
      data: (data) {
        if (data.dataList.isEmpty) {
          return EmptyProductGrid2(message: "No products to show");
        }
        return RefreshIndicator(
          onRefresh: () => ref.refresh(fypProductsProvider.future),
          child: ProductsGrid(
            count: data.dataList.length,
            builder: (c, i) {
              final p = data.dataList[i];
              return isLive
                  ? ProductLiveTile(product: p)
                  : ProductTile(product: p);
              // return SizedBox(width: 100.w, height: 100.h);
            },
          ),
        );
      },
    );
  }
}

class FollowingGrid extends HookConsumerWidget {
  final bool isLive;
  const FollowingGrid({super.key, this.isLive = false});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItems = ref.watch(followingsProductsProvider);

    return asyncItems.when(
      loading:
          () => ShimmerGrid(
            // childAspectRatio: 3 / 3.18,
            child: ProductTile(product: ProductModel.empty()),
          ),
      error:
          (e, s) => Center(
            child: AppErrorWidget(
              errorText: e.toString(),
              asyncValue: asyncItems,
              onRetry: () {
                ref.invalidate(followingsProductsProvider);
              },
            ),
          ),
      data: (data) {
        if (data.dataList.isEmpty) {
          return EmptyProductGrid2(message: "No products to show");
        }
        return ProductsGrid(
          count: data.dataList.length,
          builder: (c, i) {
            final p = data.dataList[i];
            return isLive
                ? ProductLiveTile(product: p)
                : ProductTile(product: p);
            // return SizedBox(width: 100.w, height: 100.h);
          },
        );
      },
    );
  }
}

class MutualsGrid extends HookConsumerWidget {
  final bool isLive;
  const MutualsGrid({super.key, this.isLive = false});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProductsGrid(
      count: 10,
      builder: (c, i) {
        final p = ProductModel(id: 9, status: "");
        return isLive ? ProductLiveTile(product: p) : ProductTile(product: p);
        // return SizedBox(width: 100.w, height: 100.h);
      },
    );
  }
}

class SavedGrid extends HookConsumerWidget {
  final bool isLive;
  const SavedGrid({super.key, this.isLive = false});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItems = ref.watch(savedProductsProvider);

    return asyncItems.when(
      loading:
          () => ShimmerGrid(
            childAspectRatio: 3 / 3.18,
            child: ProductTile(product: ProductModel.empty()),
          ),
      error:
          (e, s) => Center(
            child: AppErrorWidget(
              errorText: e.toString(),
              asyncValue: asyncItems,
              onRetry: () {
                ref.invalidate(savedProductsProvider);
              },
            ),
          ),
      data: (data) {
        if (data.dataList.isEmpty) {
          return EmptyProductGrid2(message: "No saved products");
        }
        return RefreshIndicator(
          onRefresh: () => ref.refresh(savedProductsProvider.future),
          child: ProductsGrid(
            count: data.dataList.length,
            builder: (c, i) {
              final p = data.dataList[i];
              return isLive
                  ? ProductLiveTile(product: p)
                  : ProductTile(product: p);
              // return SizedBox(width: 100.w, height: 100.h);
            },
          ),
        );
      },
    );
  }
}

class PopularGrid extends HookConsumerWidget {
  final bool isLive;
  const PopularGrid({super.key, this.isLive = false});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItems = ref.watch(popularProductsProvider);

    return asyncItems.when(
      loading:
          () => ShimmerGrid(
            childAspectRatio: 3 / 3.18,
            child: ProductTile(product: ProductModel.empty()),
          ),
      error:
          (e, s) => Center(
            child: AppErrorWidget(
              errorText: e.toString(),
              asyncValue: asyncItems,
              onRetry: () {
                ref.invalidate(popularProductsProvider);
              },
            ),
          ),
      data: (data) {
        if (data.dataList.isEmpty) {
          return EmptyProductGrid2(message: "No popular products");
        }
        return ProductsGrid(
          count: data.dataList.length,
          builder: (c, i) {
            final p = data.dataList[i];
            return isLive
                ? ProductLiveTile(product: p)
                : ProductTile(product: p);
            // return SizedBox(width: 100.w, height: 100.h);
          },
        );
      },
    );
  }
}

class MarketPlaceWidget<T> extends HookConsumerWidget {
  final Function(T)? onTabSelected;
  final List<T> tabs;
  final T selected;
  final Function(int)? onIndexChanged;
  const MarketPlaceWidget({
    super.key,
    this.onTabSelected,
    required this.selected,
    required this.tabs,
    this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final selectedTab = useState(initialValue);
    return SliverToBoxAdapter(
      // hasScrollBody: false,
      child: Column(
        children: [
          CustomField(
            height: 50.h,
            borderColor: context.colorScheme.onSecondary.withValues(alpha: .2),
            maxLines: 1,
            // padding: EdgeInsets.symmetric(vertical: 10.h),
            hintText: 'Seach LykLik Market',
            hintTextsize: 14.sp,
            borderRadius: 0,
            textSize: 16.sp,

            hintColor: context.colorScheme.onSecondary.withValues(alpha: .4),
            preffixWidget: Padding(
              padding: EdgeInsets.all(10.h),
              child: SvgPicture.asset(IconAssets.searchIcon),
            ),
            suffixWidget: CartIcon(),
          ),
          10.sH,
          CategoryTabBar<T>(
            selected: selected,
            filterTabs: [
              SvgPicture.asset(IconAssets.gearIcon),
              10.sW,
              SvgPicture.asset(IconAssets.fllterDownIcon),
              10.sW,
            ],
            // selectedTab: selectedTab,
            // selected: ,
            onSelect: onTabSelected,
            onIndexSelected: onIndexChanged,
            tabs: tabs,
            // onTabSelected: (index) {},
          ),
          20.sH,
        ],
      ),
    );
  }
}

class CartIcon extends StatelessWidget {
  final Size? size;
  final double? radius;
  final VoidCallback? onTap;
  const CartIcon({super.key, this.radius, this.size, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onTap ??
          () {
            context.pushNamed(Routes.ordersRoute);
          },
      child: Container(
        height: size?.height ?? 48.h,
        width: size?.width ?? 48.h,
        decoration: BoxDecoration(
          color: context.colorScheme.inversePrimary,
          borderRadius: BorderRadius.circular(radius ?? 0),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: SvgPicture.asset(IconAssets.cartBagIcon),
        ),
      ),
    );
  }
}

class CategoryTabBar<T> extends HookConsumerWidget {
  final List<T> tabs;
  final List<Widget> filterTabs;
  final T? selected;
  final Function(T)? onSelect;
  final Function(int)? onIndexSelected;

  /// list of svg path for filter icons
  const CategoryTabBar({
    super.key,
    required this.tabs,
    required this.filterTabs,
    this.selected,
    this.onSelect,
    this.onIndexSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final selected = useState(tabs.isEmpty ? null : tabs.first);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(left: 14.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...List.generate(filterTabs.length, (i) => filterTabs[i]),
          ...List.generate(
            tabs.length,
            (i) => TabContainer(
              onTap: () {
                onSelect?.call(tabs[i]);
                onIndexSelected?.call(i);
              },
              value: tabs[i].toString(),
              selected: selected == tabs[i],
              inActiveColor: context.colorScheme.surface,
            ),
          ),
        ],
      ),
    );
  }
}

final _product = ProductModel(
  id: 23,
  name: 'Classic Denim Jacket',
  description: 'Stylish blue denim jacket made from premium cotton.',
  price: "49.99",
  status: 'ACTIVE',
  inventory: 30,
  images: [
    'https://example.com/images/denim1.jpg',
    'https://example.com/images/denim2.jpg',
  ],
  category: ProductCategory(id: 1, name: 'Clothing'),
  categoryId: 1,
  store: ProductStore(id: 1, name: 'Lyklik Store', verified: true),
  storeId: 1,
  featured: true,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);
