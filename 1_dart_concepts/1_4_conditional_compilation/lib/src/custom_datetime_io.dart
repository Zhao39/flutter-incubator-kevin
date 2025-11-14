import 'custom_datetime_base.dart';
import 'dart:core';

class CustomDateTimeIO implements CustomDateTime {
  @override
  final int microsecondsSinceEpoch;

  const CustomDateTimeIO(this.microsecondsSinceEpoch);

  factory CustomDateTimeIO.now() {
    final now = DateTime.now();
    return CustomDateTimeIO(now.microsecondsSinceEpoch);
  }

  @override
  String toIso8601String() =>
      DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch)
          .toIso8601String();

  @override
  CustomDateTimeIO addMicroseconds(int microseconds) {
    return CustomDateTimeIO(microsecondsSinceEpoch + microseconds);
  }
}

typedef CustomDateTime = CustomDateTimeIO;
