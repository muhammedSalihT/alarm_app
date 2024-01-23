import 'package:alarm_app/widgets/refracted_appbar_widget.dart';
import 'package:flutter/material.dart';

class AlarmSettingView extends StatefulWidget {
  const AlarmSettingView({super.key});

  @override
  State<AlarmSettingView> createState() => _AlarmSettingViewState();
}

class _AlarmSettingViewState extends State<AlarmSettingView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: RefractedAppBar(),
      body: Column(
        children: [],
      ),
    );
  }
}
