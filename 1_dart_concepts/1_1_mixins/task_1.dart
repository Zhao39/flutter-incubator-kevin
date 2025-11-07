void main() {
  final now = DateTime.now();
  print(now.toFormattedString());
}

extension DateTimeFormatter on DateTime {
  String toFormattedString() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final year = year.toString();
    final month = twoDigits(this.month);
    final day = twoDigits(this.day);
    final hour = twoDigits(this.hour);
    final minute = twoDigits(this.minute);
    final second = twoDigits(this.second);

    return '$year.$month.$day $hour:$minute:$second';
  }
}
