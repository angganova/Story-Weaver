import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_weaver/system/extension/string_extension.dart';

class AppLocalStorage {
  factory AppLocalStorage() => instance;

  AppLocalStorage._();

  /// Singleton factory
  static final AppLocalStorage instance = AppLocalStorage._();

  /// System related key
  final String _enableAppId = '4172y4ndxkjcfkje84y8r42';
  final String _uuidId = '49f2f6256d5479c8201966eeccac2fc0';
  final String _firstLaunchId = '0d7688aacbf97332c7fd9647d3fdd14e';
  final String _languageId = '87891c2bd544694b276574e649c97bf7';
  final String _appLastVersionId = '8a35ad98fee10185fb5d8c757cbaceac';
  final String _geminiModelId = '8a35ad98fee101afda';
  final String _textStyleId = '8a35ad98fee101af23y4nsada';

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
