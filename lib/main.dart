import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:story_weaver/firebase_options.dart';
import 'package:story_weaver/system/style/text_style.dart';
import 'app/app_view.dart';
import 'system/service/local_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Gemini.init(
    apiKey: 'AIzaSyDdkjuGjgbw594ICDpkpJhDRNRqygPwgM4',
    enableDebugging: true,
  );
  AppLocalStorage.instance.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  AppTextStyle.instance.init();
  runApp(const AppView());
}
