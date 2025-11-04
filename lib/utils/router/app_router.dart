import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lykluk/core/services/logger_service.dart';
import 'package:lykluk/core/services/app_analytics.dart';
import 'package:lykluk/modules/auth/presentation/views/components/app_wrapper.dart';
import 'package:lykluk/modules/auth/presentation/views/components/interest_page.dart';
import 'package:lykluk/modules/auth/presentation/views/create_password.dart';
import 'package:lykluk/modules/auth/presentation/views/date_of_birth.dart';
import 'package:lykluk/modules/auth/presentation/views/onboarding.dart';
import 'package:lykluk/modules/auth/presentation/views/otp_page.dart';
import 'package:lykluk/modules/auth/presentation/views/splash.dart';
import 'package:lykluk/modules/auth/presentation/views/widget/forgot_password.dart';
import 'package:lykluk/modules/chats/presentation/chat_page.dart';
import 'package:lykluk/modules/chats/presentation/search_chats_page.dart';
import 'package:lykluk/modules/ecommerce/model/address_model.dart';
import 'package:lykluk/modules/ecommerce/presentation/views/store/store_subscription.dart';
import 'package:lykluk/modules/home/presentation/nav_bar.dart';
import 'package:lykluk/modules/ecommerce/presentation/views/ecommerce.dart';
import 'package:lykluk/modules/ecommerce/presentation/views/market/live_market_page.dart';
import 'package:lykluk/modules/notifications/presentation/views/notifications_page.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/notifications.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/create_post_page.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/preview_screen.dart';
import 'package:lykluk/modules/profile/presentation/views/edit_page_profile.dart';
import 'package:lykluk/modules/profile/presentation/views/settings_privacy.dart';
import 'package:lykluk/modules/profile/presentation/views/widgets/bio_edit.dart';
import 'package:lykluk/modules/profile/presentation/views/widgets/name_edit.dart';
import 'package:lykluk/modules/profile/presentation/views/widgets/username_edit.dart';
import 'package:lykluk/modules/wallet/presentation/components/wallet_page.dart';
// import 'package:lykluk/modules/profile/profile.dart';
// import 'package:lykluk/modules/creator_ads/creator_ads.dart';
import 'package:lykluk/utils/router/transition_animations.dart';

import '../../modules/ecommerce/presentation/views/cart/cart_page.dart';
import '../../modules/posts/data/model/post_model.dart';
import '../../modules/posts/presentation/views/post_feed/views/post_view.dart';
import '../../modules/posts/presentation/views/create_post/components/post_flow_page.dart';
import '../../modules/profile/presentation/views/connections_page.dart';
import '../../modules/profile/presentation/views/profile_settings.dart';
import '../../modules/profile/presentation/views/users_profile_page.dart';

class Routes {
  /// onboarding routes
  static const splashRoute = 'splash';
  static const onboardingRoute = 'onboarding-route';
  static const authWrapperRoute = 'auth-wrapper-page';
  static const chooseInterestRoute = 'choose-interest-route';

  /// profile routes
  static const profileRoute = 'profile';
  static const profileSettingsRoute = 'profile-settings-route';
  static const editProfileRoute = 'edit-profile';
  static const editFieldRoute = 'edit-field';
  static const publicProfileRoute = 'public-profile';
  static const blockedProfileRoute = 'blocked-profile';
  static const connectionsRoute = 'connections-route';
  // static const connectionsPafe = 'connections-page';
  static const followersRoute = 'followers-connection';
  static const followingRoute = 'following-connection';
  static const requestsRoute = 'connection-requests';
  static const otpPageRoute = 'otp-page-route';
  static const dateOfBirthRoute = 'date-of-birth';
  static const createPasswordRoute = 'create-password-route';
  static const forgotPasswordRoute = 'forgot-password-route';
  static const resetPasswordRoute = 'reset-password-route';
  static const settingsPrivacyRoute = 'settings-privacy-screen';
  static const walletScreenRoute = 'wallet-screen-route';
  //
  static const otherUserProfileRoute = 'other-user-profile-route';
  static const nameEditProfileRoute = 'name-edit-profile-route';
  static const usernameEditProfileRoute = 'username-edit-profile-route';
  static const bioEditProfileRoute = 'bio-edit-profile-route';

