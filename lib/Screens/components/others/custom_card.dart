import 'package:flutter/material.dart';
import 'package:hrm_employee/utlis/measurement.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color? background;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final BoxBorder? border;
  const CustomCard({
    super.key,
    required this.child,
    this.background,
    this.boxShadow,
    this.padding,
    this.borderRadius,
    this.width = double.infinity,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(10),
      width: width,
      decoration: BoxDecoration(
        color: background ?? Colors.white,
        border: border,
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
