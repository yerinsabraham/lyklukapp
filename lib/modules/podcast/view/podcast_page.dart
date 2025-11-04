import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

import '../../home/presentation/widgets/home_tab.dart' show HomeTab;

class PodcastPage extends HookConsumerWidget {
  const PodcastPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HomeTab(
              //  backgroundColor: context.colorScheme.surface,
              activeIndicator: context.colorScheme.primary,
              inactiveIndicator: context.colorScheme.surface,
            ),
          ],
        ),
      ),
    );
  }
}
