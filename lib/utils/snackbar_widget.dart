import 'package:alarm_app/constents/app_colors.dart';
import 'package:alarm_app/utils/app_navigation.dart';
import 'package:alarm_app/widgets/refracted_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SnackBarWidget {
  static getSnackBar(
      {String? showText, int? milliseconds, context, Widget? customContent}) {
    ScaffoldMessenger.of(context ?? AppNavigation.navigatorKey.currentContext)
        .hideCurrentSnackBar();
    ScaffoldMessenger.of(context ?? AppNavigation.navigatorKey.currentContext)
        .showSnackBar(
      SnackBar(
        // margin: EdgeInsets.fromLTRB(10.w, 0, 10.w, 80.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        dismissDirection: DismissDirection.horizontal,
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.appBlue,
        duration: Duration(milliseconds: milliseconds ?? 1500),
        padding: EdgeInsets.zero,
        content: customContent ??
            SizedBox(
              height: 40.h,
              child: Center(
                child: RefractedTextWidget(
                  text: showText ?? '',
                  isSubText: true,
                  textWeight: FontWeight.bold,
                  textColor: AppColors.appWhite,
                ),
              ),
            ),
      ),
    );
  }
}
