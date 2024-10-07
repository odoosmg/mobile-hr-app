import 'package:flutter/material.dart';
import 'package:hrm_employee/constant.dart';

class CustomAppBar {
  static AppBar titleActions({required String title, List<Widget>? actions}) {
    return AppBar(
      backgroundColor: kMainColor,
      // toolbarHeight: 80,
      elevation: 0.0,
      titleSpacing: 0.0,
      iconTheme: const IconThemeData(color: Colors.white),
      automaticallyImplyLeading: true,
      title: Text(
        title,
        maxLines: 2,
        style: kTextStyle.copyWith(
            color: Colors.white, fontWeight: FontWeight.bold),
      ),
      actions: actions,
    );
  }
}
