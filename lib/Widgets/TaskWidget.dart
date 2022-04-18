import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Models/Task.dart';

class TaskWidget extends StatelessWidget {
  final Task taskInfo;

  const TaskWidget({Key? key, required this.taskInfo}) : super(key: key);

  String _DateTimeToString() =>
      DateFormat("yyyy-MM-dd").format(taskInfo.dateTime!) +
      " " +
      DateFormat.Hms().format(taskInfo.dateTime!);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(taskInfo.text,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20))),
          if (taskInfo.dateTime != null)
            Align(
                alignment: Alignment.bottomRight,
                child: Text(_DateTimeToString(),
                    style: TextStyle(
                        color: !DateTime.now().isAfter(taskInfo.dateTime!) ||
                                taskInfo.isCompleted
                            ? Colors.green
                            : Colors.red))),
        ],
      );
}
