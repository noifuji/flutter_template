import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppUISettings {
  final SharedPreferences _prefs;
  final Locale _locale = AppLocalizations.supportedLocales.firstWhere((e) => e.languageCode == "ja");
  final ThemeData _theme = ThemeData(brightness: Brightness.dark);

  AppUISettings(this._prefs);

  Locale get locale => _locale;
  ThemeData get theme => _theme;
}