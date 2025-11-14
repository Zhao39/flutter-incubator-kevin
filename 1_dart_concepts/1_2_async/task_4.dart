import 'dart:isolate';

void isolateEntry(List<dynamic> args) {
  final int start = args[0];
  final int end = args[1];
  final SendPort sendPort = args[2];

  int partialSum = 0;
  for (int i = start; i <= end; i++) {
    if (isPrime(i)) partialSum += i;
  }

  sendPort.send(partialSum);
}

bool isPrime(int n) {
  if (n < 2) return false;
  for (int i = 2; i * i <= n; i++) {
    if (n % i == 0) return false;
  }
  return true;
}

Future<void> main() async {
  const int N = 1_000_000; 
  const int isolateCount = 4;

  final int chunkSize = (N / isolateCount).ceil();
  final List<ReceivePort> ports = [];
  final List<Future> isolateFutures = [];
  int totalSum = 0;

  for (int i = 0; i < isolateCount; i++) {
    final start = i * chunkSize + 1;
    final end = (i == isolateCount - 1) ? N : (i + 1) * chunkSize;

    final receivePort = ReceivePort();
    ports.add(receivePort);

    isolateFutures.add(Isolate.spawn(isolateEntry, [start, end, receivePort.sendPort]));

    receivePort.listen((partialSum) {
      totalSum += partialSum;
      receivePort.close();
    });
  }

  await Future.wait(isolateFutures);

  await Future.delayed(const Duration(seconds: 1));

  print('✅ Sum of all primes up to $N is: $totalSum');
}
