import 'package:flutter/material.dart';

import '../../../app/app_vm.dart';
import 'media_query.dart';

class MobileMediaQuery extends AppQuery {
  @override
  double get width =>
      MediaQuery.of(AppVm.instance.mediaQueryContext).size.width;

  @override
  double get height =>
      MediaQuery.of(AppVm.instance.mediaQueryContext).size.height;
}

AppQuery getMediaQuery() => MobileMediaQuery();
