import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/app_error_widget.dart';
import 'package:lykluk/core/shared/widgets/bottom_loader.dart';
import 'package:lykluk/core/shared/widgets/loading_widget.dart';
import 'package:lykluk/modules/profile/presentation/view_model/providers/requests_provider.dart';
import 'package:lykluk/modules/profile/presentation/views/widgets/profile_tile.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/helpers/empty_widget.dart';
import 'package:lykluk/utils/hooks/scroll_hook.dart';

class RequestsList extends HookConsumerWidget {
  final String userId;
  final String search;
  final String sortBy;

  const RequestsList({
    super.key,
    required this.userId,
    this.search = "",
    this.sortBy = "Default",
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItems = ref.watch(
      requestsProvider((search: search, sortBy: sortBy)),
    );
    final notifier = ref.read(
      requestsProvider((search: search, sortBy: sortBy)).notifier,
    );
    final controller = usePagination(notifier.loadMore, notifier.canLoadMore);
    return SliverFillRemaining(
      child: RefreshIndicator(
        onRefresh:
            () => ref.refresh(
              requestsProvider((search: search, sortBy: sortBy)).future,
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
                          requestsProvider((search: search, sortBy: sortBy)),
                        );
                      },
                    );
                  },
                  loading: () => Center(child: LoadingWidget()),
                  data: (requests) {
                    if (requests.dataList.isEmpty) {
                      return EmptyWidget();
                    }
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      controller: controller,
                      itemCount: requests.dataList.length,
                      itemBuilder: (c, i) {
                        if (i == requests.dataList.length) {
                          return BottomLoader(
                            isLoading: notifier.canLoadMore(),
                          );
                        } else {
                          final pro = requests.dataList[i];
                          return ProfileTile(
                            profile: pro,
                            onConnectTap: () async {
                              await notifier.requestAccept(
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
