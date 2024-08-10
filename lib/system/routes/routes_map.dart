import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:story_weaver/app/screen/home/home_screen.dart';
import 'package:story_weaver/app/screen/setting/gemini_screen.dart';
import 'package:story_weaver/app/screen/story/preparation/story_option_picker_screen.dart';
import 'package:story_weaver/app/screen/story/preparation/story_preparation_screen.dart';
import 'package:story_weaver/app/screen/story/generator/story_generator_screen.dart';
import 'package:story_weaver/system/routes/auth_guard.dart';

import '../../app/screen/front/splash_screen.dart';
import '../../app/screen/setting/setting_screen.dart';
import '../../app/screen/story/chapter/chapter_preview_screen.dart';
import '../../app/screen/story/character/character_preview_screen.dart';
import '../../app/screen/story/detail/story_detail_screen.dart';
import '../../data/model/main/title_detail_model.dart';
import '../../data/model/story/story_breakdown_model.dart';

part 'routes_map.gr.dart';

// dependencies :
// auto_route: ^3.2.2

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route,Screen',
  routes: <AutoRoute<dynamic>>[
    /// This class hold all the navigation map that used in the app
    CustomRoute<dynamic>(
      page: SplashScreen,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      initial: true,
    ),
    CustomRoute<dynamic>(
      page: HomeScreen,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      guards: <Type>[AuthGuard],
    ),

    CustomRoute<dynamic>(
      page: StoryGeneratorScreen,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      guards: <Type>[AuthGuard],
    ),
    CustomRoute<dynamic>(
      page: StoryPreparationScreen,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      guards: <Type>[AuthGuard],
    ),
    CustomRoute<dynamic>(
      page: StoryOptionPickerScreen,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      guards: <Type>[AuthGuard],
    ),
    CustomRoute<dynamic>(
      page: StoryDetailScreen,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      guards: <Type>[AuthGuard],
    ),
    CustomRoute<dynamic>(
      page: ChapterPreviewScreen,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      guards: <Type>[AuthGuard],
    ),
    CustomRoute<dynamic>(
      page: CharacterPreviewScreen,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      guards: <Type>[AuthGuard],
    ),
    CustomRoute<dynamic>(
      page: SettingScreen,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      guards: <Type>[AuthGuard],
    ),
    CustomRoute<dynamic>(
      page: GeminiScreen,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      guards: <Type>[AuthGuard],
    ),
  ],
)

/// extend the generated private router
class AppRouter extends _$AppRouter {
  AppRouter({
    required GlobalKey<NavigatorState> super.navigatorKey,
    required super.authGuard,
  });
}
