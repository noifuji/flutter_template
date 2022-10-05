
import 'package:flutter/material.dart';
import 'package:flutter_template/domain/counter_repository.dart';
import 'package:flutter_template/domain/increment_usecase.dart';

import '../model/click_count.dart';

class CounterViewModel extends ChangeNotifier {
  late ClickCount _counter;
  final CounterRepository _counterRepository;

  ClickCount get counter => _counter;

  CounterViewModel(this._counterRepository);

  Future<void> init() async {
    _counter = await _counterRepository.loadCounter();
    notifyListeners();
  }

  Future<void> increment() async {
    _counter = IncrementUseCase(_counter).call();
    await _counterRepository.saveCounter(_counter);
    notifyListeners();
  }
}