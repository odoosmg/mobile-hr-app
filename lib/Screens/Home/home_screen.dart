// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/auth/session.dart';
import 'package:hrm_employee/Screens/Authentication/profile_screen.dart';
import 'package:hrm_employee/Screens/Authentication/sign_in.dart';
import 'package:hrm_employee/Screens/Chat/chat_list.dart';
import 'package:hrm_employee/Screens/Employee%20Directory/employee_directory_screen.dart';
import 'package:hrm_employee/Screens/Leave%20Management/leave_management_screen.dart';
import 'package:hrm_employee/Screens/Loan/loan_list.dart';
import 'package:hrm_employee/Screens/Notice%20Board/notice_list.dart';
import 'package:hrm_employee/Screens/Notification/notification_screen.dart';
import 'package:hrm_employee/Screens/Outwork%20Submission/outwork_list.dart';
import 'package:hrm_employee/Screens/Salary%20Management/salary_statement_list.dart';
import 'package:hrm_employee/Screens/Work%20Report/daily_work_report.dart';
import 'package:hrm_employee/Screens/components/pages/home/in_out_card.dart';
import 'package:hrm_employee/Screens/components/pages/home_drawer.dart';
import 'package:hrm_employee/Services/app_services.dart';
import 'package:hrm_employee/Services/database_service.dart';

