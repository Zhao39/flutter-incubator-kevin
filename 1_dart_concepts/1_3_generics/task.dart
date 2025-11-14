void main() {
  print(maxElement<int>([1, 5, 3, 9, 2]));
  print(maxElement<double>([3.2, 5.5, 1.1, 4.8]));
  print(maxElement<String>(['apple', 'banana', 'pear']));
}

T? maxElement<T extends Comparable>(List<T> items) {
  if (items.isEmpty) return null;

  T max = items.first;
  for (var item in items) {
    if (item.compareTo(max) > 0) {
      max = item;
    }
  }
  return max;
}

