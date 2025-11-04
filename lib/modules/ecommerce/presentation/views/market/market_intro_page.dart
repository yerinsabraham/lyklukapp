import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/shared_widget.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

import '../../../../../utils/router/app_router.dart';
import '../../../../../utils/theme/app_colors.dart';

class MarketIntroPage extends HookConsumerWidget {
  final PageController controller;

  const MarketIntroPage({super.key, required this.controller});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // 20.sH,
          Image.asset(
            ImageAssets.marketIntrobannerImage,
            fit: BoxFit.fitWidth,
            height: context.height * 0.4,
            width: double.infinity,
          ),
          20.sH,
          Text(
            'Track your orders\n every step of the way',
            style: context.title32.copyWith(height: 1.2),
            textAlign: TextAlign.center,
          ),
          Text(
            'Shop products that match your style \nand interests.',
            textAlign: TextAlign.center,
            style: context.body16Light.copyWith(
              color: context.colorScheme.onSecondary.withValues(alpha: .6),
            ),
          ),
          40.sH,
          // Spacer(flex: 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    height: 60.h,

                    color: Color(AppColors.lightGrey2Color),
                    textColor: context.colorScheme.primary,
                    borderColor: context.colorScheme.onSecondary.withValues(
                      alpha: .2,
                    ),
                    onTap: () {
                      // context.pushNamed(Routes.getShopStartRoute);
                      context.pushNamed(Routes.createStoreRoute);
                    },
                    buttonText: 'Create market',
                  ),
                ),
                10.sW,
                Expanded(
                  child: CustomElevatedButton(
                    height: 60.h,
                    onTap: () {
                      // context.pushNamed(Routes.marketGenderRoute);
                      controller.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    buttonText: 'Start buying',
                  ),
                ),
              ],
            ),
          ),
          // Spacer(flex: 1),
        ],
      ),
    );
  }
}
