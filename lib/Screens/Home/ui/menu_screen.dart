// ignore_for_file: use_build_context_synchronously

import 'package:hrm_employee/GlobalComponents/button_global.dart';
import 'package:hrm_employee/GlobalComponents/purchase_model.dart';
import 'package:hrm_employee/Screens/Attendance%20Management/management_screen.dart';
import 'package:hrm_employee/Screens/Leave%20Management/leave_application.dart';
// ignore: depend_on_referenced_packages
import 'package:nb_utils/nb_utils.dart';
import 'package:hrm_employee/Screens/components/appbar/custom_appbar.dart';

import 'package:hrm_employee/Screens/components/others/custom_scaffold.dart';
import 'package:hrm_employee/constant.dart';

import 'package:flutter/material.dart';

import 'package:hrm_employee/Screens/Employee%20Directory/employee_directory_screen.dart';

import 'package:hrm_employee/Screens/Leave%20Management/leave_management_screen.dart';

import 'package:hrm_employee/Screens/Work%20Report/daily_work_report.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar.titleActions(title: "Apps"),
      body: Column(
        children: _gridMenu(context),
      ),
    );
  }

  List<Widget> _gridMenu(BuildContext context) {
    return [
      Row(
        children: [
          Expanded(
            child: Material(
              elevation: 2.0,
              child: GestureDetector(
                onTap: () async {
                  bool isValid = await PurchaseModel().isActiveBuyer();
                  if (isValid) {
                    const EmployeeManagement().launch(context);
                  } else {
                    showLicense(context: context);
                  }
                },
                child: Container(
                  width: context.width(),
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: Color(0xFFFD72AF),
                        width: 3.0,
                      ),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Image(
                          image: AssetImage('images/employeeattendace.png')),
                      Text(
                        'Employee',
                        style: kTextStyle.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Attendance',
                        style: kTextStyle.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Material(
              elevation: 2.0,
              child: GestureDetector(
                onTap: () {
                  const EmployeeDirectory().launch(context);
                },
                child: Container(
                  width: context.width(),
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: Color(0xFF7C69EE),
                        width: 3.0,
                      ),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Image(
                          image: AssetImage('images/employeedirectory.png')),
                      Text(
                        'Employee',
                        style: kTextStyle.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Directory',
                        style: kTextStyle.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 20.0,
      ),
      Row(
        children: [
          Expanded(
            child: Material(
              elevation: 2.0,
              child: GestureDetector(
                onTap: () {
                  const LeaveApplication().launch(context);
                },
                child: Container(
                  width: context.width(),
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: Color(0xFF4ACDF9),
                        width: 3.0,
                      ),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Image(image: AssetImage('images/leave.png')),
                      Text(
                        'Leave',
                        style: kTextStyle.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Application',
                        style: kTextStyle.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Material(
              elevation: 2.0,
              child: GestureDetector(
                onTap: () {
                  const DailyWorkReport().launch(context);
                },
                child: Container(
                  width: context.width(),
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: Color(0xFF02B984),
                        width: 3.0,
                      ),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Image(image: AssetImage('images/workreport.png')),
                      Text(
                        'Daily Work',
                        maxLines: 2,
                        style: kTextStyle.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Report',
                        style: kTextStyle.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ];
  }
}
