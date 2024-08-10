import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:story_weaver/system/global_style.dart';

class FullScreenLoadingView extends StatelessWidget {
  const FullScreenLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: AppQuery.instance.width,
          height: AppQuery.instance.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                AppColors.blueTealish,
                AppColors.blueSky,
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Lottie.asset(
            'assets/animation-json/cloud-animation-2.json',
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Lottie.asset('assets/animation-json/sun-animation.json'),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Lottie.asset('assets/animation-json/cloud-animation.json'),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Lottie.asset('assets/animation-json/loading-animation-2.json'),
        ),
      ],
    );
  }
}
