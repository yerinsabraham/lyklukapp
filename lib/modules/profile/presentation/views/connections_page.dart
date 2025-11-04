// ignore_for_file: unused_result

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/profile/presentation/view_model/providers/followers_provider.dart';
import 'package:lykluk/modules/profile/presentation/view_model/providers/following_provider.dart';
import 'package:lykluk/modules/profile/presentation/view_model/providers/requests_provider.dart';
import 'package:lykluk/modules/profile/presentation/views/widgets/sort_filter_options_sheet.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import '../../../../core/shared/widgets/shared_widget.dart';
import 'widgets/following_list.dart';
import 'widgets/followers_list.dart';
import 'widgets/requests_list.dart';

class ConnectionsPage extends HookConsumerWidget {
  final String userId;
  const ConnectionsPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = useState(0);
    final tabController = useTabController(initialLength: 3);
    final searchController = useTextEditingController();
    final searchValue = useState("");
    final sortValue = useState('Default');

    useEffect(() {
      tabController.addListener(() {
        if (!tabController.indexIsChanging) {
          selectedTab.value = tabController.index;
          searchController.clear();
          searchValue.value = "";
          if (tabController.index == 0) {
            ref.refresh(
              followersProvider((
                userId: userId,
                search: '',
                sortBy: 'Default',
              )),
            );
          } else if (tabController.index == 1) {
            ref.refresh(
              followingProvider((
                userId: userId,
                search: '',
                sortBy: 'Default',
              )),
            );
          } else if (tabController.index == 2) {
            ref.refresh(requestsProvider((search: '', sortBy: 'Default')));
          }
        }
      });
      return null;
    }, [tabController]);

    useEffect(() {
      Timer? debounce;
      searchController.addListener(() {
        if (debounce?.isActive ?? false) debounce!.cancel();

        debounce = Timer(const Duration(milliseconds: 500), () {
          searchValue.value = searchController.text;
        });
      });

      return () => debounce?.cancel();
    }, [searchController]);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            scrolledUnderElevation: 0,
            floating: true,
            snap: true,
            toolbarHeight: 170.h,
            title: Row(
              children: [
                ExitButton(
                  child: Icon(
                    Icons.keyboard_backspace,
                    color: context.colorScheme.primary,
                  ),
                ),
                20.sW,
                Text('Connections', style: context.title24Bold),
              ],
            ),
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: GestureDetector(
                  child: SvgPicture.asset(IconAssets.optionDashIcon),
                  onTap: () async {
                    final selectedSort = await showModalBottomSheet<String>(
                      context: context,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20.r),
                        ),
                      ),
                      builder:
                          (context) => SortFilterOptionsSheet(
                            selectedOption: sortValue.value,
                          ),
                    );

                    // When user selects a sort option
                    if (selectedSort != null) {
                      sortValue.value =
                          selectedSort; // update current selection

                      // Only refresh followers list tab (index 0)
                      if (selectedTab.value == 0) {
                        ref.refresh(
                          followersProvider((
                            userId: userId,
                            search: searchValue.value,
                            sortBy: sortValue.value,
                          )),
                        );
                      } else if (selectedTab.value == 1) {
                        ref.refresh(
                          followingProvider((
                            userId: userId,
                            search: searchValue.value,
                            sortBy: sortValue.value,
                          )),
                        );
                      } else if (selectedTab.value == 2) {
                        ref.refresh(
                          requestsProvider((
                            search: searchValue.value,
                            sortBy: sortValue.value,
                          )),
                        );
                      }
                    }
                  },
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(30.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTab(
                      initialTabIndex: selectedTab.value,
                      childPadding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                      tabs: ['Followers', 'Following', 'Requests'],
                      onSelect: (v) {},
                      onIndexChanged: (v) {
                        selectedTab.value = v;
                      },
                    ),
                    CustomField(
                      controller: searchController,
                      borderRadius: 10.r,
                      borderColor: Colors.transparent,
                      fillColor: context.colorScheme.onSecondary.withValues(
                        alpha: 0.07,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 15.h,
                      ),
                      preffixWidget: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(IconAssets.searchIcon),
                      ),
                      hintText: 'Search',
                      hintTextStyle: context.body16Light.copyWith(
                        color: context.colorScheme.onSecondary,
                      ),
                    ),
                    10.sH,
                  ],
                ),
              ),
            ),
          ),

          // 10.sHs,
          switch (selectedTab.value) {
            0 => FollowersList(userId: userId, search: searchValue.value),
            1 => FollowingList(userId: userId, search: searchValue.value),
            2 => RequestsList(userId: userId, search: searchValue.value),
            _ => FollowersList(userId: userId, search: searchValue.value),
          },
        ],
      ),
    );
  }
}
