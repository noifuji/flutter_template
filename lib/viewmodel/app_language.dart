// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = const Locale('en');
  Locale get appLocale => _appLocale;

  Future<void> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final storedLanguageCode = prefs.getString('languageCode');

    if (storedLanguageCode != null) {
      _appLocale = Locale.fromSubtags(languageCode: storedLanguageCode);
    } else {
      _appLocale = WidgetsBinding.instance.platformDispatcher.locale;
    }
  }

  Future<void> changeLanguage(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', locale.languageCode);

    _appLocale = locale;
    notifyListeners();
  }
}
