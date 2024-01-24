import 'dart:developer';

import 'package:alarm_app/screens/add_or_update_alarm/model/alarm_info.dart';
import 'package:alarm_app/screens/alarm_setting_screen/view/alarm_setting_view.dart';
import 'package:alarm_app/utils/app_navigation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   DartPluginRegistrant.ensureInitialized();
//   if (!Hive.isAdapterRegistered(1)) {
//     Hive.registerAdapter(NotificationModelAdapter());
//   }

//   // THIS BELOW LINE CAUSE ERROR WHILE APP IS IN TERMINATED STATE
//   final path = (await getApplicationDocumentsDirectory()).path;

//   /// init hive
//   Hive.init(path);

//   if (Hive.isBoxOpen('notiList')) {
//     await Hive.box<List>('notiList').close();
//   }

//   final NotificationProvider notiPro = NotificationProvider();
//   // print('Background ');
//   //  IsolateNameServer.lookupPortByName('main_port')?.send(message);

//   notiPro.getNotifications();
//   notiPro.addMessages(currentMsg: message);
// }

class LocalNotificationService {
  // creates firbasemessage instence
  // final _firebaseMessage = FirebaseMessaging.instance;

  //create local noti instence
  static final _localNoti = FlutterLocalNotificationsPlugin();

  // create a channel for android local notifiction
  static const AndroidNotificationChannel _androidChannel =
      AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  // initilaise local notification

  static Future<void> initLocalNotification() async {
    const ios = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('ic_launcher_playstore');
    const settings = InitializationSettings(android: android, iOS: ios);
    _localNoti
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    await _localNoti.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) {
        log('onDidnoti');
        onOpenMessage(payload);
      },
    );

    final platform = _localNoti.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  //initialise notification
  Future<void> initialiseNotification() async {
    // call to handle
    // await onHandleBackOrTerminte();
    initLocalNotification();
  }

  //handle notification open in app

  static Future<void> onOpenMessage(NotificationResponse? message) async {
    if (message == null) return;
    AppNavigation.push(
      context: AppNavigation.navigatorKey.currentState?.context,
      materialRoutePage: const AlarmSettingView(),
    );
  }

  void scheduleAlarm(
      DateTime scheduledNotificationDateTime, AlarmModel alarmInfo,
      {required bool isRepeating}) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      channelDescription: 'Channel for Alarm notification',
      icon: 'codex_logo',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
    );

    // var iOSPlatformChannelSpecifics = IOSNotificationDetails(
    //   sound: 'a_long_cold_sting.wav',
    //   presentAlert: true,
    //   presentBadge: true,
    //   presentSound: true,
    // );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      // iOS: iOSPlatformChannelSpecifics,
    );
  }

  //handle message in background or terminte

  // Future<void> onHandleBackOrTerminte() async {
  //   _localNoti.show(
  //       notification.hashCode,
  //       notification?.title,
  //       notification?.body,
  //       NotificationDetails(
  //         android: AndroidNotificationDetails(
  //             _androidChannel.id, _androidChannel.name,
  //             channelDescription: _androidChannel.description,
  //             icon: 'ic_launcher_foreground'),
  //       ),
  //       payload: jsonEncode(message.toMap()));
  // }
}
