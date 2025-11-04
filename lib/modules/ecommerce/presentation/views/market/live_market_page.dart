import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

import '../../../../../core/shared/widgets/shared_widget.dart';
import '../../../../../utils/assets_manager.dart';

class LiveMarketPage extends HookConsumerWidget {
  const LiveMarketPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          // Image.asset(ImageAssets.userImage, ),
          Container(
            height: context.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageAssets.prod2Image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(alignment: Alignment.topCenter, child: LiveHeader()),
          Positioned(bottom: 0, left: 0, right: 0, child: LiveCommentSection()),
        ],
      ),
    );
  }
}

class LiveHeader extends StatelessWidget {
  const LiveHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 70.h, left: 14.w),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          radius: 23.r,
          backgroundImage: AssetImage(ImageAssets.post1mage),
        ),
        title: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: context.width * 0.41),
          child: Text(
            'Global Roots 🌍🌳 ',
            style: context.body16Bold.copyWith(
              color: context.colorScheme.surface,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Row(
          children: [
            Text.rich(
              WidgetSpan(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      size: 16.sp,
                      color: context.colorScheme.surface,
                    ),
                    Text(
                      ' 4.5',
                      style: context.body14Light.copyWith(
                        color: context.colorScheme.surface,
                      ),
                    ),
                    Text(
                      '(37.4k)',
                      style: context.body14Light.copyWith(
                        color: context.colorScheme.surface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            5.sW,
            ConnectButton(
              textColor: context.colorScheme.surface,
              borderColor: context.colorScheme.surface,
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlinedButton(
              style: ButtonStyle(
                shape: WidgetStatePropertyAll<OutlinedBorder?>(StadiumBorder()),
                padding: WidgetStatePropertyAll<EdgeInsetsGeometry?>(
                  EdgeInsets.zero,
                ),
              ),
              onPressed: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 10.r,
                    backgroundColor: context.colorScheme.inversePrimary,
                    child: Text('P'),
                  ),
                  5.sW,
                  Text(
                    '2.5k',
                    style: context.body14Light.copyWith(
                      color: context.colorScheme.surface,
                    ),
                  ),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () {
                context.pop();
              },
              style: ButtonStyle(
                shape: WidgetStatePropertyAll<OutlinedBorder?>(CircleBorder()),
                padding: WidgetStatePropertyAll<EdgeInsetsGeometry?>(
                  EdgeInsets.zero,
                ),
              ),
              child: Icon(
                Icons.keyboard_arrow_down,
                size: 20.sp,
                color: context.colorScheme.surface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LiveCommentSection extends StatelessWidget {
  const LiveCommentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3), //
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: context.width * 0.85,
                  height: 300.h,
                  child: ListView.builder(
                    itemCount: 10,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 20.r,
                            backgroundColor: context.colorScheme.inversePrimary,
                            backgroundImage: AssetImage(ImageAssets.userImage),
                          ),
                          title: Text(
                            'User Name',
                            style: context.body14Light.copyWith(
                              color: context.colorScheme.surface,
                            ),
                          ),
                          subtitle: Text('Ohh shoot. I would love to get this'),
                        ),
                      );
                    },
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      IconAssets.upShareIcon,
                      colorFilter: ColorFilter.mode(
                        context.colorScheme.surface,
                        BlendMode.srcIn,
                      ),
                      height: 30.h,
                      width: 30.w,
                    ),
                    Text(
                      'Share',
                      style: context.body12.copyWith(
                        color: context.colorScheme.surface,
                      ),
                    ),
                    30.sH,
                    SvgPicture.asset(
                      IconAssets.walletIcon,
                      colorFilter: ColorFilter.mode(
                        context.colorScheme.surface,
                        BlendMode.srcIn,
                      ),
                      height: 30.h,
                      width: 30.w,
                    ),
                    Text(
                      'Wallet',
                      style: context.body12.copyWith(
                        color: context.colorScheme.surface,
                      ),
                    ),
                    30.sH,
                    SvgPicture.asset(
                      IconAssets.shopIcon,
                      colorFilter: ColorFilter.mode(
                        context.colorScheme.surface,
                        BlendMode.srcIn,
                      ),
                      height: 30.h,
                      width: 30.w,
                    ),
                    Text(
                      'Shop',
                      style: context.body12.copyWith(
                        color: context.colorScheme.surface,
                      ),
                    ),
                    30.sH,
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 30.sp,
                      color: context.colorScheme.surface,
                    ),
                  ],
                ),
              ],
            ),

            ///product section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Product Details',
                        style: context.bodySmall18.copyWith(
                          color: context.colorScheme.surface,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '₦ 500K',
                        style: context.bodySmall18.copyWith(
                          color: context.colorScheme.surface,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'This Djembe is a cultural masterpiece. It creates sounds that you could never imagine.',
                    style: context.body14Light.copyWith(
                      color: context.colorScheme.surface,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          onTap: () {},
                          buttonText: 'Add to Cart',
                          color: context.colorScheme.onSecondary.withValues(
                            alpha: .5,
                          ),
                          textColor: context.colorScheme.surface,
                          radius: 30.r,
                        ),
                      ),
                      20.sW,
                      Expanded(
                        child: CustomElevatedButton(
                          onTap: () {},
                          borderColor: context.colorScheme.primary,
                          radius: 30.r,
                          buttonText: 'Buy now',
                        ),
                      ),
                    ],
                  ),
                  10.sH,
                  CustomField(
                    hintText: 'Say something...',
                    hintColor: context.colorScheme.surface,
                    hintTextsize: 14.sp,
                    hasBorder: true,
                    // maxLines: 2,
                    borderColor: context.colorScheme.surfaceContainerLow
                        .withValues(alpha: .5),
                    borderRadius: 30.r,
                    fillColor: context.colorScheme.surfaceContainerLow
                        .withValues(alpha: 0.5),
                    suffixWidget: Row(
                      mainAxisSize: MainAxisSize.min,

                      children: List.generate(_emoji.length, (index) {
                        return Text(_emoji[index]);
                      }),
                    ),
                  ),
                  30.sH,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const _emoji = ['😀', '😒', '😘'];