  ///chat routes
  static const searchChatsRoute = 'search-chats-route';
  static const chatMessagePageRoute = 'chat-message-route';

  /// home
  static const navBarRoute = 'nav-bar-route';

  /// notification routes
  static const notificationsRoute = 'notifications';
  static const notificationPageRoute = 'notifications-page';
  static const notificationsAllRoute = 'notifications-all';
  static const notificationsRequestsRoute = 'notifications-requests';
  static const notificationsSuggestionsRoute = 'notifications-suggestions';
  static const notificationsMentionsRoute = 'notifications-mentions';
  static const notificationsCommentsRoute = 'notifications-comments';
  static const notificationsCommunityRoute = 'notifications-community';
  static const notificationsPodcastsRoute = 'notifications-podcasts';
  //

  /// post/videos routes
  static const previewRoute = 'post-preview';
  static const postRecordRoute = "post-record";
  static const createPostRoute = "post-create";
  static const postViewRoute = "post-view";

  /// creator/ads routes
  static const lyklukStudioRoute = 'lykluk-studio';

  ///market routes
  static const marketChoiceRoute = 'market-choice-route';
  static const marketGenderRoute = "market-gender-route";
  static const marketPageRoute = 'market-page-route';
  static const marketIntroRoute = 'market-intro-route';
  static const productDetailsRoute = 'product-details-route';
  static const liveProductDetailsRoute = 'live-product-details-route';
  static const ordersRoute = 'orders-route';
  static const orderCheckoutRoute = 'order-checkout-route';
  static const buyerOrderViewRoute = 'buyer-order_view-route';
  static const shopProfileRoute = 'shop-profile-route';
  // static const getShopStartRoute = 'get-shop-start-route';
  static const createStoreRoute = 'create-shop-route';
  static const createProductRoute = 'create-product-item-route';
  static const setupStoreLogisticsRoute = 'setup-shop-logistics-route';
  static const sellerOrderviewRoute = 'seller-order-view-route';
  static const verifyStoreRoute = 'verify-store-route';
  static const storeRoute = 'store-route';
  static const storeEditRoute ='store-edit-route';



  ///cart
  static const cartRoute = 'cart-route';
  static const cartCheckoutRoute = 'cart-checkout-route';
  static const selectAddressRoute = 'select-address-route';
  static const addAddressRoute = 'add-address-route';
  

  /// profile
  // static const connectionsRoute = 'connections-route';

  /// subscriptions
  static const premiumRoute = 'premium-route';
  static const storeSubscriptionRoute = 'store-subscriptions-route';

  
}

class AppRouter {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  static final GlobalKey<NavigatorState> parentNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  static Page<void> getPage({
    required BuildContext context,
    required Widget child,
    required GoRouterState state,
    bool? canPop,
    TransitionType transitionType = TransitionType.none,
  }) {
    return switch (transitionType) {
      TransitionType.none => MaterialPage<void>(
        child: child,
        key: state.pageKey,
        name: state.name,
        canPop: canPop ?? true,
        arguments: state.extra,
      ),
      TransitionType.fade => buildFadeTransitionPage(
        state: state,
        child: child,
      ),
    };
  }

