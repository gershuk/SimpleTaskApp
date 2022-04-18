import 'package:flutter/material.dart';

import '../Models/Task.dart';
import '../Models/TaskContainer.dart';
import 'AddTaskWidget.dart';
import 'EditTaskWidget.dart';
import 'TaskWidget.dart';

class TaskListWidget extends StatefulWidget {
  final TaskContainer tasksList;
  final bool isEditable;
  final bool Function(Task)? filterFunction;

  const TaskListWidget(
      {Key? key,
      required this.tasksList,
      this.isEditable = false,
      this.filterFunction})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => TaskListWidgetState();
}

class TaskListWidgetState extends State<TaskListWidget> {
  @override
  Widget build(BuildContext context) {
    var list = widget.filterFunction != null
        ? widget.tasksList.GetTasksWhere(widget.filterFunction!)
        : widget.tasksList.GetAllTasks();
    return Scaffold(
      body: ListView.separated(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: TaskWidget(taskInfo: list[index])),
              Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Row(children: [
                    ElevatedButton(
                        onPressed: () => setState(
                            () => widget.tasksList.Remove(list[index].id)),
                        child: const Tab(icon: Icon(Icons.delete))),
                    if (widget.isEditable)
                      ElevatedButton(
                        onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditTaskWidget(
                                        task: widget.tasksList,
                                        id: list[index].id,
                                        text: list[index].text,
                                        dateTime:
                                            list[index].dateTime.toString())))
                            .whenComplete(() => setState(() {})),
                        child: const Tab(icon: Icon(Icons.edit)),
                      ),
                    if (widget.isEditable)
                      ElevatedButton(
                        onPressed: () {
                          widget.tasksList.CompleteTask(list[index].id);
                          setState(() {});
                        },
                        child: const Tab(icon: Icon(Icons.done_outlined)),
                      ),
                  ]))
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
      persistentFooterButtons: [
        if (widget.isEditable)
          FloatingActionButton(
            child: const Icon(Icons.add_circle_outlined),
            onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddTaskWidget(taskContainer: widget.tasksList)))
                .whenComplete(() => setState(() {})),
          ),
      ],
    );
  }
}
