import 'dart:async';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:alarm_app/screens/add_or_update_alarm/model/alarm_info.dart';
import 'package:alarm_app/screens/alarm_setting_screen/view/alarm_setting_view.dart';
import 'package:alarm_app/utils/app_navigation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  //create local noti instence
  static final _localNoti = FlutterLocalNotificationsPlugin();

  // initilaise local notification
  static Future<void> initLocalNotification() async {
    _localNoti
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('ic_launcher_forgro');
    var initializationSettingsIOS = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    tz.initializeTimeZones();
    await _localNoti.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) => onOpenMessage,
    );
  }

  //handle notification open in app

  static Future<void> onOpenMessage(
      NotificationResponse notificationResponse) async {
    AppNavigation.pushAndRemoveUntil(
      context: AppNavigation.navigatorKey.currentState?.context,
      materialRoutePage: const AlarmSettingView(),
    );
  }

  static void scheduleAlarm({
    required AlarmModel alarmData,
  }) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'channel id', 'channel name',
        channelDescription: 'channel description',
        sound: RawResourceAndroidNotificationSound("slow_spring_board"),
        playSound: true,
        importance: Importance.max,
        priority: Priority.high);

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails(
      // sound: 'a_long_cold_sting.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _localNoti.zonedSchedule(
        0,
        'Alarm',
        alarmData.label,
        tz.TZDateTime.from(alarmData.alarmSetTime, tz.local),
        platformChannelSpecifics,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime);
  }
}
