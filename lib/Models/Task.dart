import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class Task {
  Task({required this.text, this.time});

  Task.withId(
      {required this.text,
      required this.id,
      this.time,
      this.isCompleted = false});

  String text;
  DateTime? time;
  String id = uuid.v4();
  bool isCompleted = false;
}
