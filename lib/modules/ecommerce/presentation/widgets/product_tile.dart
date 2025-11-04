import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/image_container.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/notifers/product_notifier.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/router/app_router.dart';

import '../../../../core/shared/widgets/circle_icon.dart';
import '../../../../core/shared/widgets/profile_avatar.dart';
import '../../model/market_models.dart';

class ProductTile extends ConsumerWidget {
  // final int index;
  final ProductModel product;
  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final index = Random().nextInt(2);
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          Routes.productDetailsRoute,
          extra: product.id,
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 172.w,
            height: 177.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.black,
           
              
            ),
            child: Stack(
              
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                  ImageContainer(
                  url: product.imageUrls.isEmpty ? null : product.imageUrls.first,
                  height: 177.h,
                  width: 172.w,
                  radius: 10,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w, top: 10.h),
                    child: GestureDetector(
                      onTap: () {
                        ref.read(productNotifierProvider.notifier);
                      },
                      child: CircleIcon(
                        onTap: () {
                          ref
                              .read(productNotifierProvider.notifier)
                              .toggleSaveProduct(product);
                        },
                        color: context.colorScheme.surface.withValues(alpha: 0.3),
                        child: Icon(
                       product.featured?  Icons.favorite :   Icons.favorite_border,
                          color: product.featured? Colors.pink : context.colorScheme.surface,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          5.sH,
          Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ProfileAvatar(
                imageUrl: product.imageUrls.isEmpty ? null : product.imageUrls.first,
                radius: 12,
                placeholderValue:"${product.name?.firstTwo}" ,
              ),
             
              3.sW,
              Text(
                // 'Global Roots 🌍🌳',
                product.name?.capitalize ?? "",
                style: context.body10,
              ),
            ],
          ),

          Text(
            // 'This Djembe is a cultural masterpiece. It creates sounds that you could never imagine.',
            product.description?.capitalize  ?? "",
            style: context.body14Light,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text.rich(
            TextSpan(
              // text: 'Cultural items',
              text: product.store?.name?.capitalize,
              style: context.body14.copyWith(
                color: context.colorScheme.primary,
              ),
              children: [
                WidgetSpan(
                  child: Text(
                    "· ",
                    style: context.body14Bold.copyWith(
                      color: context.colorScheme.inversePrimary,
                    ),
                  ),
                ),
                TextSpan(
                  text: ' ₦ ${product.priceString}',
                  style: context.body14Bold.copyWith(
                    color: context.colorScheme.inversePrimary,
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

class ProductLiveTile extends StatelessWidget {
  // final int index;
  final ProductModel product;
  const ProductLiveTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // final index = Random().nextInt(2);
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.liveProductDetailsRoute);
      },
      child: Column(
        children: [
          Stack(
            children: [
              ImageContainer(
              url: product.imageUrls.isEmpty ?  null: product.imageUrls.first,
               height: 236.h,
                width: 172.w,
                radius: 10,
                
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.h, left: 14.w),
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: context.colorScheme.secondary,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text.rich(
                    TextSpan(
                      text: 'Live',
                      style: context.body14Bold.copyWith(
                        color: context.colorScheme.surface,
                      ),
                      children: [
                        TextSpan(
                          text: ' ·0',
                          style: context.body14Bold.copyWith(
                            color: context.colorScheme.surface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ]),
            10.sH,
           Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ProfileAvatar(imageUrl: null, radius: 12),
              10.sW,
              Text(
                product.name?.capitalize ?? "",
               style: context.body14Bold),
            ],
          ),
            ],),
            
        
        
      );
      

     
    
  }
}
