class Chat {
  Chat(this.onRead);

  final void Function(int message) onRead;

  final List<int> messages = List.generate(30, (i) => i);

  DateTime? _lastReadTime;

  int? _pendingMessage;

  void read(int message) {
    final now = DateTime.now();

    if (_lastReadTime == null ||
        now.difference(_lastReadTime!) >= const Duration(seconds: 1)) {
      _lastReadTime = now;
      onRead(message);
    } else {
      _pendingMessage = message;

      final remaining =
          const Duration(seconds: 1) - now.difference(_lastReadTime!);

      Future.delayed(remaining, () {
        if (_pendingMessage != null) {
          _lastReadTime = DateTime.now();
          onRead(_pendingMessage!);
          _pendingMessage = null;
        }
      });
    }
  }
}

Future<void> main() async {
  final Chat chat = Chat((i) => print('Read until $i at ${DateTime.now()}'));

  chat.read(0);

  await Future.delayed(const Duration(milliseconds: 1000));

  chat.read(4);
  await Future.delayed(const Duration(milliseconds: 100));
  chat.read(10);
  await Future.delayed(const Duration(milliseconds: 100));
  chat.read(11);
  await Future.delayed(const Duration(milliseconds: 100));
  chat.read(12);
  await Future.delayed(const Duration(milliseconds: 100));
  chat.read(13);
  await Future.delayed(const Duration(milliseconds: 100));
  chat.read(14);
  await Future.delayed(const Duration(milliseconds: 100));

  chat.read(15);

  await Future.delayed(const Duration(milliseconds: 1000));

  chat.read(20);

  await Future.delayed(const Duration(milliseconds: 1000));

  chat.read(35);
  await Future.delayed(const Duration(milliseconds: 100));
  chat.read(36);
  await Future.delayed(const Duration(milliseconds: 500));
  chat.read(37);
  await Future.delayed(const Duration(milliseconds: 800));

  chat.read(40);
}
