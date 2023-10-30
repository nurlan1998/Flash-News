import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/shared_preferences_keys.dart';

typedef LanguageChangeHandler = Function(String language);

class Application {
  static String? language;

  static LanguageChangeHandler? onAppLanguageChanged;

  Application._();

  // Shared Prefs
  static SharedPreferences? get sharedPreferences => _sharedPreferences;
  static SharedPreferences? _sharedPreferences;

  static Future<void> setupSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> setLanguageFromSharedPrefs() async {
    bool? issetKey = sharedPreferences?.containsKey(SharedPreferencesKeys.appLanguage);
    if (language == null && issetKey != null && issetKey) {
      language = sharedPreferences?.getString(SharedPreferencesKeys.appLanguage);
    }
  }
}