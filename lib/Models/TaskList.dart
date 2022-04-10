import 'package:event/event.dart';

import 'Task.dart';

class TaskList {
  Map<String, Task> _tasks = Map();
  bool _isDirty = true;
  List<Task> _listVeiw = List.empty();
  var ListChangedEvent = Event();

  void AddTask(String text, DateTime? time) {
    var task = Task(Text: text, Time: time);
    _tasks[task.Id] = task;
    _isDirty = true;
    ListChangedEvent.broadcast();
  }

  void Remove(String id) {
    _tasks.remove(id);
    _isDirty = true;
    ListChangedEvent.broadcast();
  }

  void CreateOrUpdate(String id, String text, DateTime? dateTime) {
    _isDirty = true;
    var task = Task.withId(Text: text, Id: id, Time: dateTime);
    _tasks[id] = task;
    ListChangedEvent.broadcast();
  }

  int Count() => _tasks.length;

  void GetElement(String id) => _tasks[id];

  List<Task> GetList() {
    if (_isDirty) {
      _isDirty = false;
      _listVeiw = _tasks.values.toList();
    }
    return _listVeiw;
  }
}
