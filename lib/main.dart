// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:flutter_template/data/counter_local_data_source.dart';
import 'package:flutter_template/data/counter_repository_impl.dart';
import 'package:flutter_template/view/counter_screen.dart';
import 'package:flutter_template/viewmodel/app_language.dart';
import 'package:flutter_template/viewmodel/app_theme.dart';
import 'package:flutter_template/viewmodel/counter_viewmodel.dart';

void main() {
  runApp(const MyApp());
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
  final AppLanguage _appLanguage = AppLanguage();
  final AppTheme _appTheme = AppTheme();
  late Future<void> _initialize;

  @override
  void initState() {
    super.initState();
    _initialize = _initApp();
  }

  //Initialize App
  Future<void> _initApp() async {
    _prefs = await SharedPreferences.getInstance();
    final counterRepository =
        CounterRepositoryImpl(CounterLocalDataSource(_prefs));
    _counterViewModel = CounterViewModel(counterRepository);
    await _counterViewModel.init();

    await _appLanguage.loadLocale();
    await _appTheme.loadTheme();

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
      },
    );
  }

  Widget _createDesktopLayout() {
    return FutureBuilder<void>(
      future: _initialize,
      builder: (context, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          //初期ロード中のロード中画面
          return const MaterialApp(home: Scaffold(
              body: Center(),),);
        } else if (dataSnapshot.error != null) {
          //初期ロードに失敗した場合に表示するエラーの画面
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text(dataSnapshot.error.toString()),
              ),
            ),
          );
        } else {
          //初期ロード完了
          return MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: _counterViewModel),
              ChangeNotifierProvider.value(value: _appLanguage),
              ChangeNotifierProvider.value(value: _appTheme),
            ],
            child: Builder(
              builder: (context) => MaterialApp(
                onGenerateTitle: (context) =>
                    AppLocalizations.of(context)!.appTitle,
                locale: Provider.of<AppLanguage>(context).appLocale,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                theme: Provider.of<AppTheme>(context).theme,
                home: const CounterScreen(),
              ),
            ),
          );
        }
      },
    );
  }
}
