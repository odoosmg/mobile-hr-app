import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:hrm_employee/constant.dart';
import 'package:hrm_employee/utlis/app_color.dart';
import 'package:hrm_employee/utlis/measurement.dart';

class LeaveCard extends StatelessWidget {
  const LeaveCard({super.key});

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
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(
                color: AppColor.kGreenColor,
                width: 3.0,
              ),
            ),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Measurement.widthPercent(context, 0.53),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Annual Leave',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kTextStyle.copyWith(
                          color: kTitleColor, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Manager',
                      style: kTextStyle.copyWith(
                        color: kGreyTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
