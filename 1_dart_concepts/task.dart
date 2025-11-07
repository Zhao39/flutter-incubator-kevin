import 'dart:async';

class MemoryDatabase<K, V> {
  final Map<K, V> _storage = {};
  final StreamController<MapEntry<K, V>> _changesController =
      StreamController.broadcast();

  Stream<MapEntry<K, V>> get changes => _changesController.stream;

  Future<void> set(K key, V value) async {
    await Future.delayed(Duration(milliseconds: 300));
    _storage[key] = value;
    _changesController.add(MapEntry(key, value));
  }

  Future<V?> get(K key) async {
    await Future.delayed(Duration(milliseconds: 200));
    return _storage[key];
  }

  Future<void> close() async => _changesController.close();
}

void main() async {
  final db = MemoryDatabase<String, int>();

  db.changes.listen((entry) {
    print('DB changed: ${entry.key} → ${entry.value}');
  });

  await db.set('apples', 10);
  await db.set('bananas', 20);

  final apples = await db.get('apples');
  print('Apples count: $apples');

  await db.close();
}
