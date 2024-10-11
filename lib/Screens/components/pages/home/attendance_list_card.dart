import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_employee/Screens/components/pages/home/leave_card.dart';
import 'package:hrm_employee/Models/auth/user_model.dart';
import 'package:hrm_employee/Models/home/in_out_model.dart';
import 'package:hrm_employee/Models/leave/leave_model.dart';
import 'package:hrm_employee/Screens/components/others/custom_card.dart';
import 'package:hrm_employee/Screens/components/others/xborder.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/measurement.dart';
import 'package:hrm_employee/utlis/measurement_widget_extension.dart';

class AttendanceListCard extends StatelessWidget {
  final InOutModel data;
  const AttendanceListCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///
        ..._employeeLeave(context),
        Measurement.screenPadding.kHeight,

        ///`
        ..._leaveInfo(context),
      ],
    );
  }

  /// Today Lave Card
  List<Widget> _employeeLeave(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          "Employees have taken leave today",
          style: Theme.of(context).textTheme.blackS14W700,
        ),
      ),
      CustomCard(
        padding:
            const EdgeInsets.only(left: 10, right: 10, bottom: 14, top: 10),
        child: _employeeLeaveTodayTable(context),
      ),
    ];
  }

  List<Widget> _leaveInfo(BuildContext context) {
    return [
      /// Title
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          "My Leave",
          style: Theme.of(context).textTheme.blackS14W700,
        ),
      ),

      ///
      CustomCard(
        child: Column(
          children: _leaveGroup(context),
        ),
      )
    ];
  }

  /// Employee Table
  Widget _employeeLeaveTodayTable(BuildContext context) {
    List<UserModel> list = data.todayLeave ?? [];

    return SizedBox(
      width: double.infinity,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Empty
          if (list.isEmpty)
            Text(
              "Empty",
              style: Theme.of(context).textTheme.greyS14W400,
            ),

          ///
          for (int i = 0; i < list.length; i++)
            Padding(
              padding: EdgeInsets.only(top: i == 0 ? 0 : 20),
              child: LeaveCard(
                data: list[i],
              ),
            ),

          /*
          /// Header
          _employeeRowItem(
            context: context,
            text1: "Employee",
            text2: "Department",
            text3: "Status",
            textStyle: Theme.of(context).textTheme.blackS12W700,
          ),
    
          /// Body
          for (int i = 0; i < list.length; i++)
            ..._employeeItem(
              context: context,
              text1: data.todayLeave?[i].employeeName ?? "",
              text2: data.todayLeave?[i].departmentName ?? "",
              text3: data.todayLeave?[i].status ?? "",
            ),
    
          /// Empty
          if (list.isEmpty)
            ..._employeeItem(
              context: context,
              text1: "",
              text2: "Empty",
              text3: "",
            ),
            */
        ],
      ),
    );
  }

  Widget _employeeRowItem({
    required BuildContext context,
    required String text1,
    required String text2,
    required String text3,
    required TextStyle textStyle,
  }) {
    double rowWidth = Measurement.widthPercent(context, 0.275);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// employee name
        SizedBox(
          width: rowWidth,
          child: _employeeText(
              text: text1, textStyle: textStyle, textAlign: TextAlign.left),
        ),
        SizedBox(
          width: rowWidth,
          child: _employeeText(text: text2, textStyle: textStyle),
        ),
        SizedBox(
          width: rowWidth,
          child: _employeeText(text: text3, textStyle: textStyle),
        ),
      ],
    );
  }

  Text _employeeText({
    required String text,
    required TextStyle textStyle,
    TextAlign textAlign = TextAlign.center,
  }) {
    return Text(
      text,
      style: textStyle,
      maxLines: 1,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
    );
  }

  List<Widget> _employeeItem({
    required BuildContext context,
    required String text1,
    required String text2,
    required String text3,
  }) {
    return [
      /// Border
      const Xborder(
        margin: EdgeInsets.only(top: 8, bottom: 8),
      ),
      _employeeRowItem(
        context: context,
        text1: text1,
        text2: text2,
        text3: text3,
        textStyle: Theme.of(context)
            .textTheme
            .greyS13W400
            .copyWith(color: Colors.grey.shade700),
      ),
    ];
  }

  /// text with icon
  Widget _alItem(BuildContext context, String text) {
    /// [0] label, [1] number
    List<String> str = text.split(" ");

    /// 0 not displaying
    // if (str[1] == "0") {
    //   return Container();
    // }

    return Row(
      children: [
        Icon(
          Icons.circle,
          size: 6,
          color: Colors.grey.shade500,
        ),
        Measurement.gap.width,

        /// label
        SizedBox(
          width: 80,
          child: Text(
            str[0],
            style: Theme.of(context).textTheme.blackS13W400,
          ),
        ),

        /// number
        Text(
          ': ${str[1]}',
          overflow: TextOverflow.clip,
          style: Theme.of(context).textTheme.blackS13W400,
        ),
      ],
    );
  }

  List<Widget> _leaveItem({
    required BuildContext context,
    required String title,
    required List<String> alItems,
    bool isBorder = true,
  }) {
    return [
      Row(
        children: [
          SizedBox(
            width: Measurement.widthPercent(context, 0.45),
            child: Text(
              title,
              style: Theme.of(context).textTheme.blackS13W500,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: alItems.map((e) => _alItem(context, e)).toList(),
          )
        ],
      ),

      /// Border
      if (isBorder)
        const Xborder(
          margin: EdgeInsets.only(top: 10, bottom: 10),
        ),
    ];
  }

  List<Widget> _leaveGroup(BuildContext context) {
    List<LeaveModel> list = data.leaveSummary ?? [];
    return [
      for (int i = 0; i < list.length; i++)
        ..._leaveItem(
          context: context,
          title: list[i].name ?? "",
          alItems: _getAlItemStr(list[i]),

          /// no border for last item
          isBorder: i != list.length - 1,
        ),

      /// Empty
      if (list.isEmpty)
        Text(
          "Empty",
          style: Theme.of(context)
              .textTheme
              .greyS13W400
              .copyWith(color: Colors.grey.shade700),
        )
    ];
  }

  ///
  List<String> _getAlItemStr(LeaveModel d) {
    List<String> list = [];

    if (d.allocate != null) {
      list.add("Allocated ${d.allocate}");
    }

    if (d.approved != null) {
      list.add("Approved ${d.approved}");
    }

    if (d.remaining != null) {
      list.add("Remaining ${d.remaining}");
    }

    return list;
  }
}
