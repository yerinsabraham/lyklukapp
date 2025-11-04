import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/modules/creator_ads/presentation/utils/creator_ads_constants.dart';
import 'package:lykluk/modules/creator_ads/domain/usecases/creator_ads_actions.dart';
import 'package:lykluk/modules/creator_ads/presentation/widgets/analytics_card.dart';
import 'package:lykluk/modules/creator_ads/presentation/widgets/selectable_item_widget.dart';
import 'package:lykluk/modules/creator_ads/presentation/widgets/latest_post_widget.dart';
import 'package:lykluk/modules/creator_ads/presentation/widgets/section_container.dart';
import 'package:lykluk/modules/creator_ads/presentation/widgets/section_header.dart';
import 'package:lykluk/utils/constant/image_path.dart';
import 'package:lykluk/utils/router/app_router.dart';
import 'package:lykluk/utils/theme/theme.dart';

/// LykLuk Studio Screen for creator analytics and tools
class LykLukStudioScreen extends StatelessWidget {
  const LykLukStudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppColors.buttonColor),
      appBar: _buildAppBar(context),
      body: SafeArea(
        bottom: false,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 0.w),
          child: Column(
            children: [
              SizedBox(height: 12.h),

              // Analytics section
              _buildAnalyticsSection(context),
              SizedBox(height: 12.h),

              // Insights section
              _buildInsightsSection(context),
              SizedBox(height: 12.h),

              // Your tools section
              _buildToolsSection(context),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(AppColors.white).withValues(alpha: 0.80),
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 70.h,
      flexibleSpace: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          top: 60.h,
          left: 14.w,
          right: 14.w,
          bottom: 15.h,
        ),
        decoration: BoxDecoration(color: const Color(AppColors.white).withValues(alpha: 0.80)),
        child: Row(
          children: [
            // Studio icon
            Container(
              width: 50.w,
              height: 50.h,
              decoration: ShapeDecoration(
                color: const Color(AppColors.backgroundColor2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: InkWell(
                onTap: () {
                  AppRouter.router.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 20.sp,
                  color: const Color(AppColors.backArrowBlueColor),
                ),
              ),
            ),
            SizedBox(width: 20.w),

            // Title
            Expanded(
              child: AppText(
                text: CreatorAdsConstants.lykLukStudio,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: const Color(AppColors.textColor3),
                fontFamily: 'Figtree',
                height: 1.42,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsSection(BuildContext context) {
    return SectionContainer(
      // height: 200.h,
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Section header
          SectionHeader(
            title: CreatorAdsConstants.analytics,
            actionText: CreatorAdsConstants.dateRange,
            onActionTap: () => CreatorAdsActions.onAnalyticsTap(context),
          ),
          SizedBox(height: 10.h),

          // Straight line divider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: _buildStraightLine(context),
          ),
          SizedBox(height: 10.h),

          // Analytics cards row
          SizedBox(
            width: double.infinity,
            child: Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Views
                AnalyticsCard(
                  title: CreatorAdsConstants.views,
                  value: CreatorAdsConstants.viewsCount,
                  growthPercentage: CreatorAdsConstants.growthPositive,
                  timePeriod: CreatorAdsConstants.timePeriod,
                  growthColor: const Color(AppColors.successColor),
                  onTap: () => CreatorAdsActions.onViewsTap(context),
                ),
                SizedBox(width: 33.w),

                // Interactions
                AnalyticsCard(
                  title: CreatorAdsConstants.interactions,
                  value: CreatorAdsConstants.interactionsCount,
                  growthPercentage: CreatorAdsConstants.growthMedium,
                  timePeriod: CreatorAdsConstants.timePeriod,
                  growthColor: const Color(AppColors.successColor),
                  onTap: () => CreatorAdsActions.onInteractionsTap(context),
                ),
                SizedBox(width: 33.w),

                // Likes
                AnalyticsCard(
                  title: CreatorAdsConstants.likes,
                  value: CreatorAdsConstants.likesCount,
                  growthPercentage: CreatorAdsConstants.growthNegative,
                  timePeriod: CreatorAdsConstants.timePeriod,
                  growthColor: const Color(AppColors.errorColor),
                  onTap: () => CreatorAdsActions.onLikesTap(context),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.h),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: _buildStraightLine(context),
          ),
          SizedBox(height: 12.h),

          // Latest post
          LatestPostWidget(
            title: CreatorAdsConstants.yourLatestPost,
            views: CreatorAdsConstants.postViews,
            likes: CreatorAdsConstants.postLikes,
            onTap: () => CreatorAdsActions.onLatestPostTap(context),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightsSection(BuildContext context) {
    return SectionContainer(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          SectionHeader(title: CreatorAdsConstants.insights),
          SizedBox(height: 10.h),
          _buildStraightLine(context),
          SizedBox(height: 12.h),

          // Insights items
          Column(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableItemWidget.insights(
                label: CreatorAdsConstants.totalMutualsTitle,
                value: CreatorAdsConstants.twentyFiveM,
                onTap: () => CreatorAdsActions.onTotalMutualsTap(context),
              ),
              SizedBox(height: 10.h),
              _buildStraightLine(context),
              SizedBox(height: 10.h),

              SelectableItemWidget.insights(
                label: CreatorAdsConstants.requestsLabel,
                value: CreatorAdsConstants.twentyFiveM,
                onTap: () => CreatorAdsActions.onRequestsTap(context),
              ),
              SizedBox(height: 10.h),
              _buildStraightLine(context),
              SizedBox(height: 10.h),

              SelectableItemWidget.insights(
                label: CreatorAdsConstants.totalPostsLabel,
                value: CreatorAdsConstants.twentyFiveM,
                onTap: () => CreatorAdsActions.onTotalPostsTap(context),
              ),
              SizedBox(height: 10.h),
              _buildStraightLine(context),
              SizedBox(height: 10.h),

              SelectableItemWidget.insights(
                label: CreatorAdsConstants.totalShares,
                value: CreatorAdsConstants.twentyFiveM,
                onTap: () => CreatorAdsActions.onTotalSharesTap(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToolsSection(BuildContext context) {
    return SectionContainer(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          SectionHeader(title: CreatorAdsConstants.yourTools),
          SizedBox(height: 10.h),
          _buildStraightLine(context),
          SizedBox(height: 12.h),

          // Tools items
          Column(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableItemWidget.tools(
                title: CreatorAdsConstants.inspiration,
                svgIconPath: ImagePath.inspirationIcon,
                onTap: () => CreatorAdsActions.onInspirationTap(context),
              ),
              SizedBox(height: 10.h),
              _buildStraightLine(context),
              SizedBox(height: 10.h),

              SelectableItemWidget.tools(
                title: CreatorAdsConstants.adTools,
                svgIconPath: ImagePath.adToolsIcon,
                // onTap: () => CreatorAdsActions.onAdToolsTap(context),
              ),
              SizedBox(height: 10.h),
              _buildStraightLine(context),
              SizedBox(height: 10.h),

              SelectableItemWidget.tools(
                title: CreatorAdsConstants.wallet,
                svgIconPath: ImagePath.walletIcon,
                onTap: () => CreatorAdsActions.onWalletTap(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStraightLine(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 0.5.h,
      color: const Color(AppColors.dividerColor).withValues(alpha: 0.3),
    );
  }
}
