import 'package:uuid/uuid.dart';

var uuid = const Uuid();

extension BoolParsing on String {
  bool ParseBool() {
    if (toLowerCase() == 'true') {
      return true;
    } else if (toLowerCase() == 'false') {
      return false;
    }
    throw '"$this" can not be parsed to boolean.';
  }
}

class Task {
  Task({required this.text, this.dateTime}) {
    if (dateTime == null) {
      notificationId = null;
    }
  }

  Task.full(
      {required this.text,
      required this.id,
      this.dateTime,
      this.isCompleted = false,
      this.notificationId});

  Task.fromMap(Map<String, dynamic> map)
      : this.full(
            id: map["id"]!,
            text: map["text"]!,
            isCompleted: map["isCompleted"]!.toString().ParseBool(),
            dateTime: DateTime.tryParse(map["time"]!),
            notificationId: int.tryParse(map["notificationId"]));

  String text;
  DateTime? dateTime;
  String id = uuid.v4();
  bool isCompleted = false;
  int? notificationId = GenerateNotificationId();

  static int GenerateNotificationId() =>
      (DateTime.now().millisecondsSinceEpoch - 0x80000000) % 0x7FFFFFFF;

  Map<String, String> ToMap() => {
        "text": text,
        "time": dateTime.toString(),
        "id": id,
        "isCompleted": isCompleted.toString(),
        "notificationId": notificationId.toString()
      };
}
