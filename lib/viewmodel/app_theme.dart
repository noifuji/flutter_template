// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeName { dark, light }

class AppTheme extends ChangeNotifier {
  final Map<AppThemeName, ThemeData> supportedThemes = {
    AppThemeName.dark: ThemeData(brightness: Brightness.dark),
    AppThemeName.light: ThemeData(brightness: Brightness.light),
  };
  final String prefKeyTheme = 'themeCode';
  AppThemeName _themeName = AppThemeName.light;
  ThemeData _theme = ThemeData(brightness: Brightness.light);

  AppThemeName get themeName => _themeName;
  ThemeData get theme => _theme;

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString(prefKeyTheme);

    final th = AppThemeName.values.firstWhere(
      (element) => element.name == theme,
      orElse: () => _themeName,
    );

    _theme = supportedThemes[th] ?? _theme;
    _themeName = th;
  }

  Future<void> changeTheme(AppThemeName theme) async {
    final themeData = supportedThemes[theme];

    if (themeData == null) {
      throw Exception('This theme is not supported : $theme');
    }
    _theme = themeData;
    _themeName = theme;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(prefKeyTheme, _themeName.name);
    notifyListeners();
  }
}
