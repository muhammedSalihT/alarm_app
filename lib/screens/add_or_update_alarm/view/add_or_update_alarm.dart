import 'package:alarm_app/constents/app_colors.dart';
import 'package:alarm_app/screens/add_or_update_alarm/model/alarm_info.dart';
import 'package:alarm_app/screens/add_or_update_alarm/view_model/add_or_update_provider.dart';
import 'package:alarm_app/utils/app_navigation.dart';
import 'package:alarm_app/utils/util_widgets.dart';
import 'package:alarm_app/widgets/refracted_appbar_widget.dart';
import 'package:alarm_app/widgets/refracted_button_widget.dart';
import 'package:alarm_app/widgets/refracted_text_widget.dart';
import 'package:alarm_app/widgets/reracted_textformfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddOrUpdateAlarmView extends StatefulWidget {
  const AddOrUpdateAlarmView(
      {super.key, this.isFromEdit = true, this.alarmData});

  final bool isFromEdit;
  final AlarmModel? alarmData;

  @override
  State<AddOrUpdateAlarmView> createState() => _AddOrUpdateAlarmViewState();
}

class _AddOrUpdateAlarmViewState extends State<AddOrUpdateAlarmView> {
  @override
  void initState() {
    final addOrUpdateProvider =
        Provider.of<AddOrUpdateProvider>(context, listen: false);
    addOrUpdateProvider.initView(
        text: widget.alarmData?.label, time: widget.alarmData?.alarmSetTime);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addOrUpdateProvider = Provider.of<AddOrUpdateProvider>(context);
    return Scaffold(
      appBar: RefractedAppBar(
        centerTitle: true,
        titleText: '${widget.isFromEdit ? 'Edit' : 'Add'} Alarm',
        leading: IconButton(
          onPressed: () => AppNavigation.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.appWhite,
          ),
        ),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: Column(
            children: [
              UtilWidgets.refractedContainer(
                borColor: AppColors.appGrey,
                alignment: Alignment.center,
                color: AppColors.appBlack,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const RefractedTextWidget(
                      text: 'Label',
                      textSize: 16,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.h),
                      child: RefractedTextFormFieldWidget(
                        initialValue: addOrUpdateProvider.userAddingText,
                        onChanged: (value) =>
                            addOrUpdateProvider.onAdding(text: value),
                        hinttext: 'Add your label here',
                        hintColor: AppColors.appGrey,
                        borderRadius: 5,
                        fontSize: 15,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 8.h),
                        edgeInsect: EdgeInsets.zero,
                        fillColor: AppColors.appBlack,
                      ),
                    ),
                  ],
                ),
              ),
              const CustomDividerWidget(),
              SizedBox(
                height: 200.h,
                child: CupertinoTheme(
                  data: const CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle:
                          TextStyle(color: AppColors.appBlue),
                    ),
                  ),
                  child: CupertinoDatePicker(
                    initialDateTime: addOrUpdateProvider.userSetDateTime,
                    mode: CupertinoDatePickerMode.time,
                    onDateTimeChanged: (value) {
                      addOrUpdateProvider.onChangeDateTime(dateTime: value);
                    },
                  ),
                ),
              ),
              const CustomDividerWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.isFromEdit ? 2 : 1,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: RefractedButtonWidget(
                      color: index == 0 ? AppColors.appBlue : AppColors.appGrey,
                      padding: EdgeInsets.symmetric(vertical: 3.h),
                      buttonWidth: 120.w,
                      onPressed: () {
                        if (index == 0) {
                          var alarmModel = AlarmModel(
                              id: widget.alarmData?.id,
                              alarmSetTime: addOrUpdateProvider.userSetDateTime,
                              label: addOrUpdateProvider.userAddingText);
                          addOrUpdateProvider.onAddOrUpdateAlarmData(
                              alarmModel: alarmModel,
                              context: context,
                              isFromEdit: widget.isFromEdit);
                        } else {
                          addOrUpdateProvider.onDeleteAlarm(
                              id: widget.alarmData!.id!, context: context);
                        }
                      },
                      child: RefractedTextWidget(
                        text: index == 0 ? 'Done' : 'Delete',
                      ),
                    ),
                  ),
                ),
              ),
              ConstrainedBox(
                constraints:
                    const BoxConstraints(maxHeight: 100, minHeight: 50),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: index.isEven ? 100 : 50,
                        width: 1,
                        color: AppColors.appGrey,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDividerWidget extends StatelessWidget {
  const CustomDividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 50.h,
      color: AppColors.appGrey,
      thickness: .1,
    );
  }
}
