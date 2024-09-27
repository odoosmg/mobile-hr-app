import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/app_color.dart';
import 'package:hrm_employee/utlis/measurement.dart';

class AttendanceStaticChart extends StatefulWidget {
  const AttendanceStaticChart({super.key});

  @override
  State<AttendanceStaticChart> createState() => _AttendanceStaticChartState();
}

class _AttendanceStaticChartState extends State<AttendanceStaticChart> {
  ///
  Map<String, double> dataMap = {
    "Late": 5,
    // "Early Leave": 3,
    "Absent": 2.2,
    "Normal": 2.1,
    "OverTime": 5,
  };

  final colorList = <Color>[
    Colors.orange, // late
    // Colors.yellow, // early leave
    AttendanceDayStatus.absent.bgColor, // absent
    Colors.blueGrey, // leave
    Colors.grey, // overtime
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "My statics",
          style: Theme.of(context).textTheme.blackS14W700,
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: Measurement.screenPadding, bottom: 4),
          child: _btn(),
        ),
        PieChart(
          dataMap: dataMap,
          // colorList: colorList,
        ),
      ],
    );
  }

  Widget _btn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ///
        _btnContainer(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(width: 2, color: AppColor.kMainColor),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Measurement.btnRadius),
                  bottomLeft: Radius.circular(Measurement.btnRadius),
                ),
              ),
            ),
            child: Text(
              'Weekly',
              style: Theme.of(context).textTheme.mainS13W500,
            ),
          ),
        ),

        ///
        _btnContainer(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.kMainColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Measurement.btnRadius),
                  bottomRight: Radius.circular(Measurement.btnRadius),
                ),
              ),
            ),
            child: Text(
              'Monthly',
              style: Theme.of(context).textTheme.whiteS13W500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _btnContainer({required Widget child}) {
    return SizedBox(
      height: 50,
      width: 120,
      child: child,
    );
  }
}
