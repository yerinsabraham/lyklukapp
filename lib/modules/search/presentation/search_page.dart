import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

import '../../../core/shared/widgets/shared_widget.dart';

class SearchPage extends HookConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = useState('Top');
    final scrollController = useScrollController();
    return Scaffold(
      // appBar: AppBar(
      //   scrolledUnderElevation: 0,
      //   centerTitle: false,
      //   title: Text('Search', style: context.title32),
      //   backgroundColor: Colors.transparent,
      // ),
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            snap: false,
            floating: true,
            // pinned: true,
            elevation: 0,
            scrolledUnderElevation: 0,

            // backgroundColor: Color(AppColors.backgroundColor),
            title: Text('Search', style: context.title32),
            centerTitle: false,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50.h),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                ).copyWith(bottom: 10.h),
                child: CustomField(
                  fillColor: context.colorScheme.onTertiary.withValues(
                    alpha: .1,
                  ),
                  borderRadius: 8.r,
                  hintText: 'Search',
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

          // 20.sHs,
          SearchTab(
            onChanged: (v) {
              tab.value = v;
            },
          ),

          10.sHs,
          SelectedTabBody(tab: tab.value, scrollController: scrollController),
        ],
      ),
    );
  }
}

class SearchTab extends HookConsumerWidget {
  final Function(String)? onChanged;
  const SearchTab({super.key, this.onChanged});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchTab = ["Top", "People", "Posts", "Podcasts"];
    final selected = useState(searchTab[0]);
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        color: context.colorScheme.surface,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(searchTab.length, (i) {
              return GestureDetector(
                onTap: () {
                  selected.value = searchTab[i];
                  onChanged?.call(searchTab[i]);
                },
                child: Container(
                  width: 85.w,
                  height: 30.h,
                  // margin: EdgeInsets.only(right: 10.w, ),
                  decoration: BoxDecoration(
                    color:
                        selected.value == searchTab[i]
                            ? context.colorScheme.primary
                            : context.colorScheme.onTertiaryFixed.withValues(
                              alpha: .2,
                            ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: Text(
                      searchTab[i],
                      style: context.body14.copyWith(
                        color:
                            selected.value == searchTab[i]
                                ? context.colorScheme.surface
                                : null,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class SelectedTabBody extends HookConsumerWidget {
  final String tab;
  final ScrollController scrollController;
  const SelectedTabBody({
    super.key,
    required this.tab,
    required this.scrollController,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (tab) {
      "Top" => _buildTopSection(context, scrollController),
      "People" => SearchProfiles(),
      "Posts" => SearchPosts(),
      "Podcasts" => SliverToBoxAdapter(child: Container()),
      _ => SliverToBoxAdapter(child: Container()),
    };
  }

  Widget _buildTopSection(
    BuildContext context,
    ScrollController scrollController,
  ) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: context.height * 0.8,
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Text('Profile', style: context.body16Bold),
              ),
            ),
            10.sHs,
            SearchProfiles(limit: 4),
            10.sHs,
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Text('Posts', style: context.body16Bold),
              ),
            ),
            10.sHs,
            SearchPosts(),
          ],
        ),
      ),
    );
  }
}

class SearchProfiles extends HookConsumerWidget {
  final int? limit;
  const SearchProfiles({super.key, this.limit});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverList.builder(
      itemCount: limit ?? 10,
      itemBuilder: (context, index) {
        return ProfileTile();
      },
    );
  }
}

class ProfileTile extends StatelessWidget {
  const ProfileTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 70.h,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(
          bottom: BorderSide(color: context.colorScheme.onTertiary, width: 0.5),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundImage: AssetImage(ImageAssets.userImage),
          ),
          10.sW,
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Culture Couture 🌻', style: context.body16),
              // 3.sH,
              Text(
                'realculturecoture',
                style: context.body14.copyWith(
                  color: context.colorScheme.primary,
                ),
              ),
            ],
          ),
          Spacer(),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide.none,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              backgroundColor: context.colorScheme.primary.withValues(
                alpha: .1,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            onPressed: () {},
            child: Text(
              'Connect',
              style: context.body14Light.copyWith(
                color: context.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchGridPosts extends StatelessWidget {
  const SearchGridPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 150, // set height for horizontal list
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(10, (index) {
              final post =
                  index.isEven ? ImageAssets.post2mage : ImageAssets.post3mage;
              return SearchPostTile(post: post, width: 150.w, height: 150.h);
            }),
          ),
        ),
      ),
    );
  }
}

class SearchPosts extends StatelessWidget {
  const SearchPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      sliver: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 3.w,
          mainAxisSpacing: 2.h,
          childAspectRatio: 3.2 / 5,
        ),
        itemBuilder: (c, i) {
          final post = i.isEven ? ImageAssets.post3mage : ImageAssets.post4mage;
          return SearchPostTile(post: post);
        },
      ),
    );
  }
}

class SearchPostTile extends HookConsumerWidget {
  final double? height;
  final double? width;
  final String post;
  const SearchPostTile({
    super.key,
    required this.post,
    this.height,
    this.width,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        image: DecorationImage(fit: BoxFit.cover, image: AssetImage(post)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 12.r,
                  backgroundImage: AssetImage(ImageAssets.userImage),
                ),
                5.sW,
                Expanded(
                  child: Text(
                    'Culture Couture 🌻',
                    style: context.body12.copyWith(
                      color: context.colorScheme.surface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
