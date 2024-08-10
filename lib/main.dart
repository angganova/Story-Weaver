import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:story_weaver/system/style/text_style.dart';
import 'app/app_view.dart';
import 'system/service/local_storage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Gemini.init(
    apiKey: 'AIzaSyDdkjuGjgbw594ICDpkpJhDRNRqygPwgM4',
    enableDebugging: true,
  );
  AppLocalStorage.instance.init();
  AppTextStyle.instance.init();
  runApp(const AppView());
}
