// Project imports:
import 'package:flutter_template/data/counter_local_data_source.dart';
import 'package:flutter_template/domain/counter_repository.dart';
import '../domain/entity/click_count.dart';

class CounterRepositoryImpl extends CounterRepository {
  CounterRepositoryImpl(this._counterLocalDataSource);
  final CounterLocalDataSource _counterLocalDataSource;

  @override
  Future<ClickCount> loadCounter() {
    return _counterLocalDataSource.loadCounter();
  }

  @override
  Future<void> saveCounter(ClickCount counter) async {
    await _counterLocalDataSource.saveCounter(counter);
  }
}
