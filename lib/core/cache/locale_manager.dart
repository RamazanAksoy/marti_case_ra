import 'package:shared_preferences/shared_preferences.dart';

class LocaleManager {
  static SharedPreferences? _prefs;

  /// Singleton örneği
  static final LocaleManager _instance = LocaleManager._();

  /// Private constructor
  LocaleManager._();

  /// Singleton erişim sağlayan getter
  static LocaleManager get instance => _instance;

  /// İlk başlatma metodu
  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  String getString(String key) {
    return _prefs?.getString(key) ?? '';
  }

  Future<void> setStringList(String key, List<String> value) async {
    await _prefs?.setStringList(key, value);
  }

  List<String> getStringList(String key) {
    return _prefs?.getStringList(key) ?? [];
  }

  Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  bool getBool(String key) {
    return _prefs?.getBool(key) ?? false;
  }

  Future<void> clear(String key) async {
    await _prefs?.remove(key);
  }

  Future<void> clearAll() async {
    await _prefs?.clear();
  }
}
