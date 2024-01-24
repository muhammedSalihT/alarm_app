import 'package:alarm_app/constents/app_colors.dart';
import 'package:alarm_app/utils/util_widgets.dart';
import 'package:alarm_app/widgets/refracted_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RefractedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RefractedAppBar({
    Key? key,
    this.autoLeading,
    this.centerTitle,
    this.fontSize,
    this.backgroundColor,
    this.elevation,
    this.title,
    this.actions,
    this.leading,
    this.titleText,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(60.h);
  final bool? autoLeading;
  final bool? centerTitle;
  final double? fontSize;
  final Color? backgroundColor;
  final double? elevation;
  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final String? titleText;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: preferredSize.height,
      shape: UtilWidgets.utilBorderWidget(),
      title: RefractedTextWidget(
        text: titleText ?? 'Alarm',
      ),
      actions: actions ??
          [
            Padding(
              padding: EdgeInsets.only(right: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        size: 18.sp,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 3.w),
                        child: const RefractedTextWidget(
                          text: 'Kozhikode',
                          isSubText: true,
                          textColor: AppColors.appGrey,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.sunny,
                        size: 18.sp,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RefractedTextWidget(
                              text: '32',
                            ),
                            RefractedTextWidget(
                              text: '\u2103',
                              isSubText: true,
                            ),
                          ],
                        ),
                      ),
                      const RefractedTextWidget(
                        text: 'Sunny',
                        textColor: AppColors.appGrey,
                        isSubText: true,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
    );
  }
}
