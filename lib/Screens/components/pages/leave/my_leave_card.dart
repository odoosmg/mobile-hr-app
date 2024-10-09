// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:hrm_employee/Models/leave/leave_model.dart';
import 'package:hrm_employee/constant.dart';
import 'package:hrm_employee/extensions/date_extension.dart';
import 'package:nb_utils/nb_utils.dart';

class MyLeaveCard extends StatelessWidget {
  final LeaveModel data;
  const MyLeaveCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return _leaveCard(context);
  }

  Widget _leaveCard(BuildContext context) {
    return Material(
      elevation: 2.0,
      child: GestureDetector(
        onTap: () {
          // const DailyWorkReport().launch(context);
        },
        child: Container(
          width: context.width(),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: data.getLeaveStatus!.getColor,
                width: 3.0,
              ),
            ),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.leaveTypeName ?? "",
                maxLines: 2,
                style: kTextStyle.copyWith(
                    color: kTitleColor, fontWeight: FontWeight.bold),
              ),

              /// From date To date
              Text(
                'From ${_dateFormat(data.dateFrom)} to ${_dateFormat(data.dateTo)}',
                style: kTextStyle.copyWith(
                  color: kGreyTextColor,
                ),
              ),

              /// number of days
              Row(
                children: [
                  Text(
                    '${data.numberOfDays} day(s)${_period()}',
                    style: kTextStyle.copyWith(
                      color: kGreyTextColor,
                    ),
                  ),
                  const Spacer(),

                  /// Status
                  Text(
                    data.state ?? "",
                    style: kTextStyle.copyWith(
                      color: data.getLeaveStatus!.getColor,
                    ),
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),

                  /// Icon
                  CircleAvatar(
                    radius: 10.0,
                    backgroundColor: data.getLeaveStatus!.getColor,
                    child: Icon(
                      data.getLeaveStatus!.iconData,
                      color: Colors.white,
                      size: 13,
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

  String _period() {
    if ((data.requestDateFromPeriod ?? "").isEmpty) {
      return "";
    }

    return ", ${data.requestDateFromPeriod}";
  }

  String _dateFormat(String? date) {
    if (date == null || date.isEmpty) {
      return "";
    }
    return DateTime.parse(date).dateFormat(toFormat: "dd, MMM yyyy").toString();
  }
}
