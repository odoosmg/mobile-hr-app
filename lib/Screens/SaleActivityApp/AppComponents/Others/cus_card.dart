import 'package:flutter/material.dart';
import 'package:hrm_employee/utlis/measurement.dart';

class CusCard extends StatelessWidget {
  final Widget child;
  final Color? background;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  const CusCard({
    super.key,
    required this.child,
    this.background,
    this.boxShadow,
    this.padding,
    this.borderRadius,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          const EdgeInsets.only(
            left: Measurement.screenPadding,
            right: Measurement.screenPadding,
            top: 10,
            bottom: 10,
          ),
      width: width,
      decoration: BoxDecoration(
        color: background ?? Colors.white,
        borderRadius:
            borderRadius ?? BorderRadius.circular(Measurement.cardRadius),
        boxShadow: boxShadow ??
            [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 7,

                /// changes position of shadow
                /// first paramerter of offset is left-right
                /// second parameter is top to down
                offset: const Offset(0, 2),
              ),
              //you can set more BoxShadow() here
            ],
      ),
      child: child,
    );
  }
}
