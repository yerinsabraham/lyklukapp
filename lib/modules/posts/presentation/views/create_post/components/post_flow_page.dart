import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/components/media_grid_screen.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/components/post_record_screen.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/create_post_page.dart';
import 'package:lykluk/utils/helpers/app_sheet.dart';
import 'package:lykluk/utils/router/app_router.dart';

/// Simple coordinator; you can also replace with your router routes.
class PostFlowPage extends HookConsumerWidget {
  const PostFlowPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = useState(0);

    final pages = [
      PostRecordScreen(
        onAddSound: () => AppSheet.showSongPickerSheet(context),
        onNext: () => page.value = 1,
      ),
      MediaGridScreen(
        onBack: () => page.value = 0,
        onNext: () => page.value = 3,
        onAddSound: () => AppSheet.showSongPickerSheet(context),
      ),
      const SizedBox.shrink(), // (kept if you want a dedicated trim page)
      CreatePostPage(
        onOpenSettings: () => AppSheet.showPostSettingsSheet(context),
        onOpenLocation: () => AppSheet.showLocationSettingsSheet(context),
        onPreview: () {
          AppRouter.router.pushNamed(Routes.previewRoute);
        },
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: PageView(
          controller: usePageController(initialPage: 0),
          physics: const NeverScrollableScrollPhysics(),
          children: pages,
          onPageChanged: (i) => page.value = i,
        ),
      ),
    );
  }
}
