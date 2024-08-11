import 'dart:async';
import 'dart:convert';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:story_weaver/data/model/internal/app_configuration_model.dart';
import 'package:story_weaver/system/global_extension.dart';
import 'package:story_weaver/system/global_variable.dart';
import 'package:story_weaver/system/style/media_query/media_query.dart';

import '../system/config/app_info.dart';
import '../system/service/bug_tracker.dart';
import '../system/service/local_logger.dart';
import '../system/service/local_storage.dart';

class AppVm {
  factory AppVm() => instance;

  AppVm._();

  /// Singleton factory
  static final AppVm instance = AppVm._();

  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  final AppLocalLogger logger = AppLocalLogger('App Vm');

  late BuildContext rootBuildContext;
  late BuildContext mediaQueryContext;
  late GlobalKey<NavigatorState> navigatorKey;

  /// This will be added when app launched from deep link / push notification
  Function()? appPendingAction;

  Future<void> init(BuildContext context, GlobalKey<NavigatorState> key) async {
    mediaQueryContext = context;
    navigatorKey = key;

    AppQuery.instance.init(context);

    _initFirebaseRemoteConfig();
  }

  Future<void> _initFirebaseRemoteConfig({bool force = false}) async {
    final int lastAppVersionNumber =
        AppLocalStorage.instance.appLastVersionNumber;
    final int currentAppVersionNumber = AppInfo.instance.appBuildNumber.toInt;
    final bool isAppUpdated =
        lastAppVersionNumber.isLessThan(currentAppVersionNumber);

    final bool forceUpdateConfig =
        AppLocalStorage.instance.isFirstLaunch || isAppUpdated;

    try {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: kDuration15s,
          minimumFetchInterval: forceUpdateConfig || force
              ? Duration.zero
              : kDebugMode
                  ? kDuration1h
                  : kDuration12h,
        ),
      );

      if (forceUpdateConfig) {
        await _remoteConfig.fetchAndActivate();
        await _remoteConfig.ensureInitialized();
      } else {
        _remoteConfig.fetchAndActivate();
      }

      logger.printDebug(
        '_initFirebaseRemoteConfig fetchAndActivate : '
        '${_remoteConfig.getAll()}',
      );

      /// Save dynamic app configuration
      final RemoteConfigValue appConfigData =
          _remoteConfig.getValue('appConfiguration');
      final AppConfigurationModel appConfig = AppConfigurationModel.fromJson(
        jsonDecode(appConfigData.asString()),
      );

      AppLocalStorage.instance.setEnableApp(appConfig.isAppEnabled);
    } on PlatformException catch (exception) {
      AppBugTracker.instance.captureException(
        exception: exception,
        message: '_initFirebaseRemoteConfig error',
      );
    } catch (exception) {
      AppBugTracker.instance.captureException(
        message: '_initFirebaseRemoteConfig error due to $exception \n'
            'Unable to fetch remote config. '
            'Cached or default values will be used.',
      );
    }

    AppLocalStorage.instance.setLastAppVersionNumber(currentAppVersionNumber);
  }
}
