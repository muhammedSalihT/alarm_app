import 'package:alarm_app/constents/app_colors.dart';
import 'package:alarm_app/screens/help_and_support_view.dart';
import 'package:alarm_app/utils/app_navigation.dart';
import 'package:alarm_app/widgets/refracted_button_widget.dart';
import 'package:alarm_app/widgets/refracted_text_widget.dart';
import 'package:alarm_app/widgets/reracted_textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeleteAccountView extends StatefulWidget {
  const DeleteAccountView({super.key});

  @override
  State<DeleteAccountView> createState() => _DeleteAccountViewState();
}

class _DeleteAccountViewState extends State<DeleteAccountView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppNavigation.push(
          context: context, materialRoutePage: const ContactUsView()),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: const RefractedTextWidget(text: 'Delete Account'),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const RefractedTextWidget(
                        align: TextAlign.start,
                        maxLines: 200,
                        text:
                            'Lörem ipsum fädide krov åsk nätdeklarant mir. Tetravis. San sar teska pertotal. ',
                        textSize: 14,
                        textColor: AppColors.appGrey,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 10.w, top: 30.h, bottom: 40.h),
                        child: Column(
                          children: List.generate(
                            3,
                            (index) => Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 5.h),
                                    child: const Icon(
                                      Icons.circle,
                                      size: 10,
                                      color: AppColors.appGrey,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10.w),
                                      child: const RefractedTextWidget(
                                        align: TextAlign.start,
                                        maxLines: 100,
                                        text:
                                            'Kvasin växtmjölk lähäde sefäpp. Satonera antining pande kament.',
                                        isSubText: true,
                                        textColor: AppColors.appGrey,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const RefractedTextWidget(
                        text: 'Reason for leaving the app?',
                        isSubText: true,
                      ),
                      const RefractedTextFormFieldWidget(),
                      const RefractedTextWidget(
                        text: 'Description',
                        isSubText: true,
                      ),
                      const RefractedTextFormFieldWidget(),
                      const RefractedTextWidget(
                        text: 'Confirm your email id',
                        isSubText: true,
                      ),
                      const RefractedTextFormFieldWidget(),
                      const RefractedButtonWidget(
                        buttonWidth: double.infinity,
                        child: RefractedTextWidget(
                          text: 'Delete Account',
                          isSubText: true,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
