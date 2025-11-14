abstract class CustomDateTime {
  int get microsecondsSinceEpoch;

  const CustomDateTime();

  String toIso8601String();

  CustomDateTime addMicroseconds(int microseconds);

  static CustomDateTime now() =>
      throw UnimplementedError('Use platform-specific implementation.');
}
