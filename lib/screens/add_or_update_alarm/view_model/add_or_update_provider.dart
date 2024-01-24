import 'dart:developer';

import 'package:alarm_app/screens/add_or_update_alarm/model/alarm_info.dart';
import 'package:alarm_app/screens/alarm_setting_screen/view_model/alarm_setting_provider.dart';
import 'package:alarm_app/service/local_database_service.dart';
import 'package:alarm_app/utils/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddOrUpdateProvider extends ChangeNotifier {
  String userAddingText = '';
  DateTime userSetDateTime = DateTime.now();

  void initView({required String? text, required DateTime? time}) {
    userAddingText = text ?? '';
    userSetDateTime = time ?? DateTime.now();
  }

  void onAdding({required String text}) {
    userAddingText = text;
    notifyListeners();
  }

  void onChangeDateTime({required DateTime dateTime}) {
    userSetDateTime = dateTime;
    notifyListeners();
  }

  void onDeleteAlarm({required int id, context}) async {
    await LocalDatabaseService.delete(id);
    final alarmSettProvider =
        Provider.of<AlarmSettingProvider>(context, listen: false);
    alarmSettProvider.getAlarmList();
    AppNavigation.pop(context);
  }

  void onAddOrUpdateAlarmData(
      {required AlarmModel alarmModel, required bool isFromEdit, context}) {
    log(alarmModel.alarmSetTime.toString());
    log(alarmModel.label.toString());
    if (isFromEdit) {
      LocalDatabaseService.update(alarmModel);
    } else {
      LocalDatabaseService.addAlarm(alarmModel: alarmModel);
    }
    final alarmSettProvider =
        Provider.of<AlarmSettingProvider>(context, listen: false);
    alarmSettProvider.getAlarmList();

    AppNavigation.pop(context);
  }
}
