import 'package:flutter/material.dart';
import 'package:hrm_employee/Screens/components/others/body_card.dart';
import 'package:hrm_employee/constant.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final AppBar? appBar;
  final Widget? floatingActionButton;
  const CustomScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      floatingActionButton: floatingActionButton,
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: BodyCard(child: body),
      ),
    );
  }
}
