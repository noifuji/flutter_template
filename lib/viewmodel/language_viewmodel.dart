//MaterialAppのlocaleにて言語が設定される。
//このクラスでは、Localeを保持する。
//システムロケールとアプリで対応しているロケールを保持する。
//初期値はシステムロケールのリストの若い順かつアプリで対応しているロケールの若い順。
//対応するロケールがなければアプリで対応しているロケールの先頭とする。
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LanguageViewModel extends ChangeNotifier{
  final prefKeyLanguageCode = "languageCode";
  final prefKeyCountryCode = "countryCode";

  final SharedPreferences sharedPreferences;
  final List<Locale> systemLocales;
  final List<Locale> supportedLocales;

  late Locale _locale;

  LanguageViewModel(
      {required this.sharedPreferences,
      required this.systemLocales,
      required this.supportedLocales}) {
    _locale = systemLocales.firstWhere((e) => supportedLocales.contains(e), orElse: () => supportedLocales.first);
  }

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    await sharedPreferences.setString("languageCode", _locale.languageCode);
    await sharedPreferences.setString("countryCode", _locale.countryCode?? "");
    notifyListeners();
  }

  Locale getLocale() {
    String? languageCode =  sharedPreferences.getString("languageCode");
    String? countryCode = sharedPreferences.getString("countryCode");

    if(languageCode == null) {
      return _locale;
    }

    if(countryCode == null || countryCode == "") {
      return Locale(languageCode);
    }

    return Locale(languageCode, countryCode);
  }


}
