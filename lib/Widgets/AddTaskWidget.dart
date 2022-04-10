import 'package:flutter/material.dart';

import '../Models/TaskContainer.dart';
import 'AbstractTaskInfoWidget.dart';

class AddTaskWidget extends AbstractTaskInfoWidget {
  AddTaskWidget({Key? key, required TaskContainer taskContainer})
      : super(key: key, taskContainer: taskContainer);

  @override
  void ButtonAction(context) {
    taskContainer.AddTask(text, DateTime.tryParse(dateTime));
    Navigator.pop(context);
  }
}
