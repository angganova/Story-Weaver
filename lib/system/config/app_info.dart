import 'dart:async';
import 'package:package_info_plus/package_info_plus.dart';

// dependencies :
// package_info_plus: ^1.3.0

class AppInfo {
  /// This class hold all the app info that can be shown in the app

  factory AppInfo() => instance;

  AppInfo._();

  static final AppInfo instance = AppInfo._();

  String? appName;
  String? appPackageName;
  String? appVersion;
  String? appBuildNumber;

  bool _resourcesReady = false;
  String? displayName;
  PackageInfo? packageInfo;

  Future<void> init() async {
    if (_resourcesReady) {
      return;
    }

    packageInfo = await PackageInfo.fromPlatform();

    displayName = packageInfo!.appName;

    appName = packageInfo!.appName;
    appPackageName = packageInfo!.packageName;
    appVersion = packageInfo!.version;
    appBuildNumber = packageInfo!.buildNumber;

    _resourcesReady = true;
  }

  String get displayVersion {
    String displayMessage = 'Version ${appVersion ?? '1.0.0'}';
    return displayMessage;
  }
}
