import 'package:flutter/material.dart';

class CustomCircularProgressindicator extends StatelessWidget {
  final double strokeWidth;
  final Color? color;
  const CustomCircularProgressindicator({
    super.key,
    this.strokeWidth = 4.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: color ?? Colors.white,
      strokeWidth: strokeWidth,
    );
  }
}
