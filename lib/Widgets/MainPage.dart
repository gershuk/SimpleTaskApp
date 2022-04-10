import 'package:flutter/material.dart';

import '../Models/TaskList.dart';
import 'TaskListWidget.dart';

class MainPage extends StatelessWidget {
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
              title: Center(child: const Text('Simple Task App')),
            ),
            body: TabBarView(
              children: [
                TaskListWidget(TasksList: TaskList(), IsEditable: true),
                TaskListWidget(TasksList: TaskList())
              ],
            )),
      ),
    );
  }
}
