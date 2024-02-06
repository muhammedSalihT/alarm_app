import 'package:alarm_app/constents/app_colors.dart';
import 'package:alarm_app/screens/delete_account_view.dart';
import 'package:alarm_app/screens/register_complaint_view.dart';
import 'package:alarm_app/utils/app_navigation.dart';
import 'package:alarm_app/utils/util_widgets.dart';
import 'package:alarm_app/widgets/refracted_button_widget.dart';
import 'package:alarm_app/widgets/refracted_text_widget.dart';
import 'package:alarm_app/widgets/reracted_textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ruler_scale_picker/ruler_scale_picker.dart';

class RegisterComplaintView extends StatefulWidget {
  const RegisterComplaintView({super.key});

  @override
  State<RegisterComplaintView> createState() => _RegisterComplaintViewState();
}

class _RegisterComplaintViewState extends State<RegisterComplaintView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppNavigation.push(
          context: context, materialRoutePage: const DeleteAccountView()),
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
                  text: 'Register a complaint',
                  isSubText: true,
                  textSize: 18,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const RefractedTextFormFieldWidget(),
                    const RefractedTextFormFieldWidget(),
                    const RefractedTextFormFieldWidget(),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: RefractedButtonWidget(
                        buttonWidth: double.infinity,
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                              margin: EdgeInsets.only(top: 200.h),
                              child: const CustomScaleUi(),
                            ),
                          );
                        },
                        child: const RefractedTextWidget(text: 'Submit'),
                      ),
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

  List<Divider> rulerPin(int count) {
    return List.generate(count, (i) {
      return const Divider(
        height: 6.299,
        thickness: 1,
      );
    }).toList();
  }
}

class CustomScaleUi extends StatelessWidget {
  const CustomScaleUi({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const NumericRulerScalePicker(
      options: RulerScalePickerOptions(
        majorIndicatorInterval: 2,
        indicatorExtend: 20,
      ),
    );
  }
}
