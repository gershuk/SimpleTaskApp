import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationManager {
  NotificationManager() {
    tz.initializeTimeZones();
    platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic');
  InitializationSettings initializationSettings = InitializationSettings();

  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
          '94bc12c3-73ad-4215-8cb8-00754e20082b', 'SimpleTaskAppChannel',
          channelDescription: 'Tasks notifications channel',
          importance: Importance.max,
          priority: Priority.max,
          ticker: 'ticker',
          icon: 'ic');

  NotificationDetails platformChannelSpecifics = NotificationDetails();

  Future<void> PushNotification(String title, String body) async {
    await flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics);
  }

  Future<void> PushZonedScheduleNotification(
          int id, String title, String body, DateTime dateTime) async =>
      await flutterLocalNotificationsPlugin.zonedSchedule(id, title, body,
          tz.TZDateTime.from(dateTime, tz.local), platformChannelSpecifics,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);

  void CancelNotification(int id) => flutterLocalNotificationsPlugin.cancel(id);
}
