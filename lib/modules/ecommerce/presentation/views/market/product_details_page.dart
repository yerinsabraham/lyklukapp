import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/ecommerce/model/market_models.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/notifers/cart_notifier.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/notifers/product_notifier.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/providers/product_provider.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/state/cart_state.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/helpers/toast_notification.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../core/shared/widgets/shared_widget.dart';
import '../../../../../utils/router/app_router.dart';
import '../../../../../utils/theme/app_colors.dart';
import '../../view_model/providers/product_recommendations_providers.dart';
import '../../widgets/market_grid.dart';
import '../../widgets/product_tile.dart';
import '../store/store_profile.dart';

class ProductDetails extends HookConsumerWidget {
  final int productId;
  const ProductDetails({super.key, required this.productId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItem = ref.watch(productProvider(productId));
    ref.listen(productNotifierProvider, (p, n) {
      n.maybeWhen(
        orElse: () {},
        saveProductFailed: (message, product) {
          ToastNotification.alertError(message);
        },
      );
    });
    return asyncItem.when(
      error: (e, _) {
        return ProductDetailsEmptyPage(
          isError: true,
          errorMessage: e.toString(),
          asyncValue: asyncItem,
          onRetry: () => ref.invalidate(productProvider(productId)),
        );
      },
      loading:
          () => ProductDetailsEmptyPage(asyncValue: asyncItem, isError: false),
      data: (data) {
        // if(data)
        return BuyerProductView(product: data);
      },
    );
  }
}

/// buyer's view
class BuyerProductView extends HookConsumerWidget {
  final ProductModel product;
  const BuyerProductView({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(cartNotifierProvider, (p, n) {
      n.maybeWhen(
        orElse: () {},
        addingToCartFailed: (m) {
          ToastNotification.alertError(m);
        },
      );
    });
    return Scaffold(
      backgroundColor: context.colorScheme.surface,

      // appBar: AppBar(
      //   backgroundColor: context.colorScheme.surface,
      //   automaticallyImplyLeading: false,
      //   leading: IconButton(
      //     style: ButtonStyle(
      //       shape: WidgetStatePropertyAll(
      //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      //       ),
      //     ),
      //     onPressed: () {
      //       context.pop();
      //     },
      //     icon: Icon(
      //       Icons.keyboard_backspace,
      //       size: 30.sp,
      //       color: Colors.black,
      //     ),
      //   ),
      //   actions: [
      //     CircleIcon(
      //        color: Colors.white,
      //       onTap: () {
      //         context.pushNamed(Routes.cartRoute);

      //       },
      //       child: Icon(
      //         Icons.shopping_cart_outlined,
      //         size: 20.sp,
      //         color: Colors.black,
      //       ),
      //     ),
      //     10.sW,
      //     CircleIcon(
      //        color: Colors.white,
      //       child: Icon(Icons.share_outlined, size: 20.sp, color: Colors.black),
      //     ),
      //     14.sW,
      //   ],
      // ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(productProvider(product.id).future),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              // expandedHeight: 200.h,
              backgroundColor: context.colorScheme.surface,
              pinned: false,
              floating: true,
              snap: true,
              leading: IconButton(
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
                onPressed: () {
                  context.pop();
                },
                icon: Icon(
                  Icons.keyboard_backspace,
                  size: 30.sp,
                  color: Colors.black,
                ),
              ),
              actions: [
                  CircleIcon(
             color: Colors.white,
            onTap: () {
              context.pushNamed(Routes.cartRoute);

            },
            child: Icon(
              Icons.shopping_cart_outlined,
              size: 20.sp,
              color: Colors.black,
            ),
          ),
          10.sW,
          CircleIcon(
             color: Colors.white,
            child: Icon(Icons.share_outlined, size: 20.sp, color: Colors.black),
          ),
          14.sW,
              ],
            ),
            SliverFillRemaining(
              hasScrollBody: true,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    ProductStoreDetails(product: product),
                    10.sH,

                    Padding(
                      padding: EdgeInsets.only(left: 14.w),
                      child: ProductImages(images: product.imageUrls),
                    ),
                    15.sH,

                    /// Product description section
                    ProductDescriptionSection(product: product),

                    30.sH,
                    ProductCounter(productId: product.id),
                    30.sH,

                    /// Tab section
                    ProductDetailTabs(),
                    30.sH,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Text(
                        'More products from this seller',
                        style: context.body14Bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 10.h,
                      ),
                      child: Divider(color: Colors.grey),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: SellerProductGrid(),
                    ),

                    ///
                    // 30.sH,
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 14.w),
                    //   child: CustomButton(onTap: () {}, buttonText: 'Buy now'),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// sellers view
class SellerProductView extends HookConsumerWidget {
  final ProductModel product;
  const SellerProductView({super.key, required this.product});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Color(AppColors.backgroundColor),
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ExitButton(
            child: Icon(
              Icons.keyboard_backspace,
              color: context.colorScheme.inversePrimary,
            ),
          ),
        ),
        title: Text('View Product', style: context.title32),
        actions: [
          CircleIcon(
            child: Icon(Icons.share_outlined, size: 20.sp, color: Colors.black),
          ),
        ],
      ),