  static Page<void> getNativePage({
    required BuildContext context,
    required Widget child,
    required GoRouterState state,
  }) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return CupertinoPage<void>(
        child: child,
        key: state.pageKey,
        name: state.name,
      );
    } else {
      return MaterialPage<void>(
        child: child,
        key: state.pageKey,
        name: state.name,
      );
    }
  }

  static Page<void> buildPageWithDefaultTransition({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
    Duration? transitionDuration,
    Duration? reverseDuration,
  }) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return CustomTransitionPage(
        child: child,
        key: state.pageKey,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return CupertinoPageRoute(
            builder: (context) => child,
          ).buildTransitions(context, animation, secondaryAnimation, child);
        },
        transitionDuration:
            transitionDuration ?? const Duration(milliseconds: 300),
        reverseTransitionDuration:
            reverseDuration ?? const Duration(milliseconds: 300),
      );
    } else {
      return CustomTransitionPage(
        child: child,
        key: state.pageKey,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return MaterialPageRoute(
            builder: (context) => child,
          ).buildTransitions(context, animation, secondaryAnimation, child);
        },
        transitionDuration:
            transitionDuration ?? const Duration(milliseconds: 300),
        reverseTransitionDuration:
            reverseDuration ?? const Duration(milliseconds: 300),
      );
    }
  }

  /// get native page with default transition
  static getPlatformPage({
    required Widget child,
    required BuildContext context,
  }) {
    if (Platform.isAndroid) {
      return MaterialPageRoute(builder: (context) => child);
    } else {
      return CupertinoPageRoute(builder: (context) => child);
    }
  }

  static Future<void> screenEvent(String screenClassName) async {
    log.d('Child Element: $screenClassName');
    await _analytics.logScreenView(screenName: screenClassName);
    _analytics.logEvent(
      name: screenClassName,
      parameters: {'event': screenClassName},
    );
  }

  static logPageView(String routeName, String className, String pageKey) {
    log.d(
      'Logged Screen: $routeName, className: $className, pageKey: $pageKey',
    );
    _analytics.logEvent(
      name: className,
      parameters: {'event': className, 'page_name': routeName},
    );
  }

  static final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: Routes.splashRoute.path,
    routes: routes,
    navigatorKey: parentNavigatorKey,
    observers: [
      BotToastNavigatorObserver(),
      FirebaseAnalyticsObserver(analytics: AppAnalytics.analytics),
    ],
    redirect: (context, state) async {
      final String pageName = state.uri.toString();

      final String pageKey = state.runtimeType.toString();
      final String className = state.fullPath!.path;
      // Log page transition to Firebase Analytics
      await _analytics.logScreenView(
        screenName: pageName,
        screenClass: className,
      );
      logPageView(pageName, className, pageKey);
      return null;
    },
    errorPageBuilder: (context, state) {
      return getNativePage(
        context: context,
        state: state,
        child: const SplashScreen(),
      );
    },
  );

  static String get currentRoute {
    final RouteMatch lastMatch =
        AppRouter.router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList =
        lastMatch is ImperativeRouteMatch
            ? lastMatch.matches
            : AppRouter.router.routerDelegate.currentConfiguration;
    final String location = matchList.uri.toString();
    return location;
  }

  static String get currentName {
    return currentRoute.name;
  }

  /// splash
  static final routes = <GoRoute>[
    /// Splash
    GoRoute(
      name: Routes.splashRoute,
      path: Routes.splashRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: SplashScreen(),
        );
      },
    ),

    /// auth wrapper
    GoRoute(
      name: Routes.authWrapperRoute,
      path: Routes.authWrapperRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: const AuthWrapper(),
        );
      },
    ),

    /// user type route
    GoRoute(
      name: Routes.onboardingRoute,
      path: Routes.onboardingRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: OnboardingScreen(),
        );
      },
    ),

    /// choose interest page
    GoRoute(
      name: Routes.chooseInterestRoute,
      path: Routes.chooseInterestRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: ChooseInterestScreen(),
        );
      },
    ),

    ///home
    GoRoute(
      name: Routes.navBarRoute,
      path: Routes.navBarRoute.path,
      pageBuilder: (context, state) {
        return getPage(context: context, state: state, child: NavBar());
      },
    ),
    GoRoute(
      name: Routes.otpPageRoute,
      path: Routes.otpPageRoute.path,
      pageBuilder: (context, state) {
        // final arg = SignUpRequest.fromJson(state.extra as Map<String, dynamic>);
        final arg = state.extra as bool?;
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: OtpPage( isReseting:  arg?? false,),
        );
      },
    ),
    GoRoute(
      name: Routes.createPasswordRoute,
      path: Routes.createPasswordRoute.path,
      pageBuilder: (context, state) {
        // final arg = SignUpRequest.fromJson(state.extra as Map<String, dynamic>);

        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: CreatePassword(),
        );
      },
    ),
    GoRoute(
      name: Routes.dateOfBirthRoute,
      path: Routes.dateOfBirthRoute.path,
      pageBuilder: (context, state) {
        // final arg = SignUpRequest.fromJson(state.extra as Map<String, dynamic>);
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: DateOfBirthScreen(),
        );
      },
    ),
    GoRoute(
      name: Routes.forgotPasswordRoute,
      path: Routes.forgotPasswordRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: ForgotPasswordPage(),
        );
      },
    ),

    /// chats routes
    GoRoute(
      name: Routes.searchChatsRoute,
      path: Routes.searchChatsRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: SearchChatsPage(),
        );
      },
    ),
    GoRoute(
      name: Routes.chatMessagePageRoute,
      path: Routes.chatMessagePageRoute.path,
      pageBuilder: (context, state) {
        final arg = state.extra as String;
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: ChatPage(chatId: arg),
        );
      },
    ),

    /// market
    GoRoute(
      name: Routes.marketPageRoute,
      path: Routes.marketPageRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: MarketPage(),
        );
      },
    ),
    GoRoute(
      name: Routes.productDetailsRoute,
      path: Routes.productDetailsRoute.path,
      pageBuilder: (context, state) {
        final arg = state.extra as int;
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: ProductDetails( productId: arg,),
        );
      },
    ),
    GoRoute(
      name: Routes.liveProductDetailsRoute,
      path: Routes.liveProductDetailsRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: LiveMarketPage(),
        );
      },
    ),
    GoRoute(
      name: Routes.ordersRoute,
      path: Routes.ordersRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: OrdersPage(),
        );
      },
    ),
    GoRoute(
      name: Routes.orderCheckoutRoute,
      path: Routes.orderCheckoutRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child:OrderCheckoutPage(),
        );
      },
    ),
    GoRoute(
      name: Routes.buyerOrderViewRoute,
      path: Routes.buyerOrderViewRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: BuyerOrderView(),
        );
      },
    ),
    GoRoute(
      name: Routes.setupStoreLogisticsRoute,
      path: Routes.setupStoreLogisticsRoute.path,
      pageBuilder: (context, state) {
        final storeId= state.extra as int;
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: SetupLogisticsPage(storeId: storeId,),
        );
      },
    ),
    GoRoute(
      name: Routes.createProductRoute,
      path: Routes.createProductRoute.path,
      pageBuilder: (context, state) {
       
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: CreateProductPage(),
        );
      },
    ),
    GoRoute(
      name: Routes.createStoreRoute,
      path: Routes.createStoreRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: CreateStorePage(),
        );
      },
    ),
    GoRoute(
      name: Routes.storeRoute,
      path: Routes.storeRoute.path,
      pageBuilder: (context, state) {
        final storeId = state.extra as int;
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: StorePage(storeId: storeId,),
        );
      },
    ),
    GoRoute(
      name: Routes.storeEditRoute,
      path: Routes.storeEditRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: EditStorePage(),
        );
      },
    ),
    GoRoute(
      name: Routes.premiumRoute,
      path: Routes.premiumRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          child: PremiumPage(),
        );
      },
    ),
    GoRoute(
      name: Routes.storeSubscriptionRoute,
      path: Routes.storeSubscriptionRoute.path,
      pageBuilder: (context, state) {
        final int storeId = state.extra as int;
        return getPage(
          context: context,
          state: state,
          child:StoreSubscriptionPage(storeId: storeId,),
        );
      },
    ),
    GoRoute(
      name: Routes.cartRoute,
      path: Routes.cartRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: CartPage(),
        );
      },
    ),
    GoRoute(
      name: Routes.cartCheckoutRoute,
      path: Routes.cartCheckoutRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: CartCheckoutPage(),
        );
      },
    ),
    GoRoute(
      name: Routes.selectAddressRoute,
      path: Routes.selectAddressRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: SelectAddressPage(),
        );
      },
    ),
    GoRoute(
      name: Routes.addAddressRoute,
      path: Routes.addAddressRoute.path,
      pageBuilder: (context, state) {
        final arg = state.extra as AddressModel?;
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: AddAddressPage( address:arg ,),
        );
      },
    ),
    GoRoute(
      name: Routes.verifyStoreRoute,
      path: Routes.verifyStoreRoute.path,
      pageBuilder: (context, state) {
        final storeId = state.extra as int;
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: VerifyStorePage(storeId: storeId,),
        );
      },
    ),
    GoRoute(
      name: Routes.sellerOrderviewRoute,
      path: Routes.sellerOrderviewRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: SellerOrderView(),
        );
      },
    ),

    /// proflle
    GoRoute(
      name: Routes.connectionsRoute,
      path: Routes.connectionsRoute.path,
      pageBuilder: (context, state) {
        final arg = state.extra as String;
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: ConnectionsPage( userId: arg),
        );
      },
    ),
    GoRoute(
      name: Routes.editProfileRoute,
      path: Routes.editProfileRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: EditPageProfile(),
        );
      },
    ),
    GoRoute(
      name: Routes.otherUserProfileRoute,
      path: Routes.otherUserProfileRoute.path,
      pageBuilder: (context, state) {
        final id = state.extra as String;
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: UsersProfilePage(userId: id),
        );
      },
    ),
    GoRoute(
      name: Routes.nameEditProfileRoute,
      path: Routes.nameEditProfileRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: NameEdit(),
        );
      },
    ),
    GoRoute(
      name: Routes.usernameEditProfileRoute,
      path: Routes.usernameEditProfileRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: UserNameEdit(),
        );
      },
    ),
    GoRoute(
      name: Routes.bioEditProfileRoute,
      path: Routes.bioEditProfileRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: BioEdit(),
        );
      },
    ),
    GoRoute(
      name: Routes.profileSettingsRoute,
      path: Routes.profileSettingsRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          // transitionType: TransitionType.fade,
          child: ProfileSettingsPage(),
        );
      },
    ),

    // /// Profile Routes
    // GoRoute(
    //   name: Routes.profileRoute,
    //   path: Routes.profileRoute.path,
    //   pageBuilder: (context, state) {
    //     return getPage(
    //       context: context,
    //       state: state,
    //       transitionType: TransitionType.fade,
    //       child: UserProfileScreen(),
    //     );
    //   },
    // ),

    // GoRoute(
    //   name: Routes.editProfileRoute,
    //   path: Routes.editProfileRoute.path,
    //   pageBuilder: (context, state) {
    //     final ProfileData? data = state.extra as ProfileData?;
    //     return getPage(
    //       context: context,
    //       state: state,
    //       transitionType: TransitionType.fade,
    //       child: EditProfileScreen(
    //         initialName: data?.profile?.name,
    //         initialUsername: data?.username,
    //         initialBio: data?.profile?.bio?.toString(),
    //         initialImageUrl: data?.profile?.profileImageUrl,
    //       ),
    //     );
    //   },
    // ),

    // GoRoute(
    //   name: Routes.editFieldRoute,
    //   path: '${Routes.editFieldRoute.path}/:fieldType',
    //   pageBuilder: (context, state) {
    //     final fieldType = state.pathParameters['fieldType'] ?? '';
    //     final extra = state.extra as Map<String, dynamic>?;

    //     // Create a config based on field type with proper parameters
    //     late EditFieldConfig config;
    //     switch (fieldType.toLowerCase()) {
    //       case 'name':
    //         config = EditFieldConfig.name(infoText: extra?['infoText']);
    //         break;
    //       case 'username':
    //         config = EditFieldConfig.username(
    //           currentUsername: extra?['currentUsername'],
    //           infoText: extra?['infoText'],
    //         );
    //         break;
    //       case 'bio':
    //         config = EditFieldConfig.bio(infoText: extra?['infoText']);
    //         break;
    //       default:
    //         config = EditFieldConfig.name(); // fallback
    //     }

    //     return getPage(
    //       context: context,
    //       state: state,
    //       transitionType: TransitionType.fade,
    //       child: EditFieldScreen(
    //         config: config,
    //         initialValue: extra?['initialValue'],
    //         onValueSaved: extra?['onValueSaved'],
    // //       ),
    // //     );
    // //   },
    // // ),

    // GoRoute(
    //   name: Routes.publicProfileRoute,
    //   path: '${Routes.publicProfileRoute.path}/:userId',
    //   pageBuilder: (context, state) {
    //     final userId = state.pathParameters['userId'] ?? '';
    //     final extra = state.extra as Map<String, dynamic>? ?? {};
    //     return getPage(
    //       context: context,
    //       state: state,
    //       transitionType: TransitionType.fade,
    //       child: PublicUserProfileScreen(
    //         userId: userId,
    //         name: extra['name'] ?? 'Unknown User',
    //         username: extra['username'] ?? '@unknown',
    //         bio: extra['bio'] ?? '',
    //         connections: extra['connections'] ?? 0,
    //         impact: extra['impact'] ?? 0,
    //         profileImageUrl: extra['profileImageUrl'],
    //         isConnected: extra['isConnected'] ?? false,
    //         isRequested: extra['isRequested'] ?? false,
    //       ),
    //     );
    //   },
    // ),

    // GoRoute(
    //   name: Routes.blockedProfileRoute,
    //   path: '${Routes.blockedProfileRoute.path}/:userId',
    //   pageBuilder: (context, state) {
    //     final userId = state.pathParameters['userId'] ?? '';
    //     final extra = state.extra as Map<String, dynamic>? ?? {};
    //     return getPage(
    //       context: context,
    //       state: state,
    //       transitionType: TransitionType.fade,
    //       child: BlockedProfileScreen(
    //         userId: userId,
    //         name: extra['name'] ?? 'Blocked User',
    //         username: extra['username'] ?? '@blocked',
    //         profileImageUrl: extra['profileImageUrl'],
    //       ),
    //     );
    //   },
    // ),

    // GoRoute(
    //   name: Routes.connectionsRoute,
    //   path: Routes.connectionsRoute.path,
    //   pageBuilder: (context, state) {
    //     return getPage(
    //       context: context,
    //       state: state,
    //       transitionType: TransitionType.fade,
    //       child: ConnectionsScreen(),
    //     );
    //   },
    // ),

    // // For now, use ConnectionsScreen for followers, following, and requests
    // GoRoute(
    //   name: Routes.followersRoute,
    //   path: Routes.followersRoute.path,
    //   pageBuilder: (context, state) {
    //     return getPage(
    //       context: context,
    //       state: state,
    //       transitionType: TransitionType.fade,
    //       child: ConnectionsScreen(),
    //     );
    //   },
    // ),

    // GoRoute(
    //   name: Routes.followingRoute,
    //   path: Routes.followingRoute.path,
    //   pageBuilder: (context, state) {
    //     return getPage(
    //       context: context,
    //       state: state,
    //       transitionType: TransitionType.fade,
    //       child: ConnectionsScreen(),
    //     );
    //   },
    // ),
    GoRoute(
      name: Routes.walletScreenRoute,
      path: Routes.walletScreenRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: WalletPage(),
        );
      },
    ),
    GoRoute(
      name: Routes.settingsPrivacyRoute,
      path: Routes.settingsPrivacyRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: const SettingsPrivacyPage(),
        );
      },
    ),

    /// Notifications navigation
    GoRoute(
      name: Routes.notificationsRoute,
      path: Routes.notificationsRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: const NotificationsScreen(),
        );
      },
    ),

    /// specific notification
    GoRoute(
      name: Routes.notificationPageRoute,
      path: Routes.notificationPageRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: const NotificationsPage(),
        );
      },
    ),

    // Specific notification filter routes for deep linking
    GoRoute(
      name: Routes.notificationsAllRoute,
      path: Routes.notificationsAllRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: const NotificationsScreen(initialFilter: 'All'),
        );
      },
    ),

    GoRoute(
      name: Routes.notificationsRequestsRoute,
      path: Routes.notificationsRequestsRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: const NotificationsScreen(initialFilter: 'Requests'),
        );
      },
    ),

    GoRoute(
      name: Routes.notificationsSuggestionsRoute,
      path: Routes.notificationsSuggestionsRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: const NotificationsScreen(initialFilter: 'Suggestions'),
        );
      },
    ),

    GoRoute(
      name: Routes.notificationsMentionsRoute,
      path: Routes.notificationsMentionsRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: const NotificationsScreen(initialFilter: 'Mentions'),
        );
      },
    ),

    GoRoute(
      name: Routes.notificationsCommentsRoute,
      path: Routes.notificationsCommentsRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: const NotificationsScreen(initialFilter: 'Comments'),
        );
      },
    ),

    GoRoute(
      name: Routes.notificationsCommunityRoute,
      path: Routes.notificationsCommunityRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: const NotificationsScreen(initialFilter: 'Community'),
        );
      },
    ),

    GoRoute(
      name: Routes.notificationsPodcastsRoute,
      path: Routes.notificationsPodcastsRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: const NotificationsScreen(initialFilter: 'Podcasts'),
        );
      },
    ),

    //   post routes
    GoRoute(
      name: Routes.previewRoute,
      path: Routes.previewRoute.path,
      pageBuilder: (context, state) {
        // final extra = state.extra;

        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: PreviewScreen(),
        );
      },
    ),
    GoRoute(
      name: Routes.postRecordRoute,
      path: Routes.postRecordRoute.path,
      pageBuilder: (context, state) {
        // final extra = state.extra;

        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: PostFlowPage(),
        );
      },
    ),
    GoRoute(
      name: Routes.createPostRoute,
      path: Routes.createPostRoute.path,
      pageBuilder: (context, state) {
        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: CreatePostPage(),
        );
      },
    ),
    GoRoute(
      name: Routes.postViewRoute,
      path: Routes.postViewRoute.path,
      pageBuilder: (context, state) {
        final extra = state.extra as PostModel;

        return getPage(
          context: context,
          state: state,
          transitionType: TransitionType.fade,
          child: PostView(reel: extra),
        );
      },
    ),

    /// proflle
    // GoRoute(
    //   name: Routes.connectionsPafe,
    //   path: Routes.connectionsPafe.path,
    //   pageBuilder: (context, state) {
    //     return getPage(
    //       context: context,
    //       state: state,
    //       transitionType: TransitionType.fade,
    //       child: ConnectionsPage(),
    //     );
    //   },
    // ),
  ];
}

extension PathString on String {
  String get path => startsWith('/') ? this : '/$this';
  String get name => split('/').last;
}

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    transitionDuration: const Duration(milliseconds: 300),
    key: state.pageKey,
    child: child,
    transitionsBuilder:
        (context, animation, secondaryAnimation, child) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          key: state.pageKey,
          child: child,
        ),
  );
}
