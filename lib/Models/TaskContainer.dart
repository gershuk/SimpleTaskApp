import 'dart:io';

import 'package:event/event.dart';
import 'package:dart_mongo_lite/dart_mongo_lite.dart';
import 'package:simple_task_app/Models/NotificationManager.dart';
import 'Task.dart';

class TaskContainer {
  var _isDirty = true;
  List<Task> _listView = List.empty();
  final listChangedEvent = Event();
  Database db;
  final _taskTableName = "tasks";
  final _nm = Platform.isAndroid ? NotificationManager() : null;

  TaskContainer({required this.db});

  void _AddNotification(Task task) => _nm?.PushZonedScheduleNotification(
      task.notificationId!, "Alert", task.text, task.dateTime!);

  bool _TryCancelNotification(String taskId) {
    var notificationId = GetTasksWith({"id": taskId})[0].notificationId;
    if (notificationId != null) _nm?.CancelNotification(notificationId);
    return notificationId != null;
  }

  void AddTask(String text, DateTime? dateTime) {
    var task = Task(text: text, dateTime: dateTime);
    db[_taskTableName].insert(task.ToMap());
    _isDirty = true;
    listChangedEvent.broadcast();
    if (dateTime != null) _AddNotification(task);
  }

  void Remove(String id) {
    _TryCancelNotification(id);
    db[_taskTableName].delete({"id": id});
    _isDirty = true;
    listChangedEvent.broadcast();
  }

  void Update(String id, String text, DateTime? dateTime) {
    _TryCancelNotification(id);
    _isDirty = true;
    var task = Task.full(
        text: text,
        id: id,
        dateTime: dateTime,
        notificationId: Task.GenerateNotificationId());
    db[_taskTableName].modify({"id": id}, task.ToMap());
    if (dateTime != null) _AddNotification(task);
    listChangedEvent.broadcast();
  }

  void CompleteTask(String id) {
    _TryCancelNotification(id);
    _isDirty = true;
    db[_taskTableName].modify({"id": id}, {"isCompleted": "true"});
    listChangedEvent.broadcast();
  }

  int Count() => db[_taskTableName].count();

  Task? GetElement(String id) =>
      db[_taskTableName].findOneAs((m) => Task.fromMap(m), filter: {"id": id});

  List<Task> GetTasksWhere(bool Function(Task) test) =>
      GetAllTasks().where(test).toList();

  List<Task> GetTasksWith(Map<String, dynamic> map) =>
      db[_taskTableName].findAs((m) => Task.fromMap(m), filter: map);

  List<Task> GetAllTasks() {
    if (_isDirty) {
      _isDirty = false;
      _listView = db[_taskTableName].findAs((m) => Task.fromMap(m));
    }
    return _listView;
  }
}
