import 'package:flutter_template/data/counter_local_data_source.dart';
import 'package:flutter_template/domain/counter_repository.dart';

class CounterRepositoryImpl extends CounterRepository {
  final CounterLocalDataSource _counterLocalDataSource;

  CounterRepositoryImpl(this._counterLocalDataSource);

  @override
  Future<int> loadCounter(){
    return _counterLocalDataSource.loadCounter();
  }

  @override
  Future<void> saveCounter(int counter) async {
    _counterLocalDataSource.saveCounter(counter);
  }
}