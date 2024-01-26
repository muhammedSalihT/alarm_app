import 'dart:convert';
import 'dart:developer';

import 'package:alarm_app/screens/add_or_update_alarm/model/alarm_info.dart';
import 'package:alarm_app/screens/alarm_setting_screen/model/weather_model.dart';
import 'package:alarm_app/service/dio_api_service.dart';
import 'package:alarm_app/service/local_database_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class AlarmSettingProvider extends ChangeNotifier {
  Position? position;
  WeatherModel? watherModel;
  bool isLoading = false;
  List<AlarmModel> alarmList = [];
  bool isAlarmListEmpty = false;

  // for get saved alarms

  void getAlarmList() async {
    alarmList = await LocalDatabaseService.getAlarms();
    notifyListeners();
    log(alarmList.toString());
    if (alarmList.isEmpty) {
      isAlarmListEmpty = true;
    } else {
      isAlarmListEmpty = false;
    }
    notifyListeners();
  }

  // get user location
  getCurrentLocation() async {
    position = await determinePosition();
    if (position != null) {
      await getWheatherUpdate();
    }
  }

  //get weather details
  getWheatherUpdate() async {
    isLoading = true;
    notifyListeners();
    var data = {
      "locations": [
        {
          "q": "${position!.latitude},${position!.longitude}",
          "custom_id": "my-id-1"
        },
      ]
    };

    var d = jsonEncode(data);
    Response? response = await ApiService.apiMethodSetup(
        method: ApiMethod.post,
        url: "http://api.weatherapi.com/v1/current.json",
        data: d,
        queryParameters: {
          "key": "1f7e0ee92d264240ad8180930242301",
          "q": "bulk"
        });

    if (response != null) {
      var encode = jsonEncode(response.data["bulk"][0]);

      watherModel = weatherModelMapFromJson(encode);
      if (watherModel != null) {
        isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<Position> determinePosition() async {
    isLoading = true;
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
