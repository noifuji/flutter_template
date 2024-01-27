// Project imports:
import 'entity/click_count.dart';

abstract class CounterRepository {
  Future<ClickCount> loadCounter();
  Future<void> saveCounter(ClickCount counter);
}
