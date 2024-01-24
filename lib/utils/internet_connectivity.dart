import 'dart:developer';
import 'dart:io';

import 'package:alarm_app/utils/snackbar_widget.dart';
import 'package:flutter/material.dart';

class InternetConnectivity extends ChangeNotifier {
  static bool? isInternetAvilable;
  Future<bool> checking() async {
    try {
      final result = await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isInternetAvilable = true;
        notifyListeners();
        return true;
      } else {
        SnackBarWidget.getSnackBar(showText: "No Internet");
        isInternetAvilable = false;
        notifyListeners();

        return false;
      }
    } on SocketException catch (_) {
      SnackBarWidget.getSnackBar(showText: 'No Internet');
      isInternetAvilable = false;
      notifyListeners();
      log('hi$isInternetAvilable');
      return false;
    }
  }
}
