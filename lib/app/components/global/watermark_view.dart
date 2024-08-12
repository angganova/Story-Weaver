import 'package:flutter/material.dart';

import '../../../system/style/colors.dart';

class AppWaterMarkView extends StatelessWidget {
  const AppWaterMarkView({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        image: DecorationImage(
          image: AssetImage('assets/images/app_icon_black.png'),
          opacity: 0.05,
        ),
      ),
      child: child,
    );
  }
}
