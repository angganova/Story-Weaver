// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'routes_map.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter({
    GlobalKey<NavigatorState>? navigatorKey,
    required this.authGuard,
  }) : super(navigatorKey);

  final AuthGuard authGuard;

  @override
  final Map<String, PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const SplashScreen(),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    HomeScreenRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    StoryGeneratorScreenRoute.name: (routeData) {
      final args = routeData.argsAs<StoryGeneratorScreenRouteArgs>();
      return CustomPage<dynamic>(
        routeData: routeData,
        child: StoryGeneratorScreen(
          key: args.key,
          storyBreakdownModel: args.storyBreakdownModel,
          storyHighlight: args.storyHighlight,
        ),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    StoryPreparationScreenRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const StoryPreparationScreen(),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    StoryOptionPickerScreenRoute.name: (routeData) {
      final args = routeData.argsAs<StoryOptionPickerScreenRouteArgs>();
      return CustomPage<dynamic>(
        routeData: routeData,
        child: StoryOptionPickerScreen(
          key: args.key,
          optList: args.optList,
          appBarTitle: args.appBarTitle,
          singleSelect: args.singleSelect,
        ),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    StoryDetailScreenRoute.name: (routeData) {
      final args = routeData.argsAs<StoryDetailScreenRouteArgs>();
      return CustomPage<dynamic>(
        routeData: routeData,
        child: StoryDetailScreen(
          key: args.key,
          storyBreakdownModel: args.storyBreakdownModel,
        ),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ChapterPreviewScreenRoute.name: (routeData) {
      final args = routeData.argsAs<ChapterPreviewScreenRouteArgs>();
      return CustomPage<dynamic>(
        routeData: routeData,
        child: ChapterPreviewScreen(
          key: args.key,
          chapterBreakdown: args.chapterBreakdown,
        ),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    CharacterPreviewScreenRoute.name: (routeData) {
      final args = routeData.argsAs<CharacterPreviewScreenRouteArgs>();
      return CustomPage<dynamic>(
        routeData: routeData,
        child: CharacterPreviewScreen(
          key: args.key,
          characterBreakdown: args.characterBreakdown,
        ),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    SettingScreenRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const SettingScreen(),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    GeminiScreenRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const GeminiScreen(),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    FontScreenRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const FontScreen(),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    FontScaleScreenRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const FontScaleScreen(),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          SplashScreenRoute.name,
          path: '/',
        ),
        RouteConfig(
          HomeScreenRoute.name,
          path: '/home-screen',
          guards: [authGuard],
        ),
        RouteConfig(
          StoryGeneratorScreenRoute.name,
          path: '/story-generator-screen',
          guards: [authGuard],
        ),
        RouteConfig(
          StoryPreparationScreenRoute.name,
          path: '/story-preparation-screen',
          guards: [authGuard],
        ),
        RouteConfig(
          StoryOptionPickerScreenRoute.name,
          path: '/story-option-picker-screen',
          guards: [authGuard],
        ),
        RouteConfig(
          StoryDetailScreenRoute.name,
          path: '/story-detail-screen',
          guards: [authGuard],
        ),
        RouteConfig(
          ChapterPreviewScreenRoute.name,
          path: '/chapter-preview-screen',
          guards: [authGuard],
        ),
        RouteConfig(
          CharacterPreviewScreenRoute.name,
          path: '/character-preview-screen',
          guards: [authGuard],
        ),
        RouteConfig(
          SettingScreenRoute.name,
          path: '/setting-screen',
          guards: [authGuard],
        ),
        RouteConfig(
          GeminiScreenRoute.name,
          path: '/gemini-screen',
          guards: [authGuard],
        ),
        RouteConfig(
          FontScreenRoute.name,
          path: '/font-screen',
          guards: [authGuard],
        ),
        RouteConfig(
          FontScaleScreenRoute.name,
          path: '/font-scale-screen',
          guards: [authGuard],
        ),
      ];
}

/// generated route for
/// [SplashScreen]
class SplashScreenRoute extends PageRouteInfo<void> {
  const SplashScreenRoute()
      : super(
          SplashScreenRoute.name,
          path: '/',
        );

  static const String name = 'SplashScreenRoute';
}

/// generated route for
/// [HomeScreen]
class HomeScreenRoute extends PageRouteInfo<void> {
  const HomeScreenRoute()
      : super(
          HomeScreenRoute.name,
          path: '/home-screen',
        );

  static const String name = 'HomeScreenRoute';
}

/// generated route for
/// [StoryGeneratorScreen]
class StoryGeneratorScreenRoute
    extends PageRouteInfo<StoryGeneratorScreenRouteArgs> {
  StoryGeneratorScreenRoute({
    Key? key,
    required StoryBreakdownModel storyBreakdownModel,
    String? storyHighlight,
  }) : super(
          StoryGeneratorScreenRoute.name,
          path: '/story-generator-screen',
          args: StoryGeneratorScreenRouteArgs(
            key: key,
            storyBreakdownModel: storyBreakdownModel,
            storyHighlight: storyHighlight,
          ),
        );

  static const String name = 'StoryGeneratorScreenRoute';
}

class StoryGeneratorScreenRouteArgs {
  const StoryGeneratorScreenRouteArgs({
    this.key,
    required this.storyBreakdownModel,
    this.storyHighlight,
  });

  final Key? key;

  final StoryBreakdownModel storyBreakdownModel;

  final String? storyHighlight;

  @override
  String toString() {
    return 'StoryGeneratorScreenRouteArgs{key: $key, storyBreakdownModel: $storyBreakdownModel, storyHighlight: $storyHighlight}';
  }
}

/// generated route for
/// [StoryPreparationScreen]
class StoryPreparationScreenRoute extends PageRouteInfo<void> {
  const StoryPreparationScreenRoute()
      : super(
          StoryPreparationScreenRoute.name,
          path: '/story-preparation-screen',
        );

  static const String name = 'StoryPreparationScreenRoute';
}

/// generated route for
/// [StoryOptionPickerScreen]
class StoryOptionPickerScreenRoute
    extends PageRouteInfo<StoryOptionPickerScreenRouteArgs> {
  StoryOptionPickerScreenRoute({
    Key? key,
    required List<TitleDetailModel> optList,
    required String appBarTitle,
    bool singleSelect = false,
  }) : super(
          StoryOptionPickerScreenRoute.name,
          path: '/story-option-picker-screen',
          args: StoryOptionPickerScreenRouteArgs(
            key: key,
            optList: optList,
            appBarTitle: appBarTitle,
            singleSelect: singleSelect,
          ),
        );

  static const String name = 'StoryOptionPickerScreenRoute';
}

class StoryOptionPickerScreenRouteArgs {
  const StoryOptionPickerScreenRouteArgs({
    this.key,
    required this.optList,
    required this.appBarTitle,
    this.singleSelect = false,
  });

  final Key? key;

  final List<TitleDetailModel> optList;

  final String appBarTitle;

  final bool singleSelect;

  @override
  String toString() {
    return 'StoryOptionPickerScreenRouteArgs{key: $key, optList: $optList, appBarTitle: $appBarTitle, singleSelect: $singleSelect}';
  }
}

/// generated route for
/// [StoryDetailScreen]
class StoryDetailScreenRoute extends PageRouteInfo<StoryDetailScreenRouteArgs> {
  StoryDetailScreenRoute({
    Key? key,
    required StoryBreakdownModel storyBreakdownModel,
  }) : super(
          StoryDetailScreenRoute.name,
          path: '/story-detail-screen',
          args: StoryDetailScreenRouteArgs(
            key: key,
            storyBreakdownModel: storyBreakdownModel,
          ),
        );

  static const String name = 'StoryDetailScreenRoute';
}

class StoryDetailScreenRouteArgs {
  const StoryDetailScreenRouteArgs({
    this.key,
    required this.storyBreakdownModel,
  });

  final Key? key;

  final StoryBreakdownModel storyBreakdownModel;

  @override
  String toString() {
    return 'StoryDetailScreenRouteArgs{key: $key, storyBreakdownModel: $storyBreakdownModel}';
  }
}

/// generated route for
/// [ChapterPreviewScreen]
class ChapterPreviewScreenRoute
    extends PageRouteInfo<ChapterPreviewScreenRouteArgs> {
  ChapterPreviewScreenRoute({
    Key? key,
    required ChapterBreakdown chapterBreakdown,
  }) : super(
          ChapterPreviewScreenRoute.name,
          path: '/chapter-preview-screen',
          args: ChapterPreviewScreenRouteArgs(
            key: key,
            chapterBreakdown: chapterBreakdown,
          ),
        );

  static const String name = 'ChapterPreviewScreenRoute';
}

class ChapterPreviewScreenRouteArgs {
  const ChapterPreviewScreenRouteArgs({
    this.key,
    required this.chapterBreakdown,
  });

  final Key? key;

  final ChapterBreakdown chapterBreakdown;

  @override
  String toString() {
    return 'ChapterPreviewScreenRouteArgs{key: $key, chapterBreakdown: $chapterBreakdown}';
  }
}

/// generated route for
/// [CharacterPreviewScreen]
class CharacterPreviewScreenRoute
    extends PageRouteInfo<CharacterPreviewScreenRouteArgs> {
  CharacterPreviewScreenRoute({
    Key? key,
    required CharacterBreakdown characterBreakdown,
  }) : super(
          CharacterPreviewScreenRoute.name,
          path: '/character-preview-screen',
          args: CharacterPreviewScreenRouteArgs(
            key: key,
            characterBreakdown: characterBreakdown,
          ),
        );

  static const String name = 'CharacterPreviewScreenRoute';
}

class CharacterPreviewScreenRouteArgs {
  const CharacterPreviewScreenRouteArgs({
    this.key,
    required this.characterBreakdown,
  });

  final Key? key;

  final CharacterBreakdown characterBreakdown;

  @override
  String toString() {
    return 'CharacterPreviewScreenRouteArgs{key: $key, characterBreakdown: $characterBreakdown}';
  }
}

/// generated route for
/// [SettingScreen]
class SettingScreenRoute extends PageRouteInfo<void> {
  const SettingScreenRoute()
      : super(
          SettingScreenRoute.name,
          path: '/setting-screen',
        );

  static const String name = 'SettingScreenRoute';
}

/// generated route for
/// [GeminiScreen]
class GeminiScreenRoute extends PageRouteInfo<void> {
  const GeminiScreenRoute()
      : super(
          GeminiScreenRoute.name,
          path: '/gemini-screen',
        );

  static const String name = 'GeminiScreenRoute';
}

/// generated route for
/// [FontScreen]
class FontScreenRoute extends PageRouteInfo<void> {
  const FontScreenRoute()
      : super(
          FontScreenRoute.name,
          path: '/font-screen',
        );

  static const String name = 'FontScreenRoute';
}

/// generated route for
/// [FontScaleScreen]
class FontScaleScreenRoute extends PageRouteInfo<void> {
  const FontScaleScreenRoute()
      : super(
          FontScaleScreenRoute.name,
          path: '/font-scale-screen',
        );

  static const String name = 'FontScaleScreenRoute';
}
