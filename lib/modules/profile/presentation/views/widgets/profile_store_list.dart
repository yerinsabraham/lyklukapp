// ignore_for_file: deprecated_member_use

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/shared_widget.dart';
import 'package:lykluk/modules/ecommerce/model/category_model.dart';
import 'package:lykluk/modules/ecommerce/model/market_models.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/providers/stores_provider.dart';
import 'package:lykluk/modules/ecommerce/presentation/views/ecommerce.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/router/app_router.dart';
import 'package:lykluk/utils/storage/local_storage.dart';

import '../../../../ecommerce/presentation/widgets/market_grid.dart';

class ProfileStoreList extends HookConsumerWidget {
  final String userId;
  const ProfileStoreList({super.key, required this.userId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = useState<CategoryModel?>(null);

    return SliverFillRemaining(
      hasScrollBody: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          // Consumer(
          //   builder: (_, WidgetRef ref, __) {
          //     final categories =
          //         ref.watch(categoriesProvider).valueOrNull ?? [];
          //     // selectedTab.value =
          //     //     categories.isNotEmpty ? categories.first.toString() : "All";
          //     return CategoryTabBar(
          //       // selectedValue: selectedCategory,
          //       filterTabs: [
          //         SvgPicture.asset(
          //           IconAssets.fllterDownIcon,
          //           height: 30.h,
          //           width: 30.w,
          //         ),
          //         10.sW,
          //         CartIcon(
          //           size: Size(40, 40),
          //           radius: 10.r,
          //           onTap: () {
          //             context.pushNamed(Routes.sellersOrderRoute);
          //           },
          //         ),
          //         10.sW,
          //         TabContainer(
          //           value: "All",
          //           selected: selectedCategory.value == null,
          //           onTap: () {
          //             selectedCategory.value = null;
          //             // ref
          //             //     .read(myProductsProvider.notifier)
          //             //     .filter(categoryId: "All");
          //           },
          //         ),
          //       ],
          //       tabs: categories,
          //       selected: selectedCategory.value,
          //       onSelect: (v) {
          //         selectedCategory.value = v;
          //         ref
          //             .read(myProductsProvider.notifier)
          //             .filter(categoryId: v.id.toString());
          //       },
          //     );
          //   },
          // ),
          10.sH,
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              // child: UserStoresGrid(
              //   filter: selectedCategory.value,
              //   userId: userId,
              // ),
              child:
                  userId == HiveStorage.userId
                      ? MyStoresGrid(filter: selectedCategory.value)
                      : UserStoresGrid(
                        filter: selectedCategory.value,
                        userId: userId,
                      ),
            ),
          ),
          // CreateNewStoreBox()
        ],
      ),
    );
  }
}

class MyStoresGrid extends HookConsumerWidget {
  final CategoryModel? filter;

  const MyStoresGrid({super.key, required this.filter});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItems = ref.watch(myStoresProvider);

    return asyncItems.when(
      loading:
          () => ShimmerGrid(
            childAspectRatio: 3 / 3.18,
            child: StoreGridTile(store: StoreModel.empty(),
            ),
          ),
      error: (e, _) {
        return Center(
          child: AppErrorWidget(
            errorText: e.toString(),
            asyncValue: asyncItems,
            onRetry: () {
              ref.invalidate(myStoresProvider);
            },
          ),
        );
      },
      data: (data) {
        if (data.dataList.isEmpty) {
          return Center(child: EmptyProductGrid());
        }
        return RefreshIndicator(
          onRefresh: () async {
            return ref.refresh(myStoresProvider.future);
          },
          child: ProductsGrid(
            childAspectRatio: 3 / 3.18,
            count: data.dataList.length + 1,

            builder: (c, i) {
              if (i == data.dataList.length) {
                return CreateNewStoreBox();
              }
              final item = data.dataList[i];
              return StoreGridTile(store: item);
            },
          ),
        );
      },
    );
  }
}

class UserStoresGrid extends HookConsumerWidget {
  final CategoryModel? filter;
  final String userId;
  const UserStoresGrid({super.key, required this.filter, required this.userId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final asyncItems = ref.watch(profilestoresProvider(userId));
    final asyncItems = ref.watch(myStoresProvider);
    return ProductsGrid(
      count: 4 + 1,
      childAspectRatio: 3 / 3.18,
      // count: 10,
      builder: (c, i) {
        if (userId == HiveStorage.userId && i == 4) {
          return CreateNewStoreBox();
        }
        return StoreGridTile(store: StoreModel.empty());
        // return Container();
        // return ProductTile(product: item);
        // return SizedBox(width: 100.w, height: 100.h);
      },
    );
    // return asyncItems.when(
    //    loading:
          // () => ShimmerGrid(
          //   childAspectRatio: 3 / 3.18,
          //   child: StoreGridTile(store: StoreModel.empty(),
          //   ),
          // ),
    //   error: (e, _) {
    //     return EmptyProductGrid();
    //   },
    //   data: (data) {
    //     if (data.dataList.isEmpty) {
    //       return EmptyProductGrid();
    //     }
    //     return ProductsGrid(
    //       count: data.dataList.length,
    //       // count: 10,
    //       builder: (c, i) {
    //         final item = data.dataList[i];
    //         return StoreGridTile();
    //         // return ProductTile(product: item);
    //         // return SizedBox(width: 100.w, height: 100.h);
    //       },
    //     );
    //   },
    // );
  }
}

class StoreGridTile extends StatelessWidget {
  final StoreModel store;
  const StoreGridTile({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: context.colorScheme.onSecondary.withOpacity(.2),
          width: 1.w,
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ProfileAvatar(
                imageUrl: store.image,
                radius: 20,
                placeholderValue: store.name.firstTwo,
              ),

              10.sW,
              Column(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 80.w,
                    ),
                    child: Text(
                      // "Beauty hut",
                      store.name,
                      maxLines: 1,
                      style: context.body14.copyWith(
                        color: context.colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(IconAssets.productHouseIcon),
                      5.sW,
                      Text(
                        store.count.products.pluralize('product', "products"),
                        style: context.body10,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          10.sH,
          Text(
            // "About the store About About the store About the store About the store the stpyuu... ",
            store.description ?? "",
            style: context.body10,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          10.sH,

          CustomElevatedButton(
            width: 144.w,
            height: 24.h,

            onTap: () {
              context.pushNamed(Routes.storeRoute, extra: store.id);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'View store',
                  style: context.body12.copyWith(
                    color: context.colorScheme.surface,
                  ),
                ),
                10.sW,
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16.sp,
                  color: context.colorScheme.surface,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CreateNewStoreBox extends StatelessWidget {
  const CreateNewStoreBox({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.createStoreRoute);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: SizedBox(
          //  height: 50.h,
          // width: 144.w,
          child: DottedBorder(
            options: RectDottedBorderOptions(
              dashPattern: [4, 8],
              strokeWidth: 2,

              color: context.colorScheme.primary,
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 14.0,
                vertical: 14.0,
              ),
              decoration: BoxDecoration(
                color: context.colorScheme.primary.withValues(alpha: .04),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add,
                    size: 40.sp,
                    color: context.colorScheme.primary,
                  ),
                  5.sH,
                  Text(
                    'Create new store',
                    style: context.body14.copyWith(
                      color: context.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