      body: RefreshIndicator(
        onRefresh: () => ref.refresh(productProvider(product.id).future),
        child: CustomScrollView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          slivers: [
            // 20.sHs,
            SliverFillRemaining(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    10.sH,
                    Padding(
                      padding: EdgeInsets.only(left: 14.w),
                      child: ProductImages(images: product.imageUrls),
                    ),
                    15.sH,
                    ProductDescriptionSection(product: product),
                    20.sH,

                    /// Tab section
                    ProductDetailTabs(),
                    30.sH,

                    ///
                    // 30.sH,
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 14.w),
                    //   child: CustomButton(onTap: () {}, buttonText: 'Buy now'),
                    // ),
                  ],
                ),
              ),
            ),

            //  SliverPadding(
            //   padding: EdgeInsets.symmetric(horizontal: 14.w),
            //   sliver: SellerProductGrid(),
            // ),
            //
          ],
        ),
      ),
    );
  }
}

class ProductDescriptionSection extends ConsumerWidget {
  const ProductDescriptionSection({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                // 'Monjaro Djembe',
                product.name?.capitalize ?? '',
                style: context.title24,
              ),
              Spacer(),
              CircleIcon(
                onTap: () {
                  ref
                      .read(productNotifierProvider.notifier)
                      .toggleSaveProduct(product);
                },
                child: Icon(
                  product.featured ? Icons.favorite : Icons.favorite_border,
                  size: 20.sp,
                  color:
                      product.featured
                          ? Colors.pink
                          : context.colorScheme.inversePrimary,
                ),
              ),
              // 10.sW,

              // /// share button
              // CircleIcon(child: Icon(Icons.share_outlined, size: 20.sp)),
            ],
          ),
          Text(
            // 'This Djembe is a cultural masterpiece. It creates sounds that you could never imagine.',
            product.description ?? '',
            style: context.body14Light,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              AppRatingBar(initial: 4.5, onRatingUpdate: (v) {}),
              10.sW,
              Text("58,678"),
            ],
          ),
          5.sH,
          Text(' ₦ ${product.priceString}', style: context.title24Bold),
          // Text.rich(
          //   TextSpan(
          //     text: 'Cultural items',
          //     style: context.body14.copyWith(
          //       color: context.colorScheme.primary,
          //     ),
          //     children: [
          //       WidgetSpan(
          //         child: Text(
          //           "· ",
          //           style: context.body14Bold.copyWith(
          //             color: context.colorScheme.inversePrimary,
          //           ),
          //         ),
          //       ),
          //       TextSpan(
          //         text: ' ₦ ${product.priceString}',
          //         style: context.body14Bold.copyWith(
          //           color: context.colorScheme.inversePrimary,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

class ProductStoreDetails extends StatelessWidget {
  const ProductStoreDetails({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          radius: 23.r,
          backgroundImage: AssetImage(ImageAssets.post1mage),
        ),
        title: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: context.width * 0.39),
          child: Text(
            // 'Global Roots 🌍🌳 ',
            product.store?.name ?? '',
            style: context.body16Bold,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Text.rich(
          WidgetSpan(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  size: 16.sp,
                  color: context.colorScheme.inversePrimary,
                ),
                Text(
                  // ' 4.5',
                  product.store?.rating.toString() ?? '0.0',
                  style: context.body14Light.copyWith(
                    color: context.colorScheme.inversePrimary,
                  ),
                ),
                Text(
                  // '(37.4k)',
                  "(${product.store?.followerCount.toGroup ?? '0'})",
                  style: context.body14Light.copyWith(
                    color: context.colorScheme.inversePrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
        trailing: Padding(
          padding: EdgeInsets.only(right: 5.w),
          child: ConnectButton(
            color: context.colorScheme.surface,
            borderColor: context.colorScheme.inversePrimary,
            textColor: context.colorScheme.inversePrimary,
          ),
        ),
      ),
    );
  }
}

class ProductCounter extends HookConsumerWidget {
  const ProductCounter({super.key, required this.productId});
  final int productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantity = useState(1);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Row(
        children: [
          CustomElevatedButton(
            radius: 15.r,
            color: Color(AppColors.lightGrey2Color),
            textColor: context.colorScheme.onSecondary,
            borderColor: context.colorScheme.onSecondary.withValues(alpha: .2),
            onTap: () {
              if (quantity.value > 1) {
                quantity.value--;
              }
            },
            buttonText: '-',
          ),
          10.sW,
          Text('${quantity.value}'),
          10.sW,
          CustomElevatedButton(
            radius: 15.r,
            color: Color(AppColors.lightGrey2Color),
            textColor: context.colorScheme.onSecondary,
            borderColor: context.colorScheme.onSecondary.withValues(alpha: .2),
            onTap: () {
              quantity.value++;
            },
            buttonText: '+',
          ),
          10.sW,
          Expanded(
            child: CustomElevatedButton(
              radius: 15.r,
              isLoading: ref.watch(cartNotifierProvider) is CartAddingToCart,
              color: Color(AppColors.lightGrey2Color),
              textColor: context.colorScheme.primary,

              borderColor: context.colorScheme.onSecondary.withValues(
                alpha: 0.2,
              ),
              onTap: () {
                ref
                    .read(cartNotifierProvider.notifier)
                    .add(productId: productId, quantity: quantity.value);
              },
              buttonText: 'Add to cart',
            ),
          ),
        ],
      ),
    );
  }
}

