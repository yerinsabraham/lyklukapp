import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/providers/auth_status_provider.dart';
import 'package:lykluk/core/shared/widgets/shared_widget.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/providers/stores_provider.dart';
import 'package:lykluk/modules/posts/presentation/view_model/notifiers/video_upload_notifier.dart';
import 'package:lykluk/modules/profile/presentation/view_model/providers/profile_posts_provider.dart';
import 'package:lykluk/modules/profile/presentation/view_model/providers/profile_provider.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

import 'widgets/profile_appbar.dart';
import 'widgets/profile_posts.dart';
import 'widgets/profile_store_list.dart';
import 'widgets/profile_tab.dart';

class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final authStatus = ref.watch(authStateProvider);

    

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar:
          !authStatus
              ? AppBar(
                title: Text(
                  'Profile',
                  style: context.bodySmall18.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                centerTitle: true,
              )
              : null,
      body: !authStatus ? const AuthOpt() : const ProfileBody(),
    );
  }
}

class ProfileBody extends HookConsumerWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = useState(0);
    final asyncItem = ref.watch(profileProvider);
// Listen to flashProvider changes
    ref.listen<bool>(videoRefreshProvider, (previous, next) async {
      if (next) {
        ref.invalidate(profilePostsProvider);
        // ignore: unused_result
        await ref.refresh(profileProvider.future);
        // Optionally reset flashProvider to false after handling
        ref.read(videoRefreshProvider.notifier).state = false;
      }
    });
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(profilePostsProvider);
        ref.invalidate(myStoresProvider);
        return ref.refresh(profileProvider.future);
      },
      child: asyncItem.when(
        error: (e, _) {
          return Center(
            child: AppErrorWidget(
              errorText: e.toString(),
              asyncValue: asyncItem,
              onRetry: () {
                ref.invalidate(profileProvider);
              },
            ),
          );
          // return CustomScrollView(slivers: [ProfileAppBar()]);
        },
        loading: () => const Center(child: LoadingWithText()),
        data: (d) {
          return CustomScrollView(
            slivers: [
              ProfileAppBar(user: d),
              10.sHs,
              SliverToBoxAdapter(
                child: ProfileTab(onTap: (v) => selectedTab.value = v),
              ),
              switch (selectedTab.value) {
                0 => ProfilePosts(userId: d.id.toString()),
                1 => ProfilePosts(userId: d.id.toString()),
                2 => SliverToBoxAdapter(child: Container()),
                3 => ProfileStoreList(userId: d.id.toString()),
                _ => ProfilePosts(userId: d.id.toString()),
              },
            ],
          );
        },
        // orElse: () {
        //   return ProfileAppBar();
        // },
      ),
    );
  }
}

//  SliverAppBar(
//   toolbarHeight: 170.h,
//   // floating: true,
//   // snap: true,
//   centerTitle: false,
//   automaticallyImplyLeading: false,
//   scrolledUnderElevation: 0,
//   expandedHeight: 0,
//   surfaceTintColor: context.colorScheme.surface,

//   title: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     mainAxisSize: MainAxisSize.min,
//     children: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Visibility(
//             visible: user?.profile?.name != null,
//             replacement: OutlinedButton.icon(
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(
//                   context.colorScheme.primary.withValues(alpha: 0.1),
//                 ),
//               ),
//               icon: Icon(Icons.add),
//               onPressed: () {},
//               label: Text("Add name"),
//             ),
//             child: Text(user?.profile?.name ?? "", style: context.title24),
//           ),
//           Padding(
//             padding: EdgeInsets.only(right: 10.w),
//             child: SvgPicture.asset(IconAssets.optionDashIcon),
//           ),
//         ],
//       ),
//       Text(
//         user?.username ?? "",
//         style: context.body16.copyWith(
//           color: context.colorScheme.inversePrimary,
//         ),
//       ),
//       // Row(
//       //   children: [
//       //     SvgPicture.asset(
//       //       IconAssets.shopIcon,
//       //       height: 20.h,
//       //       width: 20.h,
//       //       color: context.colorScheme.primary,
//       //     ),
//       //     Text(
//       //       // 'globalshops',
//       //       "",
//       //       style: context.body16.copyWith(
//       //         color: context.colorScheme.primary,
//       //       ),
//       //     ),
//       //   ],
//       // ),
//     ],
//   ),
//   actionsPadding: EdgeInsets.zero,
//   bottom: PreferredSize(
//     preferredSize: Size.fromHeight(60.h),
//     child: Padding(
//       padding: EdgeInsets.symmetric(horizontal: 14.w),
//       child: Column(
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ConstrainedBox(
//                     constraints: BoxConstraints(
//                       maxWidth: context.width * 0.7,
//                     ),
//                     child: Text(
//                       'Dive into a vibrant community where we bring cultural stories to life.',
//                       style: context.body16Light.copyWith(
//                         color: context.colorScheme.inversePrimary,
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   10.sH,
//                   GestureDetector(
//                     onTap: () {
//                       context.pushNamed(Routes.connectionsRoute);
//                     },
//                     child: Text(
//                       "500 connections | 20k impact",
//                       style: context.body16Light.copyWith(
//                         color: context.colorScheme.inversePrimary,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               CircleAvatar(
//                 radius: 40.r,
//                 backgroundImage: AssetImage(ImageAssets.post1mage),
//               ),
//             ],
//           ),
//           5.sH,
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               CustomElevatedButton(
//                 height: 50.h,
//                 width: context.width * 0.5,
//                 onTap: () {},
//                 textColor: context.colorScheme.inversePrimary.withValues(
//                   alpha: 0.5,
//                 ),
//                 color: context.colorScheme.onSecondary.withValues(
//                   alpha: 0.1,
//                 ),
//                 buttonText: 'Edit Profile',
//               ),
//               10.sW,
//               CustomElevatedButton(
//                 height: 50.h,
//                 onTap: () {},
//                 textColor: context.colorScheme.inversePrimary,
//                 color: context.colorScheme.onSecondary.withValues(
//                   alpha: 0.1,
//                 ),
//                 child: Icon(
//                   Icons.reply_rounded,
//                   size: 30.r,
//                   color: context.colorScheme.inversePrimary,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   ),
// );
//   }
// }
