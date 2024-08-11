import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_weaver/system/extension/string_extension.dart';

class AppLocalStorage {
  factory AppLocalStorage() => instance;

  AppLocalStorage._();

  /// Singleton factory
  static final AppLocalStorage instance = AppLocalStorage._();

  /// System related key
  final String _enableAppId = '01f8e553f60a0cf2be2a654bcca59cda';
  final String _uuidId = '4eedfa782ec1432b0b039b8a0a9d4b22';
  final String _firstLaunchId = '7228995e1442c2a48d78d240a9f8ab7b';
  final String _languageId = 'ccdef14a56e5fae667d0eb66eb137a74';
  final String _appLastVersionId = '87fbb8ae445c4f62e7bc58183a92facd';
  final String _geminiModelId = 'abff7875888bfd171454e161222fd2b0';
  final String _textStyleId = 'f07cd095c593d6d865d58945eaafc6c3';
  final String _textScaleId = '755c330071fd0dc81ecbfb4d6ac71bf8';

  late SharedPreferences _localStorage;

  Future<void> init() async {
    _localStorage = await SharedPreferences.getInstance();
  }

  void saveLanguageCode(String code) =>
      _localStorage.setString(_languageId, code);
  String get getLanguageCode => _localStorage.getString(_languageId) ?? 'id';

  void saveTextStyleName(String style) =>
      _localStorage.setString(_textStyleId, style);
  String get getTextStyleName => _localStorage.getString(_textStyleId) ?? 'id';

  void saveTextScale(double size) =>
      _localStorage.setDouble(_textScaleId, size);
  double get getTextScale => _localStorage.getDouble(_textScaleId) ?? 1;

  Future<bool> saveFirstLaunch(bool isFirstLaunch) async =>
      _localStorage.setBool(_firstLaunchId, isFirstLaunch);
  bool get isFirstLaunch => _localStorage.getBool(_firstLaunchId) ?? true;

  Future<bool> setLastAppVersionNumber(int versionNumber) async =>
      _localStorage.setInt(_appLastVersionId, versionNumber);
  int get appLastVersionNumber =>
      _localStorage.getInt(_appLastVersionId) ?? 100;

  Future<bool> setEnableApp(bool enableApp) async =>
      _localStorage.setBool(_enableAppId, enableApp);
  bool get isEnableApp => _localStorage.getBool(_enableAppId) ?? false;

  Future<bool?> saveUuid(String? uuid) async =>
      _localStorage.setString(_uuidId, uuid ?? '');
  Future<bool> deleteUuid() async => _localStorage.remove(_uuidId);
  String? get uuid => _localStorage.getString(_uuidId);

  Future<bool> setGeminiModel(GeminiModel item) async {
    String displayStorage = '${item.name ?? ''}|||${item.version ?? ' '}';
    if (!displayStorage.ignoreCase('|||')) {
      _localStorage.setString(_geminiModelId, displayStorage);
      return true;
    }
    return false;
  }

  String get geminiModel => _localStorage.getString(_geminiModelId) ?? '';
  String get geminiModelId => geminiModel.split('|||').first;
  bool isSelectedGeminiModel(GeminiModel item) {
    String displayStorage = '${item.name ?? ''}|||${item.version ?? ' '}';
    String storedGeminiModel = geminiModel;
    return displayStorage == storedGeminiModel;
  }
}
