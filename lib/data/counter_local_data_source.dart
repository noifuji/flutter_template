// Package imports:

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:flutter_template/data/click_count_entity.dart';
import 'package:flutter_template/domain/entity/click_count.dart';

class CounterLocalDataSource {
  CounterLocalDataSource(this._sharedPreferences);
  final SharedPreferences _sharedPreferences;

  Future<ClickCount> loadCounter() {
    final value = _sharedPreferences.getInt('counter');
    final date = _sharedPreferences.getString('updateDate');

    if (value == null || date == null) {
      return Future.value(
        ClickCount(
          value: 0,
          updateDate: DateTime.now(),
        ),
      );
    }

    return Future.value(dataToModel(ClickCountEntity(value, date)));
  }

  Future<void> saveCounter(ClickCount counter) async {
    final data = modelToData(counter);
    await _sharedPreferences.setInt('counter', data.value);
    await _sharedPreferences.setString('updateDate', data.updateDate);
  }
}
