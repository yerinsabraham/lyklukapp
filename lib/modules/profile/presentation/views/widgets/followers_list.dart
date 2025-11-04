import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/shared_widget.dart';
import 'package:lykluk/modules/profile/presentation/view_model/providers/followers_provider.dart';
import 'package:lykluk/modules/profile/presentation/views/widgets/profile_tile.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/helpers/empty_widget.dart';
import 'package:lykluk/utils/hooks/scroll_hook.dart';

import '../../../../../core/shared/widgets/bottom_loader.dart';

class FollowersList extends HookConsumerWidget {
  final String userId;
  final String search;
  final String sortBy;

  const FollowersList({
    super.key,
    required this.userId,
    this.search = "",
    this.sortBy = "Default",
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItems = ref.watch(
      followersProvider((userId: userId, search: search, sortBy: sortBy)),
    );
    final notifier = ref.read(
      followersProvider((
        userId: userId,
        search: search,
        sortBy: sortBy,
      )).notifier,
    );
    final controller = usePagination(notifier.loadMore, notifier.canLoadMore);
    
    return SliverFillRemaining(
      child: RefreshIndicator(
        onRefresh:
            () => ref.refresh(
              followersProvider((
                userId: userId,
                search: search,
                sortBy: sortBy,
              )).future,
            ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.colorScheme.surface.withValues(alpha: 0.8),
          ),
          child: Column(
            children: [
              Expanded(
                child: asyncItems.when(
                  error: (e, s) {
                    return AppErrorWidget(
                      errorText: e.toString(),
                      asyncValue: asyncItems,
                      onRetry: () {
                        ref.invalidate(
                          followersProvider((
                            userId: userId,
                            search: search,
                            sortBy: sortBy,
                          )),
                        );
                      },
                    );
                  },
                  loading: () => Center(child: LoadingWithText()),
                  data: (followers) {
                    if (followers.dataList.isEmpty) {
                      return EmptyWidget(
                        title: SvgPicture.asset(IconAssets.emptyusersIcon),
                      );
                    }
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      controller: controller,
                      itemCount: followers.dataList.length,
                      itemBuilder: (c, i) {
                        final pro = followers.dataList[i];
                        if (i == followers.dataList.length) {
                          return BottomLoader(
                            isLoading: notifier.canLoadMore(),
                          );
                        } else {
                          return ProfileTile(
                            profile: pro,
                            onConnectTap: () async {
                              await notifier.followUnfollow(
                                userName: pro.following?.username ?? "",
                              );
                            },
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
