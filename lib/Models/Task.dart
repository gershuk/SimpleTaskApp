import 'package:uuid/uuid.dart';

var uuid = Uuid();

class Task {
  Task({required this.Text, this.Time});

  Task.withId({required this.Text, required this.Id, this.Time});

  String Text;
  DateTime? Time;
  String Id = uuid.v4();
  bool IsCompleted = false;
}
