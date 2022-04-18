import 'dart:io';

import 'package:dart_mongo_lite/dart_mongo_lite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_task_app/Models/TaskContainer.dart';

import 'Widgets/LoadingScreenWidget.dart';
import 'Widgets/MainPage.dart';

void main() async {
  runApp(const LoadingScreen());

  if (Platform.isAndroid) {
    var notificationRequest = await Permission.notification.request();
    if (notificationRequest.isDenied ||
        notificationRequest.isPermanentlyDenied ||
        notificationRequest.isRestricted) {
      SystemNavigator.pop();
      return;
    }

    var storageRequest = await Permission.storage.request();
    if (storageRequest.isDenied ||
        storageRequest.isPermanentlyDenied ||
        storageRequest.isRestricted) {
      SystemNavigator.pop();
      return;
    }
  }

  var appDocDirectory = await getApplicationDocumentsDirectory();
  var db = Database(appDocDirectory.path + '/task.db');
  var taskList = TaskContainer(db: db);
  runApp(MainPage(taskContainer: taskList));
}
