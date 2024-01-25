// Project imports:
import 'entity/click_count.dart';

class IncrementUseCase {
  ClickCount call(ClickCount current) {
    return current.copyWith(
        value: current.value + 1, updateDate: DateTime.now(),);
  }
}
