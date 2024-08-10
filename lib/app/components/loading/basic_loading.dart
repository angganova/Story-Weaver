import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../system/global_style.dart';
import '../../../system/variables/var_style.dart';

class AppBasicLoading extends StatefulWidget {
  const AppBasicLoading({
    super.key,
    this.color,
    this.withBackground = true,
    this.backgroundWidth,
    this.backgroundHeight,
  });

  final Color? color;

  final bool withBackground;
  final double? backgroundWidth;
  final double? backgroundHeight;

  factory AppBasicLoading.withBackground([String? text]) {
    return AppBasicLoading(
      withBackground: true,
      backgroundWidth: AppQuery.instance.responsiveWidth(50),
      backgroundHeight: AppQuery.instance.responsiveWidth(50),
    );
  }

  @override
  State<StatefulWidget> createState() {
    return _LoadingAnimatorState();
  }
}

class _LoadingAnimatorState extends State<AppBasicLoading>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.backgroundWidth ?? AppQuery.instance.width,
        height:
            widget.backgroundHeight ?? AppQuery.instance.responsiveWidth(50),
        padding: AppSpacer.instance.edgeInsets.all.sm,
        decoration: widget.withBackground
            ? const BoxDecoration(
                color: AppColors.white,
                borderRadius: kBorderRadiusAll12,
              )
            : null,
        child: Lottie.asset('assets/animation-json/loading-animation.json'),
      ),
    );
  }
}
