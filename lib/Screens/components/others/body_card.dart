import 'package:flutter/material.dart';

class BodyCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  const BodyCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      child: Container(
        padding: padding ?? const EdgeInsets.only(left: 20, right: 20),
        width: double.infinity,
        color: Colors.white,
        child: child,
      ),
    );
  }
}
