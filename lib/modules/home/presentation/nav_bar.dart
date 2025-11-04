// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/profile_circular_avatar.dart';
import 'package:lykluk/modules/chats/presentation/conversations_page.dart';
import 'package:lykluk/modules/home/presentation/widgets/home_tab.dart';
import 'package:lykluk/modules/ecommerce/presentation/views/market/market_page.dart';
import 'package:lykluk/modules/posts/presentation/view_model/notifiers/camera_notifer.dart';
import 'package:lykluk/modules/profile/presentation/views/profile_page.dart';
import 'package:lykluk/modules/search/presentation/search_page.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/theme/app_colors.dart';

import '../../../utils/router/app_router.dart';
import '../../ecommerce/presentation/views/ecommerce.dart';
import 'home_page.dart';

// final navBarStatusProvider = StateProvider((ref) {
//   final tabState = ref.watch(homeTabController);
//   final canMarketShow = ref.watch(showMarketController);
//   if (tabState == 3 && canMarketShow == false) {
//     return false;
//   }
//   if (tabState == 4) {
//     return false;
//   }
//   return true;
// });

final navbarIndex = StateProvider((ref) => 0);

final navBarStatusProvider = StateProvider((ref) {
  final tabState = ref.watch(homeTabController);
  final canMarketShow = ref.watch(showMarketController);
  if (tabState == 3 && canMarketShow == false) {
    return false;
  }
  if (tabState == 4) {
    return false;
  }
  return true;
});

final navBarVisibilityProvider = StateProvider<bool>((ref) {
  final show = ref.watch(navBarStatusProvider);
  return show; // default: visible
});

// final navbarIndex = StateProvider((ref) => 0);

class NavBar extends HookConsumerWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = useState(0);
    // final isNavVisible = ref.watch(navBarVisibilityProvider);

    final pages = [
      const HomePage(),
      const SearchPage(),
      // const PostFlowPage(), // 👈 keep camera page always alive
      Container(),
      const ConversationsPage(),
      const ProfilePage(),
    ];

    // 👇 Automatically initialize camera when index == 2
    useEffect(() {
      if (currentIndex.value == 2) {
        Future.microtask(() async {
          await ref.read(cameraControllerProvider.notifier).initialize();
        });
      }
      return null; // no cleanup
    }, [currentIndex.value]);

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: IndexedStack(index: currentIndex.value, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:  Color(AppColors.backgroundColor),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex.value,
        onTap: (v) => currentIndex.value = v,
        selectedItemColor: context.colorScheme.primary,
        unselectedItemColor: context.colorScheme.secondaryContainer,
        items: [
          BottomNavigationBarItem(
            label: "",
            icon: SvgPicture.asset(IconAssets.homeIcon, height: 28.h),
            activeIcon: _ActiveNavIcon(
              child: SvgPicture.asset(
                IconAssets.homeIcon,
                color: context.colorScheme.primary,
                height: 24.h,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: SvgPicture.asset(IconAssets.searchIcon, height: 24.h),
            activeIcon: _ActiveNavIcon(
              child: SvgPicture.asset(
                IconAssets.searchIcon,
                color: context.colorScheme.primary,
                height: 24.h,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: GestureDetector(
              onTap: () {
                context.pushNamed(Routes.postRecordRoute);
              },
              child: Container(
                width: 49.w,
                height: 36.h,
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Color(AppColors.black),
                      offset: const Offset(2, 1),
                      blurRadius: 0,
                      spreadRadius: 0.2,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.add,
                  color: context.colorScheme.surface,
                  size: 30.sp,
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: SvgPicture.asset(IconAssets.chatIcon, height: 24.h),
            activeIcon: _ActiveNavIcon(
              child: SvgPicture.asset(
                IconAssets.chatIcon,
                color: context.colorScheme.primary,
                height: 24.h,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            // icon: Image.asset(ImageAssets.profileIcon),
            icon: ProfileCircularAvatar(),
          ),
        ],
      ),
    );
  }
}

/// Helper widget for active nav styling
class _ActiveNavIcon extends StatelessWidget {
  const _ActiveNavIcon({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const StadiumBorder(),
      color: context.colorScheme.primaryFixedDim.withValues(alpha: .1),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: child,
      ),
    );
  }
}
