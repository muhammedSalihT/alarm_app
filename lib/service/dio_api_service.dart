import 'dart:developer';
import 'dart:io';

import 'package:alarm_app/utils/internet_connectivity.dart';
import 'package:alarm_app/utils/snackbar_widget.dart';
import 'package:dio/dio.dart';

enum ApiMethod {
  get,
  post,
  delete,
  update,
}

class ApiService {
  static Map errorResponse = {};
  static Dio dio = Dio();

  ///api method set up

  static Future<Response<dynamic>?> apiMethodSetup(
      {required ApiMethod method,
      required String url,
      var data,
      Function()? onPressed,
      bool isErrorShowing = true,
      bool isSetToken = true,
      isExceptionChecking = true,
      var queryParameters,
      Function(int, int)? onSendProgress,
      Function(int, int)? onRecieveProgress,
      Options? options}) async {
    await InternetConnectivity().checking();
    try {
      Response? response;
      switch (method) {
        case ApiMethod.get:
          if (data != null) {
            response = await dio.get(
              url,
              queryParameters: data,
              options: options ?? Options(),
            );
          } else {
            response = await dio.get(url,
                options: options ?? Options(),
                onReceiveProgress: onRecieveProgress);
          }
          break;
        case ApiMethod.post:
          response = await dio.post(url,
              data: data,
              queryParameters: queryParameters,
              onSendProgress: onSendProgress,
              onReceiveProgress: onRecieveProgress);
          break;
        case ApiMethod.delete:
          response = await dio.delete(url,
              data: data, queryParameters: queryParameters);
          break;
        case ApiMethod.update:
          response = await dio.put(url,
              data: data,
              queryParameters: queryParameters,
              onSendProgress: onSendProgress,
              onReceiveProgress: onRecieveProgress);
          break;
      }
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        errorResponse["status"] = "401";
        errorResponse["message"] = "Authorization error";
        print(errorResponse);
      } else if (e.response?.statusCode == 404) {
        return e.response;
      } else if (e.response?.statusCode == 500) {
        SnackBarWidget.getSnackBar(showText: 'Somthing went erong');
      } else if (e.type == DioExceptionType.receiveTimeout) {
      } else if (e.type == DioExceptionType.connectionTimeout) {
      } else if (e.error is SocketException) {
        errorResponse["status"] = "101";
        errorResponse["message"] = "internet error";
        if (errorResponse["status"] == "101") {
          log("responce ilness");
        }
        print(errorResponse);
      } else {
        // SnackBarWidget.getSnackBar(showText: TextConst.errorText);
        print(e.toString());
      }
    }
    return null;
  }
}
