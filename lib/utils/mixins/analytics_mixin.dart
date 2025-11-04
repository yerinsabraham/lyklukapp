// import 'package:flutter/widgets.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../services/analytics_service.dart';


// mixin AnalyticsMixin<T extends StatefulWidget> on State<T> {
//   AnalyticsService get analyticsService =>
//       ProviderScope.containerOf(context, listen: false)
//           .read(analyticsServiceProvider);

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _trackScreenView();
//   }

  
//   void _trackScreenView() {
//     final routeName = ModalRoute.of(context)?.settings.name;
//     if (routeName != null) {
//       analyticsService.setCurrentScreen(screenName: routeName, parameters: {'screen': routeName, });
//     }
//   }
// }