import 'package:hrm_employee/utlis/app_color.dart';
import 'package:hrm_employee/utlis/measurement.dart';
import 'package:hrm_employee/utlis/measurement_widget_extension.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../../GlobalComponents/button_global.dart';
import '../../GlobalComponents/purchase_model.dart';
import '../../constant.dart';
import '../Attendance Management/management_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Session? session;

  @override
  void initState() {
    /// from local
    session = AppServices.instance<DatabaseService>().getSession;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: ListTile(
          contentPadding: EdgeInsets.zero,

          /// profile photo
          leading: CircleAvatar(
            radius: 20.0,
            backgroundImage:
                MemoryImage(base64Decode(session?.myProfile?.image ?? "")),
          ),

          /// name
          title: Text(
            'Hi, ${session?.myProfile?.name}',
            style: kTextStyle.copyWith(color: Colors.white, fontSize: 12.0),
          ),

          /// Company
          subtitle: Text(
            '${session?.myProfile?.company}',
            style: kTextStyle.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      drawer: const HomeDrawer(),
      /*
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              height: context.height() / 2.5,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0)),
                color: kMainColor,
              ),
              child: Column(
                children: [
                  Container(
                    height: context.height() / 4,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0)),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10.0,
                          ),
                          const CircleAvatar(
                            radius: 60.0,
                            backgroundColor: kMainColor,
                            backgroundImage: AssetImage(
                              'images/emp1.png',
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Sahidul Islam',
                            style: kTextStyle.copyWith(
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Employee',
                            style: kTextStyle.copyWith(color: kGreyTextColor),
                          ),
                        ],
                      ).onTap(() {
                        // const ProfileScreen().launch(context);
                      }),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                left: 15.0,
                                right: 15.0,
                                top: 10.0,
                                bottom: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80.0),
                              border: Border.all(color: Colors.white),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.white.withOpacity(0.6),
                                  Colors.white.withOpacity(0.0),
                                ],
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  '22',
                                  style: kTextStyle.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'days',
                                  style:
                                      kTextStyle.copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            'Present',
                            style: kTextStyle.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                left: 15.0,
                                right: 15.0,
                                top: 10.0,
                                bottom: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80.0),
                              border: Border.all(color: Colors.white),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.white.withOpacity(0.6),
                                  Colors.white.withOpacity(0.0),
                                ],
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  '3',
                                  style: kTextStyle.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'days',
                                  style:
                                      kTextStyle.copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            'Late',
                            style: kTextStyle.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                left: 15.0,
                                right: 15.0,
                                top: 10.0,
                                bottom: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80.0),
                              border: Border.all(color: Colors.white),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.white.withOpacity(0.6),
                                  Colors.white.withOpacity(0.0),
                                ],
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  '5',
                                  style: kTextStyle.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'days',
                                  style:
                                      kTextStyle.copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            'Absent',
                            style: kTextStyle.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () => const ProfileScreen().launch(context),
              title: Text(
                'Employee Profile',
                style: kTextStyle.copyWith(color: kTitleColor),
              ),
              leading: const Icon(
                FeatherIcons.user,
                color: kMainColor,
              ),
            ),
            ListTile(
              onTap: () => const ChatScreen().launch(context),
              title: Text(
                'Live Video Calling & Charting',
                style: kTextStyle.copyWith(color: kTitleColor),
              ),
              leading: const Icon(
                FeatherIcons.video,
                color: kMainColor,
              ),
            ),
            ListTile(
              onTap: () => const NotificationScreen().launch(context),
              title: Text(
                'Notification',
                style: kTextStyle.copyWith(color: kTitleColor),
              ),
              leading: const Icon(
                FeatherIcons.bell,
                color: kMainColor,
              ),
            ),
            ListTile(
              title: Text(
                'Terms & Conditions',
                style: kTextStyle.copyWith(color: kTitleColor),
              ),
              leading: const Icon(
                Icons.info_outline,
                color: kMainColor,
              ),
            ),
            ListTile(
              title: Text(
                'Privacy Policy',
                style: kTextStyle.copyWith(color: kTitleColor),
              ),
              leading: const Icon(
                FeatherIcons.alertTriangle,
                color: kMainColor,
              ),
            ),
            ListTile(
              onTap: () {
                AppServices.instance<DatabaseService>().clearSession();
                const SignIn().launch(context, isNewTask: true);
              },
              title: Text(
                'Logout',
                style: kTextStyle.copyWith(color: kTitleColor),
              ),
              leading: const Icon(
                FeatherIcons.logOut,
                color: kMainColor,
              ),
            ),
          ],
        ),
      ),
      */
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              // width: double.infinity,
              // height: Measurement.heightPercent(context, 0.87),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  ..._inOut(),

                  const SizedBox(
                    height: 20.0,
                  ),

                  ..._gridMenu(),

                  const SizedBox(
                    height: 20.0,
                  ),
                  // ..._options()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _options() {
    return [
      Material(
        elevation: 2.0,
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
          child: ListTile(
            onTap: () {
              const SalaryStatementList().launch(context);
            },
            leading:
                const Image(image: AssetImage('images/salarymanagement.png')),
            title: Text(
              'Salary Statement',
              maxLines: 2,
              style: kTextStyle.copyWith(
                  color: kTitleColor, fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        ),
      ),
      const SizedBox(
        height: 20.0,
      ),
      Material(
        elevation: 2.0,
        child: Container(
          width: context.width(),
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Color(0xFF1CC389),
                width: 3.0,
              ),
            ),
            color: Colors.white,
          ),
          child: ListTile(
            onTap: () => const NoticeList().launch(context),
            leading: const Image(image: AssetImage('images/noticeboard.png')),
            title: Text(
              'Notice Board',
              maxLines: 2,
              style: kTextStyle.copyWith(
                  color: kTitleColor, fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        ),
      ),
      const SizedBox(
        height: 20.0,
      ),
      Material(
        elevation: 2.0,
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
          child: ListTile(
            onTap: () => const OutworkList().launch(context),
            leading:
                const Image(image: AssetImage('images/outworksubmission.png')),
            title: Text(
              'Outwork Submission',
              maxLines: 2,
              style: kTextStyle.copyWith(
                  color: kTitleColor, fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        ),
      ),
      const SizedBox(
        height: 20.0,
      ),
      Material(
        elevation: 2.0,
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
          child: ListTile(
            onTap: () => const LoanList().launch(context),
            leading: const Image(image: AssetImage('images/loan.png')),
            title: Text(
              'Loan',
              maxLines: 2,
              style: kTextStyle.copyWith(
                  color: kTitleColor, fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        ),
      ),
    ];
  }

  List<Widget> _gridMenu() {
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
                  const LeaveManagementScreen().launch(context);
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

  List<Widget> _inOut() {
    return [
      Text(
        'Wednesday, Nov 17, 2021',
        style: kTextStyle.copyWith(color: kGreyTextColor),
      ),
      const SizedBox(
        height: 10.0,
      ),
      Text(
        '09:00 AM',
        style: kTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 25.0),
      ),

      /// ************

      Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: InOutCard(
          // checkinDate: "10-10-2024",
          // checkoutDate: "10-10-2024",
          onSubmit: (st) {},
          status: AttendanceInOutStatus.checkIn,
        ),
      ),

      /// ************

      // Padding(
      //   padding: const EdgeInsets.only(top: 10, bottom: 20),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Row(
      //         children: [
      //           Icon(
      //             Icons.circle,
      //             size: 6,
      //             color: AppColor.kGreenColor,
      //           ),
      //           Measurement.gap.width,
      //           Text(
      //             "Check-in : 00:00",
      //             style: Theme.of(context)
      //                 .textTheme
      //                 .greyS13W500
      //                 .copyWith(color: Colors.grey.shade600),
      //           ),
      //         ],
      //       ),

      //       Container(
      //         margin: EdgeInsets.only(left: 10, right: 10),
      //         width: 0.8,
      //         height: 20,
      //         color: Colors.grey.shade600,
      //       ),

      //       ///
      //       Row(
      //         children: [
      //           Icon(
      //             Icons.circle,
      //             size: 6,
      //             color: AppColor.kAlertColor,
      //           ),
      //           Measurement.gap.width,
      //           Text(
      //             "Check-out: 00:00",
      //             style: Theme.of(context)
      //                 .textTheme
      //                 .greyS13W500
      //                 .copyWith(color: Colors.grey.shade600),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),

      Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: true
              ? kGreenColor.withOpacity(0.1)
              : kAlertColor.withOpacity(0.1),
        ),
        child: GestureDetector(
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => const NewAttendenceReport()));
          },
          child: CircleAvatar(
            radius: 80.0,
            backgroundColor: true ? kGreenColor : kAlertColor,
            child: Text(
              true ? 'Check In' : 'Check Out',
              style: kTextStyle.copyWith(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    ];
  }
}
