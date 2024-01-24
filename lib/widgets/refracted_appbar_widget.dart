import 'package:alarm_app/utils/util_widgets.dart';
import 'package:alarm_app/widgets/refracted_text_widget.dart';
import 'package:flutter/material.dart';

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
    this.height = 60,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);
  final bool? autoLeading;
  final bool? centerTitle;
  final double? fontSize;
  final Color? backgroundColor;
  final double? elevation;
  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final String? titleText;
  final double height;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: preferredSize.height,
      shape: UtilWidgets.utilBorderWidget(),
      leading: leading,
      centerTitle: centerTitle,
      title: RefractedTextWidget(
        text: titleText ?? 'Alarm',
      ),
      actions: actions,
    );
  }
}
