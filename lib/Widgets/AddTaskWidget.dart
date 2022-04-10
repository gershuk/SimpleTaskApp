import 'package:flutter/material.dart';

import '../Models/TaskList.dart';
import 'AbstractTaskInfoWidget.dart';

class AddTaskWidget extends AbstractTaskInfoWidget {
  AddTaskWidget({required TaskList Task}) : super(EditeableTaskList: Task);

  @override
  void ButtonAction(context) {
    if (text == null || text.isEmpty) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Wrong input'),
          content: const Text('Text should not be empty'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      EditeableTaskList.AddTask(text, DateTime.tryParse(dateTime));
      Navigator.pop(context);
    }
  }
}
