import 'package:flutter_template/domain/usecase.dart';

class IncrementUseCase extends UseCase<int> {

  final int _value;

  IncrementUseCase(this._value);

  @override
  int call() {
    return _value + 1;
  }


}