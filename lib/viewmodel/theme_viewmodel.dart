import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeViewModel extends ChangeNotifier{
  final SharedPreferences sharedPreferences;
  final Map<String, ThemeData> supportedThemes;
  final String prefKeyTheme = "themeCode";
  late ThemeData _theme;

  ThemeViewModel({required this.sharedPreferences, required this.supportedThemes}) {
    _theme = supportedThemes[supportedThemes.keys.first]!;
  }

  Future<void> setTheme(String theme) async {
    ThemeData? themeData = supportedThemes[theme];

    if(themeData == null) {
      throw Exception("This theme is not supported : $theme");
    }
    _theme = themeData;
    await sharedPreferences.setString(prefKeyTheme, theme);
    notifyListeners();
  }

  ThemeData getTheme() {
    String? theme =  sharedPreferences.getString(prefKeyTheme);

    if(theme == null) {
      return _theme;
    }

    return supportedThemes[theme]?? _theme;
  }


}
