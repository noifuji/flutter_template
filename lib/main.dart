import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_template/data/counter_local_data_source.dart';
import 'package:flutter_template/data/counter_repository_impl.dart';
import 'package:flutter_template/view/counter_screen.dart';
import 'package:flutter_template/viewmodel/app_ui_settings.dart';
import 'package:flutter_template/viewmodel/counter_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

//ignore: must_be_immutable
class MyApp extends StatelessWidget {
  late SharedPreferences _prefs;
  late CounterViewModel _counterViewModel;
  late AppUISettings _appUISettings;

  MyApp({Key? key}) : super(key: key);

  //Initialize App
  Future<bool> _initApp() async {
    _prefs = await SharedPreferences.getInstance();
    CounterRepositoryImpl counterRepository = CounterRepositoryImpl(
        CounterLocalDataSource(_prefs));
    _counterViewModel = CounterViewModel(counterRepository);
    await _counterViewModel.init();

    _appUISettings = AppUISettings(_prefs);

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final breakpoint = Breakpoint.fromConstraints(constraints);

          if(breakpoint.columns <= 4) {
            //Handset
            return _createDesktopLayout();
          } else if(breakpoint.columns <= 8) {
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
        future: _initApp(),
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
                ],
                child: Builder(
                    builder: (context) =>
                        MaterialApp(
                          onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
                          locale: _appUISettings.locale,
                          localizationsDelegates: AppLocalizations.localizationsDelegates,
                          supportedLocales: AppLocalizations.supportedLocales,
                          theme: _appUISettings.theme,
                          home: const CounterScreen(),
                        )));
          }
        });
  }
}