import 'package:alarm_app/constents/app_colors.dart';
import 'package:alarm_app/screens/add_or_update_alarm/view_model/add_or_update_provider.dart';
import 'package:alarm_app/screens/alarm_setting_screen/view/alarm_setting_view.dart';
import 'package:alarm_app/screens/alarm_setting_screen/view_model/alarm_setting_provider.dart';
import 'package:alarm_app/service/local_notification_service.dart';
import 'package:alarm_app/utils/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
  await LocalNotificationService.initLocalNotification();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (context, child) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AlarmSettingProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => AddOrUpdateProvider(),
          )
        ],
        child: MaterialApp(
          navigatorKey: AppNavigation.navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.appBlack,
            ),
            scaffoldBackgroundColor: AppColors.appBlack,
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.appBlue),
            useMaterial3: true,
          ),
          home: const AlarmSettingView(),
        ),
      );
    });
  }
}
