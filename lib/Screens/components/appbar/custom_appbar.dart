import 'package:flutter/material.dart';
import 'package:hrm_employee/Models/form/select_form_model.dart';
import 'package:hrm_employee/Screens/components/pages/home/select-company/ui/select_company.dart';
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

  static AppBar titleCompany(
      {required String title,
      required Function(List<int>, List<SelectFormModel>) onChanged}) {
    return titleActions(
        title: title, actions: [SelectCompany(onChanged: onChanged)]);
  }
}
