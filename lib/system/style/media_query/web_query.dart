// ignore: avoid_web_libraries_in_flutter
import 'dart:html' show window;
import 'media_query.dart';

class WebMediaQuery extends AppQuery {
  @override
  double get width => window.screen!.width!.toDouble();

  @override
  double get height => window.screen!.height!.toDouble();
}

AppQuery getMediaQuery() => WebMediaQuery();
