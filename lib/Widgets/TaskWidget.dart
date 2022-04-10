import 'package:flutter/material.dart';

import '../Models/Task.dart';

class TaskWidget extends StatelessWidget {
  Task TaskInfo;

  TaskWidget({required this.TaskInfo});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(TaskInfo.Text,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
          if (TaskInfo.Time != null)
            Align(
                alignment: Alignment.bottomRight,
                child: Text(TaskInfo.Time.toString(),
                    style: TextStyle(color: Colors.grey))),
        ],
      );
}
