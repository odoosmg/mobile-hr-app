// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/GlobalComponents/dialog/custom_dialog.dart';
import 'package:hrm_employee/GlobalComponents/dialog/custom_loading.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/leave/leave_model.dart';
import 'package:hrm_employee/Screens/Leave%20Management/bloc/leave_bloc.dart';
import 'package:hrm_employee/constant.dart';
import 'package:hrm_employee/extensions/date_extension.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/app_color.dart';
import 'package:hrm_employee/utlis/app_trans.dart';
import 'package:hrm_employee/utlis/measurement.dart';
import 'package:hrm_employee/utlis/measurement_widget_extension.dart';
import 'package:nb_utils/nb_utils.dart';

class MyLeaveCard extends StatelessWidget {
  final LeaveModel data;
  final Function(bool)? onAction; // true = accept, false = refuse
  final int index;
  final bool isToApproved;
  const MyLeaveCard({
    super.key,
    required this.data,
    required this.index,
    this.onAction,
    this.isToApproved = false,
  });

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
              if (isToApproved) ..._nameType(),
              if (!isToApproved)
                Text(
                  data.leaveTypeName ?? "",
                  maxLines: 2,
                  style: kTextStyle.copyWith(
                      color: kTitleColor, fontWeight: FontWeight.bold),
                ),

              /// Remaining
              if (isToApproved)
                Row(
                  children: [
                    Text(
                      "Remaining",
                      style: kTextStyle.copyWith(
                        color: kGreyTextColor,
                      ),
                    ),
                    Measurement.gap.kWidth,
                    Text(
                      "${data.leaveRemaining ?? 0.0}",
                      style: kTextStyle.copyWith(
                        color: kGreyTextColor,
                      ),
                    )
                  ],
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

              /// Btn Approve, Refuse
              if (isToApproved)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _btn(context, true), // Approve
                      8.kWidth,
                      _btn(context, false), // Refuse
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _btn(BuildContext context, bool isAccept) {
    return SizedBox(
      height: 35,
      child: ElevatedButton(
        onPressed: () {
          _confirmDialog(context, isAccept);
        },
        style: ButtonStyle(
            overlayColor: MaterialStateColor.resolveWith(
                (states) => Colors.white.withOpacity(0.2)),
            backgroundColor: MaterialStateColor.resolveWith((states) =>
                isAccept ? AppColor.kGreenColor : AppColor.kDangerColor)),
        child: Text(
          isAccept ? "Accept" : "Refuse",
          style: Theme.of(context).textTheme.whiteS13W500,
        ),
      ),
    );
  }

  Widget _dialogContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Form, To
        Text(
          'From ${_dateFormat(data.dateFrom)} to ${_dateFormat(data.dateTo)}',
          style: kTextStyle.copyWith(
            color: kGreyTextColor,
          ),
        ),
        Measurement.gap.kHeight,
        _textRow('Type', '${data.leaveTypeName}'),
        Measurement.gap.kHeight,

        _textRow('Duration', '${data.numberOfDays} day(s)${_period()}'),
        Measurement.gap.kHeight,
        _textRow('Reasons', data.description ?? ""),
      ],
    );
  }

  Widget _textRow(String text1, String text2) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$text1 :',
          style: kTextStyle.copyWith(
            color: kGreyTextColor,
          ),
        ),
        10.kWidth,
        Expanded(
          child: Text(
            text2,
            style: kTextStyle.copyWith(
              color: kGreyTextColor,
            ),
          ),
        ),
      ],
    );
  }

  void _confirmDialog(
    BuildContext context,
    bool isAccept,
  ) {
    CustomDialog.dialog(context,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Are you sure to ${isAccept ? "accept" : "refuse"}',
                style: Theme.of(context).textTheme.blackS14W400,
              ),
              TextSpan(
                text: ' ${data.employeeName} ',
                style: Theme.of(context).textTheme.blackS14W700,
              ),
              TextSpan(
                text: '?',
                style: Theme.of(context).textTheme.blackS14W400,
              ),
            ],
          ),
        ),
        content: _dialogContent(),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppTrans.t.cancel.toUpperCase(),
              style: Theme.of(context).textTheme.greyS14W400,
            ),
          ),
          BlocListener<LeaveBloc, LeaveState>(
            listener: (ctx, state) {
              if (state.stateType == LeaveStateType.leaveAction) {
                final result = state.leaveActionResult;

                if (result!.status == ApiStatus.loading) {
                  CustomLoading.show(context);
                } else {
                  CustomLoading.hide(context);
                  if (result.isSuccess) {
                    Navigator.pop(context);
                  } else {
                    CustomDialog.error(context,
                        errCode: result.statuscode,
                        errMsg: result.errorMessage);
                  }
                }
              }
            },
            child: TextButton(
              onPressed: () {
                ///
                context.read<LeaveBloc>().add(
                      LeaveAction(
                        data: data,
                        status: isAccept
                            ? LeaveStatus.approved
                            : LeaveStatus.refused,
                        index: index,
                      ),
                    );

                /// close modal
                // Navigator.pop(context);
              },
              child: Text(
                (isAccept ? "Accept" : "Refuse").toUpperCase(),
                style: Theme.of(context).textTheme.blackS15W700.copyWith(
                    color: isAccept
                        ? AppColor.kGreenColor
                        : AppColor.kDangerColor),
              ),
            ),
          ),
        ]);
  }

  List<Widget> _nameType() {
    return [
      Text(
        data.employeeName ?? "",
        maxLines: 1,
        style: kTextStyle.copyWith(
            color: kTitleColor, fontWeight: FontWeight.bold),
      ),
      Text(
        data.leaveTypeName ?? "",
        maxLines: 1,
        style: kTextStyle.copyWith(
          color: kGreyTextColor,
        ),
      ),
    ];
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
