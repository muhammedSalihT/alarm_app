import 'package:alarm_app/constents/app_colors.dart';
import 'package:flutter/material.dart';

class RefractedButtonWidget extends StatelessWidget {
  const RefractedButtonWidget(
      {Key? key,
      this.color,
      this.onPressed,
      this.child,
      this.radius,
      this.borderColor,
      this.buttonHeight,
      this.buttonWidth,
      this.padding,
      this.isCircle = false,
      this.splashColor,
      this.onLongPress})
      : super(key: key);

  final Color? color;
  final Function()? onPressed;
  final Widget? child;
  final double? radius;
  final Color? borderColor;
  final double? buttonHeight;
  final double? buttonWidth;
  final EdgeInsetsGeometry? padding;
  final bool? isCircle;
  final Color? splashColor;
  final Function()? onLongPress;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onLongPress: onLongPress,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      disabledColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: splashColor,
      focusElevation: 0,
      hoverElevation: 0,
      disabledElevation: 0,
      highlightElevation: 0,
      padding: padding ?? const EdgeInsets.all(10),
      shape: isCircle == true
          ? CircleBorder(
              side: BorderSide(color: borderColor ?? Colors.transparent))
          : RoundedRectangleBorder(
              side: BorderSide(
                color: borderColor ?? AppColors.appGrey,
              ),
              borderRadius: BorderRadius.circular(radius ?? 8)),
      color: color ?? AppColors.appBlack,
      elevation: 0,
      height: buttonHeight,
      minWidth: buttonWidth,
      onPressed: onPressed,
      child: child,
    );
  }
}
