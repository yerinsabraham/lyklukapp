// video_feed_screen.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/posts/presentation/views/post_feed/views/following_posts_feed.dart';

import '../../ecommerce/presentation/views/ecommerce.dart';
import '../../podcast/view/podcast_page.dart';
import '../../posts/presentation/views/post_feed/views/posts_feed.dart';
import 'widgets/home_tab.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabState = ref.watch(homeTabController);
    return Scaffold(
      body: IndexedStack(
        index: tabState,
        children: [
          PostsFeed(),
          FollowingPostsFeed(),
          PostsFeed(),
          MarketPage(),
          PodcastPage(),
        ],
      ),
    
      
    );
  }
}