class ProductImages extends HookConsumerWidget {
  final List<String> images;
  const ProductImages({required this.images, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = usePageController();
    return SizedBox(
      height: context.height * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: images.isNotEmpty,
            replacement: Expanded(
              child: Container(
                height: context.height * 0.2,
                // margin: EdgeInsets.only(right: 50.w),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text('No Image Found', style: context.body16Bold),
                    ),
                    Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        size: 100.sp,
                        color: context.colorScheme.inversePrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            child: Expanded(
              child: PageView.builder(
                controller: controller,
                // viewportFraction: 0.8,
                itemBuilder: (c, i) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: ImageContainer(
                      url: images[i],
                      height: context.height * 0.2,
                      width: context.width * 0.5,
                    ),
                    // Container(
                    //   height: context.height * 0.2,
                    //   // margin: EdgeInsets.only(right: 50.w),
                    //   width: context.width * 0.5,
                    //   decoration: BoxDecoration(
                    //     color: Colors.black,
                    //     borderRadius: BorderRadius.circular(10.r),
                    //     image: DecorationImage(
                    //       image: CachedNetworkImageProvider(images[i]),
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    //   //   child: Image.asset(

                    //   // images[i], fit: BoxFit.cover),
                    // ),
                  );
                },
                itemCount: images.length,
              ),
            ),
          ),
          5.sH,
          if (images.isNotEmpty)
            Center(
              child: SmoothPageIndicator(
                controller: controller, // PageController
                count: images.length, // total number of pages
                effect: WormEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  activeDotColor: context.colorScheme.primary,
                ), // your preferred effect
                onDotClicked: (index) {},
              ),
            ),
        ],
      ),
    );
  }
}

class ProductDetailsEmptyPage extends StatelessWidget {
  final bool isError;
  final String? errorMessage;
  final AsyncValue asyncValue;
  final VoidCallback? onRetry;
  const ProductDetailsEmptyPage({
    super.key,
    this.isError = false,
    this.errorMessage,
    required this.asyncValue,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTileAppbar(),
      body: Center(
        child:
            isError
                ? AppErrorWidget(
                  errorText: errorMessage ?? "",
                  asyncValue: asyncValue,
                  onRetry: onRetry,
                )
                : LoadingWithText(),
      ),
    );
  }
}

class ProductDetailTabs extends HookConsumerWidget {
  const ProductDetailTabs({super.key});
  static const List<String> tabs = ['Overview', 'Specifications', 'Reviews'];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState(0);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(3, (i) {
              final isSelected = i == selectedIndex.value;

              return TabContainer(
                inActiveColor: context.colorScheme.surface,
                value: tabs[i],
                selected: isSelected,
                onTap: () {
                  selectedIndex.value = i;
                },
              );
            }),
          ),
          10.sH,
          switch (selectedIndex.value) {
            0 => ProductDetailOverview(),
            1 => ProductDetailSpecifications(),
            2 => ProductDetailReviews(),
            _ => ProductDetailOverview(),
          },
          // IndexedStack(
          //   index: selectedIndex.value,
          //   children: [
          //     ProductDetailOverview(),
          //     ProductDetailSpecifications(),
          //     ProductDetailReviews(),
          //   ],
          // ),
        ],
      ),
    );
  }
}

