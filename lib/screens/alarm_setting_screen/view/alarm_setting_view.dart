import 'package:alarm_app/constents/app_colors.dart';
import 'package:alarm_app/utils/util_widgets.dart';
import 'package:alarm_app/widgets/refracted_appbar_widget.dart';
import 'package:alarm_app/widgets/refracted_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlarmSettingView extends StatefulWidget {
  const AlarmSettingView({super.key});

  @override
  State<AlarmSettingView> createState() => _AlarmSettingViewState();
}

class _AlarmSettingViewState extends State<AlarmSettingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RefractedAppBar(),
      body: ListView.builder(
        itemBuilder: (context, index) => ListTile(
            onTap: () {},
            contentPadding:
                EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
            leading: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const RefractedTextWidget(text: '5:30'),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w),
                      child: const RefractedTextWidget(
                        text: 'AM',
                        isSubText: true,
                        textColor: AppColors.appGrey,
                      ),
                    ),
                  ],
                ),
                const RefractedTextWidget(
                  text: 'Alarm in 22 hours 14 minutes',
                  textSize: 11,
                  isSubText: true,
                  textColor: AppColors.appGrey,
                ),
              ],
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.appBlue,
            ),
            shape: UtilWidgets.utilBorderWidget()),
        itemCount: 10,
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 50.h),
        child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: AppColors.appGrey.withOpacity(.1),
                      blurRadius: 0,
                      spreadRadius: 0,
                      blurStyle: BlurStyle.inner),
                ],
                color: AppColors.appBlack,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(color: AppColors.appGrey)),
            child: const Icon(
              Icons.add,
              color: AppColors.appBlue,
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
