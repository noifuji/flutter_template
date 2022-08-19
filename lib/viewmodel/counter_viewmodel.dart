

import 'package:flutter/material.dart';
import 'package:flutter_template/domain/counter_repository.dart';
import 'package:flutter_template/domain/increment_usecase.dart';

class CounterViewModel extends ChangeNotifier {
  int _counter = 0;
  final CounterRepository _counterRepository;

  int get counter => _counter;

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