import 'package:flutter/material.dart';
import 'package:hrm_employee/utlis/app_color.dart';
import 'package:hrm_employee/utlis/measurement.dart';

class CusCardStatus extends StatelessWidget {
  final Widget child;
  final Color background;
  const CusCardStatus({
    super.key,
    required this.child,
    this.background = AppColor.saMain,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 4,
        bottom: 4,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(Measurement.cardRadius),
      ),
      child: child,
    );
  }
}
