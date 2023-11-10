import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:news_app_flutter/core/data/cache.dart';

class ThemeModeHelper {
  ThemeModeHelper._();

  static void setupSystemNavigation() {
    final isDarkMode = cache.get(cacheKey, defaultValue: true) == true;
    _updateSystemNavigation(isDarkMode);
  }

  static const cacheKey = 'appThemeModeIsDark';

  static Box<bool> get cache => Cache.box<bool>();

  static final ValueNotifier<ThemeMode> notifier = ValueNotifier<ThemeMode>(
      cache.get(cacheKey, defaultValue: true) == false
          ? ThemeMode.light
          : ThemeMode.dark);

  static void changeToOpposite() {
    themeMode = isDark ? ThemeMode.light : ThemeMode.dark;
  }

  static void _updateSystemNavigation([bool isDarkMode = false]) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xff0a0a0a),
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  }

  static set themeMode(ThemeMode mode) {
    final isDarkMode = mode == ThemeMode.dark;
    notifier.value = mode;
    cache.put(cacheKey, isDarkMode);
    _updateSystemNavigation(isDarkMode);
  }

  static ThemeMode get themeMode => notifier.value;

  static bool get isDark => themeMode == ThemeMode.dark;

  static bool get isLight => !isDark;
}