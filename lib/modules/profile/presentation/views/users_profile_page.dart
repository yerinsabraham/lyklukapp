import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/shared_widget.dart';
import 'package:lykluk/modules/profile/presentation/views/widgets/profile_appbar.dart';

import '../../../ecommerce/presentation/views/ecommerce.dart';
import '../view_model/providers/profile_provider.dart';
import 'widgets/profile_posts.dart';
import 'widgets/profile_tab.dart';

/// other users profile page when you view it
class UsersProfilePage extends HookConsumerWidget {
  final String userId;
  const UsersProfilePage({super.key, required this.userId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItem = ref.watch(usersProfileProvider(userId));
    final selectedTab = useState(0);
    return Scaffold(
      body: asyncItem.when(
        error: (e, _) {
          return AppErrorWidget(
            errorText: e.toString(),
            asyncValue: asyncItem,
            onRetry: () {
              ref.invalidate(usersProfileProvider(userId));
            },
          );
        },
        loading: () {
          return LoadingWithText();
        },
        data:
            (data) => CustomScrollView(
              slivers: [
                ProfileAppBar(user: data),
                SliverToBoxAdapter(
                  child: ProfileTab(
                    onTap: (v) {
                      selectedTab.value = v;
                    },
                  ),
                ),
                // 10.sHs,
                switch (selectedTab.value) {
                  0 => ProfilePosts(userId: data.id.toString()),
                  1 => ProfilePosts(userId: data.id.toString()),
                  2 => StoreProfile(userId:data.id.toString()),
                  _ => ProfilePosts(userId: data.id.toString()),
                },
              ],
            ),
      ),
    );
  }
}
