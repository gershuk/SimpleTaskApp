import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import '../Models/TaskContainer.dart';

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  minimumSize: const Size(200, 60),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
);

abstract class AbstractTaskInfoWidget extends StatelessWidget {
  final TaskContainer taskContainer;
  String dateTime;
  String text;

  AbstractTaskInfoWidget(
      {Key? key,
      required this.taskContainer,
      this.text = "",
      this.dateTime = ""})
      : super(key: key);

  void ButtonAction(context);

  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();
    textController.text = text;

    var descriptionText = TextField(
      controller: textController,
      onChanged: (s) => text = s,
      decoration: const InputDecoration(
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
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.calendar_today_sharp),
        hintText: 'Notification date | time',
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Simple Task App')),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(16.0), child: descriptionText),
              Padding(
                  padding: const EdgeInsets.all(16.0), child: notificationTime),
              ElevatedButton(
                  style: raisedButtonStyle,
                  child: const Text("Complete"),
                  onPressed: () {
                    if (text == null || text.isEmpty) {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Wrong input'),
                          content:
                              const Text('Description should not be empty'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      if (dateTime != null &&
                          dateTime.isNotEmpty &&
                          !DateTime.parse(dateTime).isAfter(DateTime.now())) {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Wrong input'),
                            content: const Text(
                                'Notification time should be set after current time'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        ButtonAction(context);
                      }
                    }
                  })
            ],
          )),
    );
  }
}
