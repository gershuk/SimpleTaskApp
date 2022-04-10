import 'package:flutter/material.dart';

import '../Models/TaskContainer.dart';
import 'AbstractTaskInfoWidget.dart';

class EditTaskWidget extends AbstractTaskInfoWidget {
  String id;

  EditTaskWidget(
      {Key? key,
      required TaskContainer task,
      required String this.id,
      required String dateTime,
      required String text})
      : super(key: key, taskContainer: task, text: text, dateTime: dateTime);

  @override
  void ButtonAction(context) {
    taskContainer.CreateOrUpdate(id, text, DateTime.tryParse(dateTime));
    Navigator.pop(context);
  }
}
