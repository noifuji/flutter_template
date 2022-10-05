import 'package:flutter_template/data/click_count_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/click_count.dart';
import 'click_count_mapper.dart';

class CounterLocalDataSource {
  final SharedPreferences _sharedPreferences;

  CounterLocalDataSource(this._sharedPreferences);

  Future<ClickCount> loadCounter() {
    int? value = _sharedPreferences.getInt("counter");
    String? date = _sharedPreferences.getString("updateDate");
    return Future.value(ClickCountMapper.dataToModel(ClickCountEntity(value?? 0, date)));
  }

  Future<void> saveCounter(ClickCount counter) async {
    ClickCountEntity data = ClickCountMapper.modelToData(counter);
    _sharedPreferences.setInt("counter", data.value);
    if(data.updateDate!=null) {
      _sharedPreferences.setString("updateDate", data.updateDate!);
    }

  }
}