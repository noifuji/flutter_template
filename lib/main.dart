import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_template/data/counter_local_data_source.dart';
import 'package:flutter_template/data/counter_repository_impl.dart';
import 'package:flutter_template/view/counter_screen.dart';
import 'package:flutter_template/viewmodel/counter_viewmodel.dart';
import 'package:flutter_template/viewmodel/language_viewmodel.dart';
import 'package:flutter_template/viewmodel/theme_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyAppState();
}

//ignore: must_be_immutable
class MyAppState extends State<MyApp> {
  late SharedPreferences _prefs;
  late CounterViewModel _counterViewModel;
  late LanguageViewModel _languageViewModel;
  late ThemeViewModel _themeViewModel;
  late Future<bool> _initialize;

  @override
  void initState() {
    super.initState();
    _initialize = _initApp();
  }

  //Initialize App
  Future<bool> _initApp() async {
    _prefs = await SharedPreferences.getInstance();
    CounterRepositoryImpl counterRepository =
        CounterRepositoryImpl(CounterLocalDataSource(_prefs));
    _counterViewModel = CounterViewModel(counterRepository);
    await _counterViewModel.init();

    _languageViewModel = LanguageViewModel(
        sharedPreferences: _prefs,
        systemLocales: WidgetsBinding.instance.window.locales,
        supportedLocales: AppLocalizations.supportedLocales);

    _themeViewModel =
        ThemeViewModel(sharedPreferences: _prefs, supportedThemes: {
      "dark": ThemeData(brightness: Brightness.dark),
      "light": ThemeData(brightness: Brightness.light)
    });

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final breakpoint = Breakpoint.fromConstraints(constraints);

      if (breakpoint.columns <= 4) {
        //Handset
        return _createDesktopLayout();
      } else if (breakpoint.columns <= 8) {
        //Tablet
        return _createDesktopLayout();
      } else {
        //Desktop
        return _createDesktopLayout();
      }
    });
  }

  Widget _createDesktopLayout() {
    return FutureBuilder<bool>(
        future: _initialize,
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            //初期ロード中のロード画面
            return const MaterialApp(home: Center());
          } else if (dataSnapshot.error != null) {
            //初期ロードに失敗した場合に表示するエラー画面
            return MaterialApp(
                home: Center(child: Text(dataSnapshot.error.toString())));
          } else {
            //初期ロード完了
            return MultiProvider(
                providers: [
                  ChangeNotifierProvider.value(value: _counterViewModel),
                  ChangeNotifierProvider.value(value: _languageViewModel),
                  ChangeNotifierProvider.value(value: _themeViewModel),
                ],
                child: Builder(
                    builder: (context) => MaterialApp(
                          onGenerateTitle: (context) =>
                              AppLocalizations.of(context)!.appTitle,
                          locale: Provider.of<LanguageViewModel>(context)
                              .getLocale(),
                          localizationsDelegates:
                              AppLocalizations.localizationsDelegates,
                          supportedLocales: AppLocalizations.supportedLocales,
                          theme:
                              Provider.of<ThemeViewModel>(context).getTheme(),
                          home: const CounterScreen(),
                        )));
          }
        });
  }
}
