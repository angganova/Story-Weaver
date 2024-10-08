import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:story_weaver/app/components/button/icon_button.dart';
import 'package:story_weaver/app/components/global/fs_loading_view.dart';
import 'package:story_weaver/app/components/text/basic_text.dart';
import 'package:story_weaver/system/extension/num_extension.dart';
import 'package:story_weaver/system/service/local_storage.dart';
import 'package:story_weaver/system/style/colors.dart';
import 'package:story_weaver/system/style/dimensions.dart';
import 'package:story_weaver/system/style/media_query/media_query.dart';

import '../../../system/global_variable.dart';
import '../../../system/routes/routes_map.dart';
import '../../../system/service/navigator.dart';

class IntroPageModel {
  IntroPageModel({required this.title, required this.detail});

  final String title;
  final String detail;
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final List<IntroPageModel> _introList = [
    IntroPageModel(
      title: 'Discover Your Voice',
      detail: 'Welcome to StoryWeaver, where your imagination comes to life. '
          'Whether crafting a short story or a novel, discover and refine your unique voice with ease.',
    ),
    IntroPageModel(
      title: 'Weave Your Story',
      detail:
          'StoryWeaver\'s intuitive tools and AI support make storytelling effortless. '
          'Focus on weaving your tales, whether you\'re just starting out or a seasoned writer.',
    ),
    IntroPageModel(
      title: 'Share and Connect',
      detail:
          'Share your stories with a vibrant community or keep them private. '
          'With StoryWeaver, connect with fellow writers and grow your storytelling journey.',
    ),
  ];
  int _currentPage = 0;
  bool _startIntro = false;
  bool _showAppName = false;

  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => setState(() => _showAppName = true));
    Future.delayed(kDuration1500, () {
      // if (!AppLocalStorage.instance.isEnableApp) {
      //   AppDialog.instance.sInformation(
      //     context: context,
      //     title: 'Deactivated Application',
      //     detail: 'This application is deactivated, '
      //         'please contact the developer to activate it.',
      //   );
      //   return;
      // }

      if (AppLocalStorage.instance.isFirstLaunch) {
        setState(() => _showAppName = false);
        Future.delayed(kDuration500, () => setState(() => _startIntro = true));
      } else {
        setState(() => _showAppName = false);
        Future.delayed(kDuration500,
            () => AppNavigator.instance.replace(const HomeScreenRoute()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _mainView);
  }

  Widget get _mainView {
    return Stack(
      children: [
        const FullScreenLoadingView(),
        Center(
          child: AnimatedOpacity(
            opacity: _showAppName ? 1 : 0,
            duration: kDuration400,
            child: _appNameView,
          ),
        ),
        if (_startIntro)
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: kDuration500,
              child: _startIntro ? _introView : Container(),
            ),
          ),
        if (_startIntro)
          Positioned(
            left: AppSpacer.instance.sm,
            bottom: AppSpacer.instance.sm,
            child: AnimatedOpacity(
              opacity: _currentPage.isMoreThanZero ? 1 : 0,
              duration: kDuration200,
              child: AppIconButton(
                bgColor: AppColors.white.withOpacity(0.5),
                icon: Icons.arrow_back_ios_rounded,
                onTap: () {
                  if (_currentPage.isMoreThanZero) {
                    _changePage(_currentPage - 1);
                  }
                },
              ),
            ),
          ),
        if (_startIntro)
          Positioned(
            right: AppSpacer.instance.sm,
            bottom: AppSpacer.instance.sm,
            child: AppIconButton(
              bgColor: AppColors.white.withOpacity(0.5),
              icon: _currentPage.isEqual(_introList.length - 1)
                  ? Icons.double_arrow_outlined
                  : Icons.arrow_forward_ios_rounded,
              onTap: () {
                if (_currentPage.isEqual(_introList.length - 1)) {
                  AppLocalStorage.instance.saveFirstLaunch(false);
                  AppNavigator.instance.replace(const HomeScreenRoute());
                } else {
                  _changePage(_currentPage + 1);
                }
              },
            ),
          ),
      ],
    );
  }

  Widget get _appNameView {
    return SizedBox(
      width: AppQuery.instance.width,
      child: AppText(
        'Story Weaver',
        color: AppColors.white,
        align: TextAlign.center,
        textStyle: GoogleFonts.dancingScript().copyWith(
          fontSize: 64,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget get _introView {
    return PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(_introList.length, (index) {
          final item = _introList[index];
          return _bindIntro(
            page: index,
            title: item.title,
            detail: item.detail,
          );
        }));
  }

  Widget _bindIntro({
    required int page,
    required String title,
    required String detail,
  }) {
    return Container(
      width: AppQuery.instance.width,
      height: AppQuery.instance.height,
      color: AppColors.transparent,
      padding: AppSpacer.instance.edgeInsets.all.sm,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppText(
              title,
              textStyle: GoogleFonts.aBeeZee(
                color: AppColors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              color: AppColors.white,
              align: TextAlign.center,
            ),
            AppSpacer.instance.vHs,
            DefaultTextStyle(
              textAlign: TextAlign.center,
              style: GoogleFonts.aBeeZee().copyWith(
                fontSize: 16,
                color: AppColors.white,
              ),
              child: AnimatedTextKit(
                pause: kDuration100,
                isRepeatingAnimation: false,
                displayFullTextOnTap: true,
                animatedTexts: [
                  TypewriterAnimatedText(
                    detail,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changePage(int page) {
    _pageController
        .animateToPage(page,
            duration: kDuration500, curve: Curves.easeInOutSine)
        .then((_) => setState(() => _currentPage = page));
  }
}
