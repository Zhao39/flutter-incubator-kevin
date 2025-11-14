import 'dart:async';
import 'dart:math';

class Server {
  StreamController<int>? _controller;
  Timer? _timer;

  Future<void> init() async {
    final Random random = Random();

    while (true) {
      _controller = StreamController<int>();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _controller?.add(timer.tick);
      });

      await Future.delayed(
        Duration(milliseconds: (1000 + (5000 * random.nextDouble())).round()),
      );

      _controller?.addError(DisconnectedException());
      _controller?.close();
      _controller = null;

      _timer?.cancel();
      _timer = null;

      await Future.delayed(
        Duration(milliseconds: (1000 + (5000 * random.nextDouble())).round()),
      );
    }
  }

  Future<Stream<int>> connect() async {
    if (_controller != null) {
      return _controller!.stream;
    } else {
      throw DisconnectedException();
    }
  }
}

class DisconnectedException implements Exception {}

class Client {
  Future<void> connect(Server server) async {
    int attempt = 0;

    while (true) {
      try {
        print('🔌 Trying to connect (attempt #${attempt + 1})...');
        final stream = await server.connect();

        print('✅ Connected successfully!\n');

        await for (final value in stream) {
          print('📩 Received: $value');
        }
      } on DisconnectedException {
        final delay = min(pow(2, attempt), 32).toInt();
        print('⚠️ Disconnected. Retrying in ${delay}s...\n');

        await Future.delayed(Duration(seconds: delay));
        attempt++;
      } catch (e) {
        print('💥 Unexpected error: $e');
        await Future.delayed(const Duration(seconds: 2));
      }
    }
  }
}

Future<void> main() async {
  final server = Server();
  server.init();
  await Client().connect(server);
}