class ProductDetailOverview extends StatelessWidget {
  // final String ;
  const ProductDetailOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Clear Voice n Calls Like Face Conversation',
          style: context.body14Bold,
        ),
        Text(
          'FreePods 3 comes with 4-mic beamforming technology to track and provide high-quality voice signals. Then AI Deep Neural Network algorithm is used to reduce surrounding noise. Now your voice is crystal clear to the caller on the other end.',
          style: context.body14.copyWith(fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}

class ProductDetailSpecifications extends StatelessWidget {
  const ProductDetailSpecifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSpecifications(
          context,
          'Battery life',
          'Up to 8 hours play time. Case provides additional 28 hours',
        ),
        5.sH,
        _buildSpecifications(
          context,
          'Battery life',
          'Up to 8 hours play time. Case provides additional 28 hours',
        ),
        5.sH,
        _buildSpecifications(
          context,
          'Battery life',
          'Up to 8 hours play time. Case provides additional 28 hours',
        ),
      ],
    );
  }

  Widget _buildSpecifications(
    BuildContext context,
    String title,
    String value,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: context.body14Bold),
        Text(
          value,
          style: context.body14.copyWith(fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}

class ProductDetailReviews extends HookConsumerWidget {
  const ProductDetailReviews({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final reviews = [];
    final selectedPage = useState(0);
    return
    // ? Center(
    //   child: Padding(
    //     padding: EdgeInsets.symmetric(vertical: 30.h),
    //     child: Text(
    //       'No reviews on this product yet',
    //       style: context.body14ExtraLight,
    //     ),
    //   ),
    // )
    // :
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('5.0', style: context.title32.copyWith(fontSize: 40.sp)),
            5.sW,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppRatingBar(initial: 4.5, onRatingUpdate: (v) {}),
                Text(
                  '50 ratings',
                  style: context.body12.copyWith(
                    color: context.colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
        20.sH,
        Column(
          children: [
            _buildRatingProgress(context: context, value: 56, title: "5 Star"),
            10.sH,
            _buildRatingProgress(context: context, value: 10, title: "4 Star"),
            10.sH,
            _buildRatingProgress(context: context, value: 10, title: "3 Star"),
            10.sH,
            _buildRatingProgress(context: context, value: 18, title: "2 Star"),
            10.sH,
            _buildRatingProgress(context: context, value: 6, title: "1 Star"),
          ],
        ),
        20.sH,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(2, (i) {
            return ReviewTile();
          }),
        ),
        10.sH,
        PaginatedNumberIndicator(
          currentPage: selectedPage.value,
          totalPages: 10,
          onPageChanged: (v) {
            selectedPage.value = v;
          },
        ),
        //   NumberPager(currentIndex: selectedPage.value, onChange: (v) {
        //     selectedPage.value = v;
        //   }, total: 10),
      ],
    );
  }

  Widget _buildRatingProgress({
    required BuildContext context,
    required double value,
    required String title,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: context.body14.copyWith(
            color: context.colorScheme.onSecondary,
          ),
        ),
        10.sW,
        Expanded(
          child: LinearProgressIndicator(
            borderRadius: BorderRadius.circular(10.r),
            minHeight: 8.h,
            value: value / 100,
            backgroundColor: context.colorScheme.onSecondary.withValues(
              alpha: 0.2,
            ),
            valueColor: AlwaysStoppedAnimation(context.colorScheme.primary),
          ),
        ),
        10.sW,

        Text('${value.floor()}%'),
      ],
    );
  }
}

class SellerProductGrid extends HookConsumerWidget {
  final bool isLive;
  const SellerProductGrid({super.key, this.isLive = false});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItems = ref.watch(fypProductsProvider);

    return asyncItems.when(
      loading: () => Center(child: LoadingWithText()),
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
        return SizedBox(
          height: context.height *0.7,
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

class ReviewTile extends StatelessWidget {
  const ReviewTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          minVerticalPadding: 10.h,
          contentPadding: EdgeInsets.zero,
          visualDensity: VisualDensity(horizontal: 4, vertical: -4),
          leading: CircleAvatar(
            radius: 23.r,
            backgroundImage: AssetImage(ImageAssets.post1mage),
          ),
          titleAlignment: ListTileTitleAlignment.top,
          title: Text(
            'Global Roots 🌍🌳 ',
            style: context.body14Light.copyWith(
              color: context.colorScheme.onPrimaryContainer,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text('16 min ago', style: context.body10),
        ),
        AppRatingBar(initial: 4.5, onRatingUpdate: (v) {}),
        Text(
          'Favour is a lorem ipsum Favour is a lorem ipsum  lorem ipsum Favour is a lorem ipsumFavour is a lorem',
          style: context.body14,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
