import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/providers/auth_status_provider.dart';
import 'package:lykluk/core/shared/widgets/shared_widget.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/router/app_router.dart';

class ConversationsPage extends HookConsumerWidget {
  const ConversationsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStatus = ref.watch(authStateProvider);

    return !authStatus
        ? AuthOpt()
        : Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                snap: true,
                title: Text('Chats', style: context.title32),
                elevation: 0,
                scrolledUnderElevation: 0,
                actions: [
                  SvgPicture.asset(IconAssets.dashIcon),
                  10.sW,
                  GestureDetector(
                    onTap: () {
                      AppRouter.router.pushNamed(Routes.searchChatsRoute);
                    },
                    child: SvgPicture.asset(IconAssets.editIcon),
                  ),
                  14.sW,
                ],
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(50.h),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                    ).copyWith(bottom: 10.h, top: 10.h),
                    child: GestureDetector(
                      onTap: () {
                        AppRouter.router.pushNamed(Routes.searchChatsRoute);
                      },
                      child: CustomField(
                        enabled: false,

                        borderRadius: 8.r,
                        hintText: 'Search',
                        fillColor: context.colorScheme.onTertiary.withValues(
                          alpha: .1,
                        ),
                        borderColor: Colors.transparent,
                        preffixWidget: Icon(
                          CupertinoIcons.search,
                          size: 24.sp,
                          color: context.colorScheme.onTertiary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              ///  favs section
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: FavChatSection(),
                ),
              ),
              10.sHs,

              ///
              /// list section
              ChatList(),
            ],
          ),
        );
  }
}

class FavChatSection extends HookConsumerWidget {
  const FavChatSection({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 60.h,

      decoration: BoxDecoration(color: context.colorScheme.surface),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (c, i) {
          if (i == 0) {
            return Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: Badge(
                backgroundColor: Colors.transparent,
                offset: Offset(-10, 40),
                label: GestureDetector(
                  onTap: () {
                    AppRouter.router.pushNamed(
                      Routes.chatMessagePageRoute,
                      extra: i.toString(),
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: context.colorScheme.primary,
                    radius: 8.r,
                    child: Icon(
                      Icons.add,
                      size: 15.r,
                      color: context.colorScheme.surface,
                    ),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    AppRouter.router.pushNamed(Routes.chatMessagePageRoute);
                  },
                  child: CircleAvatar(
                    radius: 35.r,
                    backgroundImage: AssetImage(ImageAssets.userImage),
                  ),
                ),
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: GestureDetector(
              onTap: () {
                AppRouter.router.pushNamed(
                  Routes.chatMessagePageRoute,
                  extra: i.toString(),
                );
              },
              child: CircleAvatar(
                radius: 35.r,
                backgroundImage: AssetImage(ImageAssets.userImage),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ChatList extends HookConsumerWidget {
  const ChatList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverList.builder(
      itemBuilder: (c, i) {
        return ChatTile(index: i);
      },
    );
  }
}

class ChatTile extends StatelessWidget {
  final int index;
  const ChatTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppRouter.router.pushNamed(
          Routes.chatMessagePageRoute,
          extra: index.toString(),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          border: Border(
            bottom: BorderSide(
              color: context.colorScheme.onTertiary,
              width: 0.5,
            ),
          ),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.zero,

          leading: CircleAvatar(
            radius: 25.r,
            backgroundImage: AssetImage(ImageAssets.userImage),
          ),
          title: Text(
            'Amara Culture Hub',
            style: context.body16,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            'Hi there, nice to meet you, let’s conn.......................................',
            style: context.body14Light,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 3.r,
                backgroundColor: context.colorScheme.primary,
              ),
              5.sH,
              Text('9m', style: context.body12),
            ],
          ),
        ),
      ),
    );
  }
}
