import 'package:alarm_app/constents/app_colors.dart';
import 'package:alarm_app/screens/register_complaint_view.dart';
import 'package:alarm_app/utils/app_navigation.dart';
import 'package:alarm_app/utils/util_widgets.dart';
import 'package:alarm_app/widgets/refracted_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({super.key});

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppNavigation.push(
          context: context, materialRoutePage: const RegisterComplaintView()),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: const RefractedTextWidget(text: 'Help & Support'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                child: const RefractedTextWidget(
                  text: 'Contact Us',
                  isSubText: true,
                  textSize: 18,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UtilWidgets.refractedContainer(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 18.h),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const RefractedTextWidget(
                            text: 'ABC Company',
                            textColor: AppColors.appBlack,
                            textSize: 18,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.h),
                            child: const RefractedTextWidget(
                                align: TextAlign.start,
                                maxLines: 5,
                                isSubText: true,
                                textColor: AppColors.appBlack,
                                text:
                                    '#414, Palm Trees,\nCross road, International City,\nDubai. 500002'),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 25.h),
                      child: UtilWidgets.refractedContainer(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 15.h),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                                3,
                                (index) => Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.h),
                                      child: Row(
                                        children: [
                                          Icon(
                                            index == 0
                                                ? Icons.phone
                                                : index == 1
                                                    ? Icons.facebook
                                                    : Icons.mail,
                                            color: index == 0
                                                ? AppColors.appBlue
                                                : index == 1
                                                    ? Colors.green
                                                    : Colors.yellow,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 20.w),
                                            child: RefractedTextWidget(
                                              text: index == 0
                                                  ? '+971 23456789'
                                                  : index == 1
                                                      ? '+971 23456789'
                                                      : 'abccompany@gmail.com',
                                              textColor: AppColors.appBlack,
                                              isSubText: true,
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                          )),
                    )
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
