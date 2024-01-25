import 'dart:developer';

import 'package:alarm_app/constents/app_colors.dart';
import 'package:alarm_app/constents/app_text.dart';
import 'package:alarm_app/screens/add_or_update_alarm/view/add_or_update_alarm.dart';
import 'package:alarm_app/screens/alarm_setting_screen/view_model/alarm_setting_provider.dart';
import 'package:alarm_app/service/local_database_service.dart';
import 'package:alarm_app/utils/app_navigation.dart';
import 'package:alarm_app/utils/util_widgets.dart';
import 'package:alarm_app/widgets/refracted_appbar_widget.dart';
import 'package:alarm_app/widgets/refracted_button_widget.dart';
import 'package:alarm_app/widgets/refracted_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AlarmSettingView extends StatefulWidget {
  const AlarmSettingView({super.key});

  @override
  State<AlarmSettingView> createState() => _AlarmSettingViewState();
}

class _AlarmSettingViewState extends State<AlarmSettingView> {
  @override
  void initState() {
    final alarmProvider =
        Provider.of<AlarmSettingProvider>(context, listen: false);
    alarmProvider.getCurrentLocation();
    LocalDatabaseService.initDatabase().then((value) {
      alarmProvider.getAlarmList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RefractedAppBar(actions: [
        Consumer<AlarmSettingProvider>(builder: (context, alarmProvider, _) {
          return Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: alarmProvider.isLoading
                ? UtilWidgets.refractedCupertinoLoadingWidget()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: 18.sp,
                            color: AppColors.appGrey,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 3.w),
                            child: RefractedTextWidget(
                              text: alarmProvider
                                  .watherModel!.query.location.name,
                              isSubText: true,
                              textColor: AppColors.appGrey,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          UtilWidgets.refractedNetworkImageWidget(
                              height: 20.h,
                              width: 20.h,
                              image:
                                  'https:${alarmProvider.watherModel!.query.current.condition.icon}'),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RefractedTextWidget(
                                  text: alarmProvider
                                      .watherModel!.query.current.tempC
                                      .replaceAll(AppText.regex, ''),
                                ),
                                const RefractedTextWidget(
                                  text: '\u2103',
                                  isSubText: true,
                                ),
                              ],
                            ),
                          ),
                          RefractedTextWidget(
                            text: alarmProvider
                                .watherModel!.query.current.condition.text,
                            textColor: AppColors.appGrey,
                            isSubText: true,
                          ),
                        ],
                      ),
                    ],
                  ),
          );
        })
      ]),
      body: Consumer<AlarmSettingProvider>(
          builder: (context, alarmSettProvider, _) {
        if (alarmSettProvider.isAlarmListEmpty) {
          return Padding(
              padding: EdgeInsets.only(bottom: .2.sh),
              child: const Center(
                child: RefractedTextWidget(
                  text: 'Add your alarm',
                  textColor: AppColors.appGrey,
                ),
              ));
        }
        if (alarmSettProvider.alarmList.isEmpty) {
          return Padding(
            padding: EdgeInsets.only(bottom: .2.sh),
            child: UtilWidgets.refractedCupertinoLoadingWidget(radius: 30.r),
          );
        }
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final alarmData =
                alarmSettProvider.alarmList.reversed.elementAt(index);
            log(alarmData.label.toString());
            return ListTile(
              onTap: () => AppNavigation.push(
                context: context,
                newRoute: AppNavigation.createCustomRoute(
                  transitionType: TransitionType.slideRight,
                  page: AddOrUpdateAlarmView(
                    alarmData: alarmData,
                  ),
                ),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RefractedTextWidget(
                          text: DateFormat('h:mm')
                              .format(alarmData.alarmSetTime)),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w),
                        child: RefractedTextWidget(
                          text: DateFormat('a').format(alarmData.alarmSetTime),
                          isSubText: true,
                          textColor: AppColors.appGrey,
                        ),
                      ),
                    ],
                  ),
                  if (alarmData.label != '')
                    RefractedTextWidget(
                      text: alarmData.label,
                      textSize: 11,
                      isSubText: true,
                      textColor: AppColors.appBlue,
                    ),
                ],
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.appBlue,
              ),
              shape: UtilWidgets.utilBorderWidget(),
            );
          },
          itemCount: alarmSettProvider.alarmList.length,
        );
      }),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 50.h),
        child: RefractedButtonWidget(
            onPressed: () => AppNavigation.push(
                context: context,
                newRoute: AppNavigation.createCustomRoute(
                    transitionType: TransitionType.slideBottom,
                    page: const AddOrUpdateAlarmView(
                      isFromEdit: false,
                    ))),
            buttonHeight: 60.h,
            borderColor: AppColors.appGrey,
            isCircle: true,
            child: Icon(
              Icons.add,
              color: AppColors.appBlue,
              size: 30.sp,
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
