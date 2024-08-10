import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:story_weaver/system/global_extension.dart';
import '../routes/auth_guard.dart';
import '../routes/routes_map.dart';
import '../variables/durations.dart';

// dependencies :
// auto_route: ^3.2.2
// auto_route_generator: ^3.2.1

// dev_dependencies :
// build_runner: ^2.0.6

class AppNavigator {
  /// This class hold all the navigation option that used in the app
  factory AppNavigator() => instance;

  AppNavigator._();

  ///Singleton factory
  static final AppNavigator instance = AppNavigator._();
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  final AppRouter appRoutesMap = AppRouter(
    navigatorKey: navigatorKey,
    authGuard: AuthGuard(),
  );

  static Widget defaultTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const Offset begin = Offset(1.0, 0);
    const Offset end = Offset.zero;
    const Cubic curve = Curves.ease;

    final Animatable<Offset> tween =
        Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }

  /// Use this for liveness only
  Future<dynamic> rootNavigatorPush(Widget screen) async {
    return await Navigator.push(
      currentContext!,
      PageRouteBuilder<dynamic>(
        pageBuilder: (_, __, ___) => screen,
        transitionDuration: kDuration250,
      ),
    );
  }

  // final AppAnalytics _analyticsService = AppAnalytics.instance;

  List<AutoRoutePage<dynamic>> get routeStack => appRoutesMap.stack;

  BuildContext? get currentContext => navigatorKey.currentContext;

  bool get isEmptyStack =>
      appRoutesMap.stack.isNullOrEmpty || appRoutesMap.stack.length.isEqual(1);

  bool get canGoBack =>
      appRoutesMap.stack.isNotNullOrEmpty &&
      appRoutesMap.stack.length.isMoreThan(1);

  Future<dynamic> push(PageRouteInfo route,
      {OnNavigationFailure? onFailure}) async {
    // _analyticsService.trackPageVisit(
    //   screenClass: route.fullPath,
    //   screenName: route.routeName,
    // );
    return await appRoutesMap.push(route);
  }

  Future<dynamic> replace(PageRouteInfo route,
      {OnNavigationFailure? onFailure}) async {
    // _analyticsService.trackPageVisit(
    //   screenClass: route.fullPath,
    //   screenName: route.routeName,
    // );
    return await appRoutesMap.replace(route);
  }

  Future<void> pop([dynamic result]) async {
    if (appRoutesMap.stack.length.isMoreThan(1)) {
      // final AutoRoutePage poppedRoute = appRoutesMap.stack.last;

      // _analyticsService.trackPageExit(
      //   screenClass: poppedRoute.routeData.path,
      //   screenName: poppedRoute.routeData.name,
      // );

      appRoutesMap.popForced(result);
    }
  }

  Future<void> popUntilRouteWithName(String routeName) async {
    if (appRoutesMap.stack.length.isMoreThan(1)) {
      // final AutoRoutePage poppedRoute = appRoutesMap.stack.last;

      // _analyticsService.trackPageExit(
      //   screenClass: poppedRoute.routeData.path,
      //   screenName: poppedRoute.routeData.name,
      // );

      appRoutesMap.popUntilRouteWithName(routeName);
    }
  }

  Future<void> popUntilRoot([dynamic result]) async {
    if (appRoutesMap.stack.length.isMoreThan(1)) {
      // final AutoRoutePage poppedRoute = appRoutesMap.stack.last;

      // _analyticsService.trackPageExit(
      //   screenClass: poppedRoute.routeData.path,
      //   screenName: poppedRoute.routeData.name,
      // );

      appRoutesMap.popUntilRoot();
    }
  }

  Future<dynamic> popAndPush(PageRouteInfo route,
      {OnNavigationFailure? onFailure}) async {
    // _analyticsService.trackPageVisit(
    //   screenClass: route.fullPath,
    //   screenName: route.routeName,
    // );
    return await appRoutesMap.popAndPush(route);
  }

  Future<void> clearAndPush(PageRouteInfo route) async {
    // _analyticsService.trackPageVisit(
    //   screenClass: route.fullPath,
    //   screenName: route.routeName,
    // );
    replaceAll(<PageRouteInfo>[route]);
  }

  Future<void> replaceAll(
    List<PageRouteInfo> routes, {
    OnNavigationFailure? onFailure,
  }) async {
    appRoutesMap.replaceAll(routes);
  }
}
