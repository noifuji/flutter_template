import 'package:flutter_template/data/counter_local_data_source.dart';
import 'package:flutter_template/domain/counter_repository.dart';

import '../model/click_count.dart';

class CounterRepositoryImpl extends CounterRepository {
  final CounterLocalDataSource _counterLocalDataSource;

  CounterRepositoryImpl(this._counterLocalDataSource);

  @override
  Future<ClickCount> loadCounter(){
    return _counterLocalDataSource.loadCounter();
  }

  @override
  Future<void> saveCounter(ClickCount counter) async {
    _counterLocalDataSource.saveCounter(counter);
  }
}