import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

// dependencies :
// logger: ^1.0.0

class AppLocalLogger {
  /// This class hold all the function to log anything in the console

  AppLocalLogger(this.tag, {this.easySearch = true});

  static const String defaultEasySearchTag = 'XXX ';

  final Logger loggerInfo = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      colors: true,
    ),
  );

  final Logger loggerError = Logger(
    printer: PrettyPrinter(
      methodCount: 10,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
    ),
  );

  final String tag;
  final bool easySearch;

  void printDebug(String s) {
    final String easySearchTag = easySearch ? defaultEasySearchTag : '';
    if (!kDebugMode) {
      return;
    } else if (kIsWeb) {
      debugPrint('$easySearchTag $tag $s');
    } else {
      loggerInfo.d('$easySearchTag $tag $s');
    }
  }

  void printError(
      {String? message,
      Exception? exception,
      StackTrace? stackTrace,
      Map<String, dynamic>? data}) {
    final String easySearchTag = easySearch ? defaultEasySearchTag : '';

    if (!kDebugMode) {
      return;
    } else if (kIsWeb) {
      printDebug('$easySearchTag $tag $message');
    } else {
      if (exception != null || stackTrace != null) {
        loggerError.e('$easySearchTag $tag $message', exception, stackTrace);
      } else {
        loggerInfo.e('$easySearchTag $tag $message $data');
      }
    }
  }
}
