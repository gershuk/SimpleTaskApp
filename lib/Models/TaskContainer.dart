import 'package:event/event.dart';
import 'package:sqlite3/sqlite3.dart';

import 'Task.dart';

class TaskContainer {
  final Map<String, Task> _tasks = {};
  bool _isDirty = true;
  List<Task> _listView = List.empty();
  final listChangedEvent = Event();

  //TaskList()
  //{
  //final db = sqlite3.open("tasks.db", mode: OpenMode.readWriteCreate);
  //}

  void AddTask(String text, DateTime? time) {
    var task = Task(text: text, time: time);
    _tasks[task.id] = task;
    _isDirty = true;
    listChangedEvent.broadcast();
  }

  void Remove(String id) {
    _tasks.remove(id);
    _isDirty = true;
    listChangedEvent.broadcast();
  }

  void CreateOrUpdate(String id, String text, DateTime? dateTime) {
    _isDirty = true;
    var task = Task.withId(text: text, id: id, time: dateTime);
    _tasks[id] = task;
    listChangedEvent.broadcast();
  }

  void CompleteTask(String id) {
    _isDirty = true;
    _tasks[id]?.isCompleted = true;
    listChangedEvent.broadcast();
  }

  int Count() => _tasks.length;

  void GetElement(String id) => _tasks[id];

  List<Task> GetTasksWhere(bool Function(Task) test) =>
      _tasks.values.where(test).toList();

  List<Task> GetAllTasks() {
    if (_isDirty) {
      _isDirty = false;
      _listView = _tasks.values.toList();
    }
    return _listView;
  }
}
