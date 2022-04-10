import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import '../Models/TaskList.dart';


final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  minimumSize: Size(200, 60),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
);

abstract class AbstractTaskInfoWidget extends StatelessWidget {
  TaskList EditeableTaskList;
  String dateTime;
  String text = "";

  AbstractTaskInfoWidget(
      {Key? key,
      required this.EditeableTaskList,
      this.text = "",
      this.dateTime = ""})
      : super(key: key);

  void ButtonAction(context);

  @override
  Widget build(BuildContext context) {
    var textController = new TextEditingController();
    textController.text = text;

    var descriptionText = TextField(
      controller: textController,
      onChanged: (s) => text = s,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.drive_file_rename_outline),
        hintText: 'Task description',
      ),
    );

    var notificationTime = DateTimePicker(
      initialValue: dateTime,
      type: DateTimePickerType.dateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      onChanged: (s) => dateTime = s,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.calendar_today_sharp),
        hintText: 'Notification date | time',
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Simple Task App')),
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(16.0), child: descriptionText),
              Padding(padding: EdgeInsets.all(16.0), child: notificationTime),
              ElevatedButton(
                style: raisedButtonStyle,
                child: Text("Complete"),
                onPressed: () => ButtonAction(context),
              )
            ],
          )),
    );
  }
}
