import 'package:flutter/material.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/measurement.dart';
import 'package:hrm_employee/utlis/measurement_widget_extension.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:hrm_employee/Screens/components/appbar/custom_appbar.dart';
import 'package:hrm_employee/Screens/components/others/custom_scaffold.dart';

class LeaveHistoryScreen extends StatefulWidget {
  const LeaveHistoryScreen({super.key});

  @override
  State<LeaveHistoryScreen> createState() => _LeaveHistoryScreenState();
}

class _LeaveHistoryScreenState extends State<LeaveHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar.titleActions(title: "Attendance History"),
      body: Column(
        children: [
          10.kHeight,
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
                      color: Colors.blue,
                      width: 3.0,
                    ),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "22 Oct 2024",
                          style: Theme.of(context).textTheme.blackS14W700,
                        ),
                        Text(
                          "8 hours",
                          style: Theme.of(context).textTheme.greyS14W400,
                        )
                      ],
                    ),
                    4.kHeight,
                    _inOut(
                      text1: "IN",
                      text2: "10:12:20",
                      text2Color: Colors.green,
                    ),
                    2.kHeight,
                    _inOut(
                      text1: "OUT",
                      text2: "10:12:20",
                      text2Color: Colors.orange,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _inOut(
      {required String text1,
      required String text2,
      required Color text2Color}) {
    return Row(
      children: [
        Text(
          text1,
          style: Theme.of(context).textTheme.blackS13W400,
        ),
        Measurement.gap.kWidth,
        Text(
          text2,
          style: Theme.of(context)
              .textTheme
              .blackS14W400
              .copyWith(color: text2Color),
        )
      ],
    );
  }
}
