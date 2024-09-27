import 'package:flutter/material.dart';

class Xborder extends StatelessWidget {
  final double height;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  const Xborder({
    super.key,
    this.height = 0.8,
    this.color,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      margin: margin,
      color: color ?? Colors.grey.shade400,
      height: height,
    );
  }
}
