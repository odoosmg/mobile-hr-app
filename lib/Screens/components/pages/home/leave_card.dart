import 'package:flutter/material.dart';
import 'package:hrm_employee/Models/auth/user_model.dart';
import 'package:hrm_employee/utlis/measurement_widget_extension.dart';
// ignore: depend_on_referenced_packages
import 'package:nb_utils/nb_utils.dart';
import 'package:hrm_employee/constant.dart';
import 'package:hrm_employee/utlis/measurement.dart';

/// Status : To Approve, Refused, Approved

class LeaveCard extends StatelessWidget {
  final UserModel data;
  const LeaveCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
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
                color: data.getLeaveStatus()!.getColor,
                width: 3.0,
              ),
            ),
            color: Colors.white,
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Employee name
                  Text(
                    data.employeeName ?? "",
                    // maxLines: 1,
                    // overflow: TextOverflow.ellipsis,
                    style: kTextStyle.copyWith(
                        color: kTitleColor, fontWeight: FontWeight.bold),
                  ),

                  2.kHeight,

                  /// Department
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          data.departmentName ?? "",
                          style: kTextStyle.copyWith(
                            color: kGreyTextColor,
                          ),
                        ),
                      ),

                      /// status
                      _status(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _status() {
    return Row(
      children: [
        Text(
          data.status!,
          style: kTextStyle.copyWith(
            color: data.getLeaveStatus()!.getColor,
          ),
        ),
        const SizedBox(
          width: 4.0,
        ),
        CircleAvatar(
          radius: 10.0,
          backgroundColor: data.getLeaveStatus()!.getColor,

          /// icon
          child: Icon(
            data.getLeaveStatus()!.iconData,
            color: Colors.white,
            size: 12,
          ),
        ),
      ],
    );
  }
}
