import 'package:flutter/material.dart';
import 'package:hrm_employee/Screens/components/others/body_card.dart';
import 'package:hrm_employee/constant.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final AppBar? appBar;
  final Widget? floatingActionButton;
  final EdgeInsetsGeometry? bodyPadding;
  final bool resizeToAvoidBottomInset;
  const CustomScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.bodyPadding,
    this.resizeToAvoidBottomInset = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: kMainColor,
      floatingActionButton: floatingActionButton,
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: BodyCard(padding: bodyPadding, child: body),
      ),
    );
  }
}
