import 'package:alarm_app/constents/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UtilWidgets {
  static Widget refractedNetworkImageWidget({
    required String image,
    double? height,
    double? width,
  }) {
    return SizedBox(
      height: height?.h ?? 40.h,
      width: width?.h ?? 40.h,
      child: CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) {
          return const Center(
            child: Icon(
              Icons.sunny,
              color: AppColors.appGrey,
            ),
          );
        },
      ),
    );
  }

  static Container refractedCupertinoLoadingWidget(
      {double? width, double? height, double? radius, Color? color}) {
    return Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        child: CupertinoActivityIndicator(
          radius: radius?.r ?? 10.r,
          color: color ?? AppColors.appBlue,
        ));
  }

  static Widget refractedContainer(
      {required Widget child,
      Color? color,
      Color? borColor,
      Color? shadowColor,
      AlignmentGeometry? alignment,
      double? height,
      double? radius,
      void Function()? onTap,
      EdgeInsetsGeometry? padding,
      double? width}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.zero,
        height: height,
        width: width,
        alignment: alignment,
        padding: padding ?? const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: color ?? AppColors.appWhite,
            borderRadius: BorderRadius.circular(radius?.r ?? 15.r),
            border: Border.all(color: borColor ?? Colors.transparent)),
        child: child,
      ),
    );
  }

  static Border utilBorderWidget() {
    return const Border(
        bottom: BorderSide(color: AppColors.appGrey, width: .1));
  }
}
