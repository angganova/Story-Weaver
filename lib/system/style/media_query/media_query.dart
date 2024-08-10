// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'media_query_stub.dart'
    if (dart.library.io) 'package:story_weaver/system/style/media_query/mobile_query.dart'
    if (dart.library.js) 'package:story_weaver/system/style/media_query/web_query.dart';

class AppQuery {
  static AppQuery? _instance;

  static AppQuery get instance {
    _instance ??= getMediaQuery() as AppQuery?;
    return _instance!;
  }

  final double kSmallScreenWidth = 350;
  final double kMedScreenHeight = 700;

  late double width;
  late double height;
  late EdgeInsets mediaQueryPadding;

  MediaQueryData? mediaQueryData;

  void init(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double scale = mediaQuery.textScaleFactor.clamp(1, 1.2);

    mediaQueryData = MediaQuery.of(context).copyWith(textScaleFactor: scale);

    mediaQueryPadding = mediaQueryData!.padding;
    width = mediaQueryData!.size.width;
    height = mediaQueryData!.size.height;
  }

  double get deviceAspectRatio => width / height;

  double get screenWidthFull => width;
  double get screenWidthHalf => width / 2;
  double get screenWidthThird => width / 3;
  double get screenWidthFourth => width / 4;
  double responsiveWidth(double percentage) => width * (percentage / 100);
  double responsiveWidthByTextScale(double percentage) =>
      responsiveWidth(percentage) * mediaQueryData!.textScaleFactor;

  double get screenHeightFull => height;
  double get screenHeightHalf => height / 2;
  double get screenHeightThird => height / 3;
  double get screenHeightFourth => height / 4;
  double responsiveHeight(double percentage) => height * (percentage / 100);
}
