import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:story_weaver/system/style/media_query/media_query.dart';

class AppVm {
  factory AppVm() => instance;

  AppVm._();

  /// Singleton factory
  static final AppVm instance = AppVm._();

  late BuildContext rootBuildContext;
  late BuildContext mediaQueryContext;
  late GlobalKey<NavigatorState> navigatorKey;

  /// This will be added when app launched from deep link / push notification
  Function()? appPendingAction;

  Future<void> init(BuildContext context, GlobalKey<NavigatorState> key) async {
    mediaQueryContext = context;
    navigatorKey = key;

    AppQuery.instance.init(context);
  }
}
