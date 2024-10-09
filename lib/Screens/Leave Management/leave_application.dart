// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/Screens/Leave%20Management/bloc/leave_bloc.dart';
import 'package:hrm_employee/Screens/Leave%20Management/leave_apply.dart';
import 'package:hrm_employee/Screens/components/appbar/custom_appbar.dart';
import 'package:hrm_employee/Screens/components/others/body_card.dart';
import 'package:hrm_employee/Screens/components/others/custom_card.dart';
import 'package:hrm_employee/Screens/components/others/custom_scaffold.dart';
import 'package:hrm_employee/Screens/components/others/xborder.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/measurement.dart';
import 'package:hrm_employee/utlis/measurement_widget_extension.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../constant.dart';

class LeaveApplication extends StatefulWidget {
  const LeaveApplication({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LeaveApplicationState createState() => _LeaveApplicationState();
}

class _LeaveApplicationState extends State<LeaveApplication> {
  late LeaveBloc leaveBloc;

  @override
  void initState() {
    leaveBloc = context.read<LeaveBloc>();
    leaveBloc.add(LeaveMyList(true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar.titleActions(title: "Leave List", actions: []),
      body: Column(
        children: [
          10.height,
          _count(),
          10.height,
          Xborder(),
          Measurement.screenPadding.kHeight,
          _leaveCard(),
          20.height,
          _leaveCard(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => const LeaveApply().launch(context),
        backgroundColor: kMainColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => const LeaveApply().launch(context),
        backgroundColor: kMainColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Leave List',
          maxLines: 2,
          style: kTextStyle.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Image(
            image: AssetImage('images/employeesearch.png'),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: Container(
              width: context.width(),
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Material(
                    elevation: 2.0,
                    child: GestureDetector(
                      onTap: () {
                        // const DailyWorkReport().launch(context);
                      },
                      child: Container(
                        width: context.width(),
                        padding: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Color(0xFF7D6AEF),
                              width: 3.0,
                            ),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Annual Leave',
                              maxLines: 2,
                              style: kTextStyle.copyWith(
                                  color: kTitleColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'From 16, May 2021 to 20, May 2021',
                              style: kTextStyle.copyWith(
                                color: kGreyTextColor,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '(Apply Date) 15, May 2021',
                                  style: kTextStyle.copyWith(
                                    color: kGreyTextColor,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'Approved',
                                  style: kTextStyle.copyWith(
                                    color: kGreenColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4.0,
                                ),
                                const CircleAvatar(
                                  radius: 10.0,
                                  backgroundColor: kGreenColor,
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Material(
                    elevation: 2.0,
                    child: GestureDetector(
                      onTap: () {
                        // const DailyWorkReport().launch(context);
                      },
                      child: Container(
                        width: context.width(),
                        padding: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: kAlertColor,
                              width: 3.0,
                            ),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Exam Leave',
                              maxLines: 2,
                              style: kTextStyle.copyWith(
                                  color: kTitleColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'From 16, May 2021 to 20, May 2021',
                              style: kTextStyle.copyWith(
                                color: kGreyTextColor,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '(Apply Date) 15, May 2021',
                                  style: kTextStyle.copyWith(
                                    color: kGreyTextColor,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'Pending',
                                  style: kTextStyle.copyWith(
                                    color: kAlertColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4.0,
                                ),
                                const CircleAvatar(
                                  radius: 10.0,
                                  backgroundColor: kAlertColor,
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _leaveCard() {
    return Material(
      elevation: 2.0,
      child: GestureDetector(
        onTap: () {
          // const DailyWorkReport().launch(context);
        },
        child: Container(
          width: context.width(),
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Color(0xFF7D6AEF),
                width: 3.0,
              ),
            ),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Annual Leave',
                maxLines: 2,
                style: kTextStyle.copyWith(
                    color: kTitleColor, fontWeight: FontWeight.bold),
              ),
              Text(
                'From 16, May 2021 to 20, May 2021',
                style: kTextStyle.copyWith(
                  color: kGreyTextColor,
                ),
              ),
              Row(
                children: [
                  Text(
                    '(Apply Date) 15, May 2021',
                    style: kTextStyle.copyWith(
                      color: kGreyTextColor,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Approved',
                    style: kTextStyle.copyWith(
                      color: kGreenColor,
                    ),
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  const CircleAvatar(
                    radius: 10.0,
                    backgroundColor: kGreenColor,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _count() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Allocated : 10", style: Theme.of(context).textTheme.blackS12W400),
        Text(
          "Approved : 2",
          style: Theme.of(context).textTheme.blackS12W400,
        ),
        Text(
          "Remaining : 2",
          style: Theme.of(context).textTheme.blackS12W400,
        ),
      ],
    );
  }
}
