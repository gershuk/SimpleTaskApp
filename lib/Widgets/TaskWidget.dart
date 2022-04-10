import 'package:flutter/material.dart';

import '../Models/Task.dart';

class TaskWidget extends StatelessWidget {
  final Task taskInfo;

  const TaskWidget({Key? key, required this.taskInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(taskInfo.text,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20))),
          if (taskInfo.time != null)
            Align(
                alignment: Alignment.bottomRight,
                child: Text(taskInfo.time.toString(),
                    style: const TextStyle(color: Colors.grey))),
        ],
      );
}
