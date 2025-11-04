// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/shared_widget.dart';
import 'package:lykluk/modules/ecommerce/model/category_model.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/providers/my_products_provider.dart';
import 'package:lykluk/modules/ecommerce/presentation/views/ecommerce.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/router/app_router.dart';
import 'package:lykluk/utils/storage/local_storage.dart';
import '../../view_model/providers/categories_provider.dart';
import '../../widgets/market_grid.dart';
import '../../widgets/product_tile.dart';

class StoreProfile extends HookConsumerWidget {
  final String userId;
  const StoreProfile({super.key, required this.userId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = useState<CategoryModel?>(null);

    return SliverFillRemaining(
      hasScrollBody: true,
      child: Column(
        children: [
          CustomField(
            borderColor: context.colorScheme.onSecondary.withValues(alpha: .2),
            borderRadius: 0,
            textCapitalization: TextCapitalization.sentences,
            // textSize: 16.sp,
            textStyle: context.body16,
            // height: 50.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
            preffixWidget: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(IconAssets.searchIcon),
            ),
            hintText: 'Search market',
            suffixWidget: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    // context.pushNamed(Routes.ordersRoute);
                  },
                  child: Container(
                    // height: 48.h,
                    width: 50.h,
                    padding: EdgeInsets.symmetric(
                      // horizontal: 20.w,
                      vertical: 20.h,
                    ),
                    decoration: BoxDecoration(color: context.colorScheme.scrim),
                    child: Icon(Icons.video_camera_front_sharp, size: 24.sp),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // context.pushNamed(Routes.ordersRoute);
                  },
                  child: Container(
                    // height: 48.h,
                    width: 50.h,
                    padding: EdgeInsets.symmetric(
                      // horizontal: .w,
                      vertical: 20.h,
                    ),
                    decoration: BoxDecoration(
                      color: context.colorScheme.primary,
                    ),
                    child: Icon(Icons.add, size: 24.sp),
                  ),
                ),
              ],
            ),
          ),

          10.sH,
          Consumer(
            builder: (_, WidgetRef ref, __) {
              final categories =
                  ref.watch(categoriesProvider).valueOrNull ?? [];
              // selectedTab.value =
              //     categories.isNotEmpty ? categories.first.toString() : "All";
              return CategoryTabBar(
                // selectedValue: selectedCategory,
                filterTabs: [
                  SvgPicture.asset(
                    IconAssets.fllterDownIcon,
                    height: 30.h,
                    width: 30.w,
                  ),
                  10.sW,
                  CartIcon(
                    size: Size(40, 40),
                    radius: 10.r,
                    onTap: () {
                      context.pushNamed(Routes.sellerOrderviewRoute);
                    },
                  ),
                  10.sW,
                  TabContainer(
                    value: "All",
                    selected: selectedCategory.value == null,
                    onTap: () {
                      selectedCategory.value = null;
                      // ref
                      //     .read(myProductsProvider.notifier)
                      //     .filter(categoryId: "All");
                    },
                  ),
                ],
                tabs: categories,
                selected: selectedCategory.value,
                onSelect: (v) {
                  selectedCategory.value = v;
                  ref
                      .read(myProductsProvider.notifier)
                      .filter(categoryId: v.id.toString());
                },
              );
            },
          ),
          10.sH,
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child:
                  userId == HiveStorage.userId
                      ? MyCategoryGrid(filter: selectedCategory.value)
                      : CategoryGrid(filter: selectedCategory.value),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryGrid extends HookConsumerWidget {
  final CategoryModel? filter;
  const CategoryGrid({super.key, required this.filter});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItems = ref.watch(myProductsProvider);
    return asyncItems.when(
      loading: () => Center(child: LoadingWithText()),
      error: (e, _) {
        return EmptyProductGrid();
      },
      data: (data) {
        if (data.dataList.isEmpty) {
          return EmptyProductGrid();
        }
        return ProductsGrid(
          count: data.dataList.length,
          // count: 10,
          builder: (c, i) {
            final item = data.dataList[i];
            return ProductTile(product: item);
            // return SizedBox(width: 100.w, height: 100.h);
          },
        );
      },
    );
  }
}

class MyCategoryGrid extends HookConsumerWidget {
  final CategoryModel? filter;
  const MyCategoryGrid({super.key, this.filter});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItems = ref.watch(myProductsProvider);
    return asyncItems.when(
      loading: () => Center(child: LoadingWithText()),
      error: (e, _) {
        return EmptyProductGrid();
      },
      data: (data) {
        if (data.dataList.isEmpty) {
          return EmptyProductGrid();
        }
        return ProductsGrid(
          count: data.dataList.length,
          // count: 10,
          builder: (c, i) {
            final item = data.dataList[i];
            return ProductTile(product: item);
            // return SizedBox(width: 100.w, height: 100.h);
          },
        );
      },
    );
  }
}

class EmptyProductGrid extends StatelessWidget {
  const EmptyProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(IconAssets.emptyShopIcons),
        Text(
          'LykLuk Shop',
          style: context.title20.copyWith(fontWeight: FontWeight.w700),
        ),
        Text('Sell items on LykLuk Commerce', style: context.body14Light),
        20.sH,
        CustomElevatedButton(
          onTap: () {
            context.pushNamed(Routes.createStoreRoute);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, size: 24.sp, color: context.colorScheme.surface),
              5.sW,
              Text(
                'Create Shop',
                style: context.body16.copyWith(
                  color: context.colorScheme.surface,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class EmptyProductGrid2 extends StatelessWidget {
  final String? message;
  const EmptyProductGrid2({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.min,
        children: [
          70.sH,
          Center(child: SvgPicture.asset(IconAssets.emptyShopIcons)),
          Center(
            child: Text(
              message ?? 'No products found',
              style: context.title20.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
