// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:flutter_template/domain/counter_repository.dart';
import 'package:flutter_template/domain/increment_usecase.dart';
import '../domain/entity/click_count.dart';

class CounterViewModel extends ChangeNotifier {

  CounterViewModel(this._counterRepository);
  late ClickCount _counter;
  final CounterRepository _counterRepository;

  ClickCount get counter => _counter;

  Future<void> init() async {
    _counter = await _counterRepository.loadCounter();
    notifyListeners();
  }

  Future<void> increment() async {
    _counter = IncrementUseCase().call(_counter);
    await _counterRepository.saveCounter(_counter);
    notifyListeners();
  }
}
