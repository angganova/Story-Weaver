import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:story_weaver/app/app_vm.dart';
import 'package:story_weaver/app/screen/home/home_vm.dart';
import 'package:story_weaver/system/extension/list_extension.dart';
import 'package:story_weaver/system/extension/string_extension.dart';
import 'package:story_weaver/system/global_style.dart';
import 'package:story_weaver/system/service/ai_service.dart';
import 'package:story_weaver/system/service/local_storage.dart';

import '../system/config/app_info.dart';
import '../system/service/navigator.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> with WidgetsBindingObserver {
  final AppVm _appVM = AppVm.instance;
  String languageCode = 'en_US';

  @override
  void initState() {
    _initPlatformState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('en_US', null);

    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<HomeVm>(create: (_) => HomeVm()),
      ],
      child: _mainView,
    );
  }

  Widget get _mainView {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      routeInformationParser:
          AppNavigator.instance.appRoutesMap.defaultRouteParser(),
      routerDelegate: AppNavigator.instance.appRoutesMap.delegate(
        navigatorObservers: () => <NavigatorObserver>[AutoRouteObserver()],
      ),
      locale: Locale(languageCode),
      // supportedLocales: const <Locale>[Locale('en', 'US'), Locale('id', 'ID')],
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        FallbackCupertinoLocalizationDelegate(),
        FallbackWidgetsLocalizationDelegate(),
        FallbackMaterialLocalizationDelegate(),
      ],
      title: 'Story Weaver',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        primaryColorDark: AppColors.primaryColorDark,
        primaryColorLight: AppColors.primaryColorLight,
        scaffoldBackgroundColor: AppColors.white,
        primarySwatch: Colors.blueGrey,
        fontFamily: 'Poppins',
      ),
      builder: (BuildContext context, Widget? child) {
        _appVM.init(context, AppNavigator.navigatorKey);
        return MediaQuery(
          data: AppQuery.instance.mediaQueryData!,
          child: child!,
        );
      },
    );
  }

  Future<void> _initPlatformState() async {
    WidgetsBinding.instance.addObserver(this);
    AiService.instance.geminiList = await AiService.instance.AI.listModels();
    AppInfo.instance.init();
    if (AiService.instance.geminiList.isNotNullOrEmpty &&
        AppLocalStorage.instance.geminiModel.isNullOrEmpty) {
      GeminiModel geminiPro = AiService.instance.geminiList!.firstWhere(
          (item) => item.name.containIgnoreCase('flash'),
          orElse: () => AiService.instance.geminiList!.first);
      AppLocalStorage.instance.setGeminiModel(geminiPro);
    }
  }
}

class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  @override
  bool isSupported(Locale locale) => true;
  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      const DefaultMaterialLocalizations();
  @override
  bool shouldReload(LocalizationsDelegate<MaterialLocalizations> old) => false;
}

class FallbackWidgetsLocalizationDelegate
    extends LocalizationsDelegate<WidgetsLocalizations> {
  @override
  bool isSupported(Locale locale) => true;
  @override
  Future<WidgetsLocalizations> load(Locale locale) async =>
      const DefaultWidgetsLocalizations();
  @override
  bool shouldReload(LocalizationsDelegate<WidgetsLocalizations> old) => false;
}

class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  @override
  bool isSupported(Locale locale) => true;
  @override
  Future<CupertinoLocalizations> load(Locale locale) async =>
      const DefaultCupertinoLocalizations();
  @override
  bool shouldReload(LocalizationsDelegate<CupertinoLocalizations> old) => false;
}
