import 'custom_datetime.dart';

void main() {
  final now = CustomDateTime.now();
  print('Now (µs since epoch): ${now.microsecondsSinceEpoch}');
  print('ISO: ${now.toIso8601String()}');

  final later = now.addMicroseconds(500);
  print('Later (µs since epoch): ${later.microsecondsSinceEpoch}');
}
