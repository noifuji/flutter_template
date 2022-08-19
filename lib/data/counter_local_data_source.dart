import 'package:shared_preferences/shared_preferences.dart';

class CounterLocalDataSource {
  final SharedPreferences _sharedPreferences;

  CounterLocalDataSource(this._sharedPreferences);

  Future<int> loadCounter() {
    int? value = _sharedPreferences.getInt("counter");

    return Future.value(value?? 0);
  }

  Future<void> saveCounter(int counter) async {
    _sharedPreferences.setInt("counter", counter);
  }
}