import 'package:flutter/material.dart';

import '../Models/TaskList.dart';
import 'AddTaskWidget.dart';
import 'EditTaskWidget.dart';
import 'TaskWidget.dart';

class TaskListWidget extends StatefulWidget {
  TaskList TasksList;
  bool IsEditable;

  TaskListWidget({required this.TasksList, this.IsEditable = false});

  @override
  State<StatefulWidget> createState() => TaskListWidgetState();
}

class TaskListWidgetState extends State<TaskListWidget> {
  @override
  Widget build(BuildContext context) => Scaffold(
      body: ListView.separated(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        itemCount: this.widget.TasksList.Count(),
        itemBuilder: (context, index) {
          var list = this.widget.TasksList.GetList();
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: TaskWidget(TaskInfo: list[index])),
              Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Row(children: [
                    ElevatedButton(
                        onPressed: () => setState(
                            () => this.widget.TasksList.Remove(list[index].Id)),
                        child: Tab(icon: Icon(Icons.delete))),
                    if (this.widget.IsEditable)
                      ElevatedButton(
                        onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditTaskWidget(
                                        Task: this.widget.TasksList,
                                        Id: list[index].Id,
                                        text: list[index].Text,
                                        dateTime: list[index].Time.toString())))
                            .whenComplete(() => setState(() {})),
                        child: Tab(icon: Icon(Icons.edit)),
                      ),
                    if (this.widget.IsEditable)
                      ElevatedButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditTaskWidget(
                                    Task: this.widget.TasksList,
                                    Id: list[index].Id,
                                    text: list[index].Text,
                                    dateTime: list[index].Time.toString())))
                            .whenComplete(() => setState(() {})),
                        child: Tab(icon: Icon(Icons.done_outlined)),
                      ),
                  ]))
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
      persistentFooterButtons: [
        if (this.widget.IsEditable)
          FloatingActionButton(
            child: const Icon(Icons.add_circle_outlined),
            onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddTaskWidget(Task: this.widget.TasksList)))
                .whenComplete(() => setState(() {})),
          ),
      ],
    );
}
