import 'package:flutter/material.dart';
import 'package:hrm_employee/Models/form/select_form_model.dart';
import 'package:hrm_employee/Screens/components/pages/home/select-company/ui/select_company.dart';
import 'package:hrm_employee/constant.dart';
import 'package:hrm_employee/utlis/app_color.dart';

class CustomAppBar {
  static AppBar titleActions({
    required String title,
    List<Widget>? actions,
    Color? backgroundColor,
    TextStyle? titleTextStyle,
    IconThemeData? iconThemeData,
  }) {
    return AppBar(
      backgroundColor: backgroundColor ?? kMainColor,
      // toolbarHeight: 80,
      elevation: 0.0,
      titleSpacing: 0.0,
      iconTheme: iconThemeData ?? const IconThemeData(color: Colors.white),
      automaticallyImplyLeading: true,
      title: Text(
        title,
        maxLines: 2,
        style: titleTextStyle ??
            kTextStyle.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold),
      ),
      actions: actions,
    );
  }

  static AppBar titleCompany(
      {required String title,
      Function(List<int>, List<SelectFormModel>)? onChanged}) {
    return titleActions(
        title: title, actions: [SelectCompany(onChanged: onChanged)]);
  }

  static AppBar saTitleAction({
    required String title,
    List<Widget>? actions,
  }) {
    return titleActions(
      title: title,
      actions: actions,
      backgroundColor: Colors.grey.shade300,
      iconThemeData: const IconThemeData(color: Colors.black),
      titleTextStyle:
          kTextStyle.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
    );
  }
}
