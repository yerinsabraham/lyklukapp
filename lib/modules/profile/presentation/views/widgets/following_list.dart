import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/app_error_widget.dart';
import 'package:lykluk/core/shared/widgets/bottom_loader.dart';
import 'package:lykluk/modules/profile/presentation/views/widgets/profile_tile.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/helpers/empty_widget.dart';
import 'package:lykluk/utils/hooks/scroll_hook.dart';
import 'package:lykluk/core/shared/widgets/loading_widget.dart';

import '../../view_model/providers/following_provider.dart';

class FollowingList extends HookConsumerWidget {
  final String userId;
  final String search;
  final String sortBy;

  const FollowingList({
    super.key,
    required this.userId,
    this.search = "",
    this.sortBy = "Default",
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItems = ref.watch(
      followingProvider((userId: userId, search: search, sortBy: sortBy)),
    );
    final notifier = ref.read(
      followingProvider((
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
              followingProvider((
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
                          followingProvider((
                            userId: userId,
                            search: search,
                            sortBy: sortBy,
                          )),
                        );
                      },
                    );
                  },
                  loading: () => Center(child: LoadingWidget()),
                  data: (following) {
                    if (following.dataList.isEmpty) {
                      return EmptyWidget();
                    }
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      controller: controller,
                      itemCount: following.dataList.length,
                      itemBuilder: (c, i) {
                        if (i == following.dataList.length) {
                          return BottomLoader(
                            isLoading: notifier.canLoadMore(),
                          );
                        } else {
                          final pro = following.dataList[i];
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
