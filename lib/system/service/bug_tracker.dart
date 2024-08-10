import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:story_weaver/system/service/file_service.dart';

import '../global_extension.dart';
import '../global_style.dart';
import '../popup/toast.dart';
import 'local_logger.dart';

class AppBugTracker {
  factory AppBugTracker() => instance;

  AppBugTracker._();

  /// Singleton factory
  static final AppBugTracker instance = AppBugTracker._();

  // final FirebaseCrashlytics _firebaseCrashlytics = FirebaseCrashlytics.instance;

  final String localApiCallBreadcrumbEventName =
      'localApiCallBreadcrumbEventName';

  /// Local only
  final AppLocalLogger _logger = AppLocalLogger('BugTrackerService');
  final List<AppBugTrackerLocalBreadCrumbModel> _breadCrumbList =
      <AppBugTrackerLocalBreadCrumbModel>[];

  /// Insert a breadcrumb to the collected breadcrumb list
  void insertBreadcrumbs({
    required String title,
    String? subtitle,
    BreadcrumbType? breadcrumbType = BreadcrumbType.normal,
    Map<String, dynamic>? data,
  }) {
    // _firebaseCrashlytics.log(title);
    _breadCrumbList.add(
      AppBugTrackerLocalBreadCrumbModel.newData(
        bcTitle: title,
        bcSubtitle: subtitle,
        type: breadcrumbType,
        bcData: data,
      ),
    );
  }

  /// Find a breadcrumb from collected breadcrumbs
  AppBugTrackerLocalBreadCrumbModel? findBreadCrumb(String name) {
    try {
      final List<AppBugTrackerLocalBreadCrumbModel> breadCrumbList =
          _breadCrumbList
              .where((AppBugTrackerLocalBreadCrumbModel element) =>
                  element.bcTitle.ignoreCaseIgnoreSpace(name))
              .toList();

      if (breadCrumbList.isNotNullOrEmpty) {
        return breadCrumbList.first;
      }
    } on Exception catch (e, s) {
      captureException(exception: e, stackTrace: s);
      return null;
    }
    return null;
  }

  /// Get the last collected breadcrumb
  AppBugTrackerLocalBreadCrumbModel? getLastBreadcrumbs() {
    if (_breadCrumbList.isNullOrEmpty) {
      return null;
    } else {
      return _breadCrumbList.first;
    }
  }

  /// Get all collected breadcrumbs
  List<AppBugTrackerLocalBreadCrumbModel> getLastBreadcrumbsWithCount(
      int count) {
    if (_breadCrumbList.isNullOrEmpty) {
      return <AppBugTrackerLocalBreadCrumbModel>[];
    } else {
      return _breadCrumbList.reversed.take(count).toList();
    }
  }

  /// Get all collected breadcrumbs
  List<AppBugTrackerLocalBreadCrumbModel>? getAllBreadcrumbs() {
    if (_breadCrumbList.isNullOrEmpty) {
      return null;
    } else {
      return _breadCrumbList;
    }
  }

  /// Share collected breadcrumbs as an txt file
  Future<void> shareBreadCrumb(BuildContext context) async {
    if (_breadCrumbList.isNotNullOrEmpty) {
      final File? txtFile = await FileService()
          .createInternalDirTxtFile(jsonEncode(_breadCrumbList));

      if (txtFile != null) {
        final XFile xFile = XFile(txtFile.path);
        Share.shareXFiles(<XFile>[xFile]);
      } else {
        if (context.mounted) {
          AppToast.sError(
            text:
                'Terjadi kesalahan saat pembuatan file, silahkan coba lagi nanti',
            context: context,
          );
        }
      }
    } else {
      AppToast.sError(
        text: 'Tidak ada breadcrumbs yang tersedia untuk dibagikan',
        context: context,
      );
    }
  }

  /// Capture exception happens in the app
  void captureException({
    String? message,
    Exception? exception,
    StackTrace? stackTrace,
    Map<String, dynamic>? data,
  }) {
    insertBreadcrumbs(
      title: 'Capture Exception in $message',
      subtitle: exception.toString(),
      data: data,
      breadcrumbType: BreadcrumbType.exception,
    );

    // _firebaseCrashlytics.recordError(
    //   exception,
    //   stackTrace,
    //   reason: message,
    //   information: getLastBreadcrumbsWithCount(5),
    // );

    _printError(
      message: message,
      exception: exception,
      stackTrace: stackTrace,
      data: data,
    );
  }

  /// Print any error to the console log.
  void _printError({
    String? message,
    Exception? exception,
    StackTrace? stackTrace,
    Map<String, dynamic>? data,
  }) {
    insertBreadcrumbs(
        title: 'Capture Exception in $message',
        subtitle: exception.toString(),
        data: data,
        breadcrumbType: BreadcrumbType.error);

    _logger.printError(
      message: message,
      exception: exception,
      stackTrace: stackTrace,
      data: data,
    );
  }
}

/// Breadcrumb data model
class AppBugTrackerLocalBreadCrumbModel {
  AppBugTrackerLocalBreadCrumbModel({
    required this.dateCreated,
    required this.bcTitle,
    this.bcData,
    this.bcSubtitle,
    this.bcType = BreadcrumbType.normal,
  });

  factory AppBugTrackerLocalBreadCrumbModel.newData(
          {required String bcTitle,
          String? bcSubtitle,
          Map<String, dynamic>? bcData,
          BreadcrumbType? type}) =>
      AppBugTrackerLocalBreadCrumbModel(
          dateCreated: DateTime.now(),
          bcTitle: bcTitle,
          bcData: bcData,
          bcSubtitle: bcSubtitle,
          bcType: type);

  final DateTime dateCreated;
  final String bcTitle;
  final String? bcSubtitle;
  final BreadcrumbType? bcType;
  final Map<String, dynamic>? bcData;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'dateCreated':
          dateCreated.formatDate(ExtensionsVariable.dateFormatYYYYMMDDTHHMMSSZ),
      'bcTitle': bcTitle,
      'bcSubtitle': bcSubtitle,
      'bcType': bcType.toString(),
      'bcData': bcData.toString(),
    };
  }

  Color get displayTypeColor {
    switch (bcType) {
      case BreadcrumbType.normal:
        return AppColors.textBlack;
      case BreadcrumbType.success:
        return Colors.indigo;
      case BreadcrumbType.error:
        return Colors.red;
      case BreadcrumbType.exception:
        return Colors.red;
      default:
        return AppColors.textBlack;
    }
  }
}

enum BreadcrumbType { normal, success, error, exception }
