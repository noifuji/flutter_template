import 'package:flutter_template/domain/usecase.dart';

import '../model/click_count.dart';

class IncrementUseCase extends UseCase<ClickCount> {

  final ClickCount _current;

  IncrementUseCase(this._current);

  @override
  ClickCount call() {
    return ClickCount(_current.value + 1, DateTime.now());
  }


}