import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationsService {
  int i = 0;

  static final LocalNotificationsService _notificationService =
      LocalNotificationsService._internal();

  factory LocalNotificationsService() {
    return _notificationService;
  }

  LocalNotificationsService._internal();

  static const channelId = 'smartfoodinsight10';
  static const channelName = 'Smart Food Insight';

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initAsync() async {
    await _configureLocalTimeZone();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: null,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
  }

  final AndroidNotificationDetails _androidNotificationDetails =
      const AndroidNotificationDetails(
    channelId,
    channelName,
    channelDescription: 'Smart Food Insight',
    playSound: true,
    priority: Priority.max,
    importance: Importance.max,
  );

  Future<void> showNotificationAsync(String? title, String? body) async {
    await flutterLocalNotificationsPlugin.show(
      i++,
      title,
      body,
      NotificationDetails(android: _androidNotificationDetails),
    );
  }

  Future<void> showForegroundNotificationAsync(
      String? title, String? body) async {
    await flutterLocalNotificationsPlugin.show(
      i++,
      title,
      body,
      NotificationDetails(android: _androidNotificationDetails),
    );
  }

  Future<void> scheduleNotificationAsync(
      {String? title, String? body, required DateTime dateTime}) async {
    tz.TZDateTime tzDateTIME = _getTZDateTime(dateTime);

    await flutterLocalNotificationsPlugin.zonedSchedule(i++, title, body,
        tzDateTIME, NotificationDetails(android: _androidNotificationDetails),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  tz.TZDateTime _getTZDateTime(DateTime dateTime) {
    final currentDate = DateTime.now();
    final newdateTime = DateTime(dateTime.year, dateTime.month, dateTime.day,
        currentDate.hour, currentDate.minute, currentDate.second);

    final cCurrentDate = DateUtils.dateOnly(currentDate);

    tz.TZDateTime tzDateTIME;
    if (cCurrentDate.isAtSameMomentAs(dateTime)) {
      tzDateTIME = tz.TZDateTime.from(
          newdateTime.add(const Duration(seconds: 10)), tz.local);
    } else {
      tzDateTIME = tz.TZDateTime.from(newdateTime, tz.local);
    }
    return tzDateTIME;
  }

  Future<void> cancelNotificationAsync(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotificationsAsync() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<PermissionStatus> requestNotificationPermissionsAsync() {
    return Permission.notification.request();
  }
}
