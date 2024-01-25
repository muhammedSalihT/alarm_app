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

  // create a channel for android local notifiction
  static const AndroidNotificationChannel _androidChannel =
      AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    sound: RawResourceAndroidNotificationSound('slow_spring_board'),
    playSound: true,
    importance: Importance.max,
  );

  // initilaise local notification
  static Future<void> initLocalNotification() async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    tz.initializeTimeZones();
    await _localNoti.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) => onOpenMessage(),
    );

    //  handle in terminated state
    var initialNotification =
        await _localNoti.getNotificationAppLaunchDetails();
    if (initialNotification?.didNotificationLaunchApp == true) {
      onOpenMessage();
    }

    //init channel
    final platform = _localNoti.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  //handle notification open in app

  static Future<void> onOpenMessage() async {
    AppNavigation.pushAndRemoveUntil(
      context: AppNavigation.navigatorKey.currentState?.context,
      materialRoutePage: const AlarmSettingView(),
    );
  }

  static void scheduleAlarm({
    required AlarmModel alarmData,
  }) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _androidChannel.id,
      _androidChannel.name,
      channelDescription: _androidChannel.description,
      sound: const RawResourceAndroidNotificationSound('slow_spring_board'),
      priority: Priority.high,
      importance: Importance.high,
      playSound: true,
    );

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
        '',
        alarmData.label,
        tz.TZDateTime.from(alarmData.alarmSetTime, tz.local),
        platformChannelSpecifics,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
