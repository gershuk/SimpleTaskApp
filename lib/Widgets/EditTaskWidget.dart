import 'package:flutter/material.dart';

import '../Models/TaskList.dart';
import 'AbstractTaskInfoWidget.dart';

class EditTaskWidget extends AbstractTaskInfoWidget {
  String Id;

  EditTaskWidget(
      {required TaskList Task,
      required String this.Id,
      required String dateTime,
      required String text})
      : super(EditeableTaskList: Task, text: text, dateTime: dateTime);

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
      EditeableTaskList.CreateOrUpdate(Id, text, DateTime.tryParse(dateTime));
      Navigator.pop(context);
    }
  }
}
