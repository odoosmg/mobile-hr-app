import 'package:flutter/material.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/app_color.dart';
import 'package:hrm_employee/utlis/measurement.dart';

class MainBtn extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final bool isOk;
  final Function()? onPressed;

  // ignore: use_key_in_widget_constructors
  const MainBtn({
    super.key,
    required this.title,
    this.onPressed,
    this.isOk = true,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isOk ? onPressed : null,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        // decoration: buttonDecoration,
        decoration: BoxDecoration(
          /// if ok, opacity=1,
          color: AppColor.kMainColor.withOpacity(isOk ? 1 : 0.6),
          borderRadius: const BorderRadius.all(
            Radius.circular(Measurement.btnRadius),
          ),
        ),
        child: Center(
          child: Text(title,
              style: titleStyle ??
                  Theme.of(context).textTheme.whiteS20W700NoChange),
        ),
      ),
    );
  }
}
