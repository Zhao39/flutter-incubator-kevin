import 'custom_datetime_base.dart';

class CustomDateTimeWeb implements CustomDateTime {
  @override
  final int microsecondsSinceEpoch;

  const CustomDateTimeWeb(this.microsecondsSinceEpoch);

  factory CustomDateTimeWeb.now() {
    final now = DateTime.now();
    return CustomDateTimeWeb(now.microsecondsSinceEpoch);
  }

  @override
  String toIso8601String() =>
      DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch)
          .toIso8601String();

  @override
  CustomDateTimeWeb addMicroseconds(int microseconds) {
    return CustomDateTimeWeb(microsecondsSinceEpoch + microseconds);
  }
}

typedef CustomDateTime = CustomDateTimeWeb;
