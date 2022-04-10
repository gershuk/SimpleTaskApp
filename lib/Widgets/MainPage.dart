import 'package:flutter/material.dart';

import '../Models/Task.dart';
import '../Models/TaskContainer.dart';
import 'TaskListWidget.dart';

class MainPage extends StatelessWidget {
  static TaskContainer taskContainer = TaskContainer();
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.work_rounded)),
                  Tab(icon: Icon(Icons.done_outline_outlined)),
                ],
              ),
              title: const Center(child: Text('Simple Task App')),
            ),
            body: TabBarView(
              children: [
                TaskListWidget(
                    tasksList: taskContainer,
                    isEditable: true,
                    filterFunction: (Task t) => !t.isCompleted),
                TaskListWidget(
                    tasksList: taskContainer,
                    isEditable: false,
                    filterFunction: (Task t) => t.isCompleted)
              ],
            )),
      ),
    );
  }
}
