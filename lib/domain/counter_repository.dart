abstract class CounterRepository {
  Future<int> loadCounter();
  Future<void> saveCounter(int counter);
}