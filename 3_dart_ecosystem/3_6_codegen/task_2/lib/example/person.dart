part 'person.my.dart';

import 'package:task_2/task_2.dart';

@Serializable()
class Person {
  const Person({required this.name, required this.birthday});
  final String name;
  final DateTime birthday;

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);
}

