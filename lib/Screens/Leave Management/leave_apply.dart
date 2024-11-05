// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/GlobalComponents/function_global.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:hrm_employee/GlobalComponents/button/main_btn.dart';
import 'package:hrm_employee/GlobalComponents/dialog/custom_dialog.dart';
import 'package:hrm_employee/GlobalComponents/dialog/custom_loading.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/api/api_result.dart';
import 'package:hrm_employee/Models/leave/leave_model.dart';
import 'package:hrm_employee/Screens/Leave%20Management/bloc/leave_bloc.dart';
import 'package:hrm_employee/Screens/components/kbuilder/k_builder.dart';
import 'package:hrm_employee/Screens/components/others/custom_card.dart';
import 'package:hrm_employee/Screens/components/select/SelectForm/ui/select_form.dart';
import 'package:hrm_employee/extensions/date_extension.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/measurement_widget_extension.dart';
import 'package:hrm_employee/Models/form/select_form_model.dart';
import 'package:hrm_employee/Screens/components/appbar/custom_appbar.dart';
import 'package:hrm_employee/Screens/components/others/custom_scaffold.dart';
import '../../constant.dart';

class LeaveApply extends StatefulWidget {
  const LeaveApply({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LeaveApplyState createState() => _LeaveApplyState();
}

class _LeaveApplyState extends State<LeaveApply> with WidgetsBindingObserver {
  List<SelectFormModel> amPmList = [
    SelectFormModel()
      ..id = 0
      ..name = "Morning"
      ..keyword = "am",
    SelectFormModel()
      ..id = 1
      ..name = "Afternoon"
      ..keyword = "pm",
  ];

  bool isFullDay = true;

  late LeaveBloc leaveBloc;

  ///
  TextEditingController dateFromTEC = TextEditingController();
  TextEditingController dateToTEC = TextEditingController();
  TextEditingController descTEC = TextEditingController();
  int leaveTypeId = 0; // init id
  // String datePeroid = "am"; // default am
  String formatLabelDate = "yyyy-MM-dd";
  late SelectFormModel datePeriod;

  /// scroll down abit , when focus on text field
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    datePeriod = amPmList[0];

    leaveBloc = context.read<LeaveBloc>();

    /// init default date and calculate day count
    dateFromTEC.text = DateTime.now().dateFormat(toFormat: formatLabelDate)!;
    dateToTEC.text = dateFromTEC.text;

    /// call before fire LeaveTypeListForm
    leaveBloc.add(LeaveInitialDayCount());
    leaveBloc.add(LeaveTypeListForm());

    /// default 1, the same day
    // leaveBloc.state.dayCount = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// if keybaord appear scrool
    if (MediaQuery.of(context).viewInsets.bottom > 0) {
      _scrollDown();
    }
    return CustomScaffold(
      appBar:
          CustomAppBar.titleCompany(title: "Leave Apply", onChanged: (v, _) {}),
      body: _blocBuilder(),
    );
  }

  BlocBuilder _blocBuilder() {
    return BlocBuilder<LeaveBloc, LeaveState>(
      buildWhen: (previous, current) {
        if (current.stateType == LeaveStateType.leaveTypeList) {
          leaveTypeId = leaveBloc.state.listTypeResult?.data?.initId ?? 0;
          return true;
        }
        return false;
      },
      builder: (context, state) {
        return KBuilder(
            status: state.listTypeResult!.status!,
            onRetry: () {
              leaveBloc.add(LeaveInitialDayCount());
              leaveBloc.add(LeaveTypeListForm());
            },
            builder: (st) {
              return st == ApiStatus.loading ? Container() : _display();
            });
      },
    );
  }

  Widget _display() {
    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.center,
      controller: _scrollController,
      children: [
        const SizedBox(
          height: 20.0,
        ),

        /// Leave type
        _leaveType(),

        ..._selectDate(),

        /// description
        Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 20),
          child: _description(),
        ),

        /// btn
        _btnSubmit(),
        Container(
          height: MediaQuery.of(context).viewInsets.bottom > 0 ? 280 : 0,
        )
      ],
    );
  }

  Widget _leaveType() {
    return SelectForm(
      data: leaveBloc.state.listTypeResult?.data?.leaveTypeList ?? [],
      initId: leaveTypeId,
      labelText: "Leave Type",
      onSelect: (d) {
        leaveTypeId = d.id ?? 0;

        /// Sick Time Off
        // if (leaveTypeId == 2) {
        //   leaveBloc.add(LeaveShowFullHalf(false));
        //   leaveBloc.add(LeaveDaySwitch(false));
        // } else {
        //   leaveBloc.add(LeaveShowFullHalf(true));
        // }
      },
    );
  }

  List<Widget> _selectDate() {
    return [
      const SizedBox(
        height: 20.0,
      ),
      _fromDate(),
      const SizedBox(
        height: 20.0,
      ),
      BlocBuilder<LeaveBloc, LeaveState>(
        buildWhen: (previous, current) {
          if (current.stateType == LeaveStateType.fullOrHalfDay) {
            return true;
          }

          return false;
        },
        builder: (context, state) {
          /// half day display am/pm
          /// else display to date
          return state.isHalfDay! ? _selectAmPm() : _toDate();
        },
      ),
      const SizedBox(
        height: 20.0,
      ),

      ///
      ..._fullAndHalf(),
      10.kHeight,

      /// Total days
      _totalDay(),
    ];
  }

  Widget _fromDate() {
    return AppTextField(
      textFieldType: TextFieldType.NAME,
      readOnly: true,
      onTap: () async {
        // var date = await showDatePicker(
        //     context: context,
        //     initialDate: DateTime.now(),
        //     firstDate: DateTime(1900),
        //     lastDate: DateTime(2100));

        final date =
            await showHolidayCalendar(context: context, title: "From Date");

        if (date != null) {
          dateFromTEC.text = date.dateFormat(toFormat: formatLabelDate) ?? "";

          _validate();
        }
      },
      controller: dateFromTEC,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const Icon(
          Icons.date_range_rounded,
          color: kGreyTextColor,
        ),
        labelText: 'From Date',
        hintText: dateFromTEC.text,
      ),
    );
  }

  Widget _toDate() {
    return AppTextField(
      textFieldType: TextFieldType.NAME,
      readOnly: true,
      onTap: () async {
        // var date = await showDatePicker(
        //     context: context,
        //     initialDate: DateTime.now(),
        //     firstDate: DateTime(1900),
        //     lastDate: DateTime(2100));

        final date =
            await showHolidayCalendar(context: context, title: "To Date");

        if (date != null) {
          dateToTEC.text = date.dateFormat(toFormat: formatLabelDate) ?? "";
          _validate();
        }
      },
      controller: dateToTEC,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const Icon(
            Icons.date_range_rounded,
            color: kGreyTextColor,
          ),
          labelText: 'To Date',
          hintText: dateToTEC.text),
    );
  }

  Widget _description() {
    return AppTextField(
      controller: descTEC,
      textFieldType: TextFieldType.MULTILINE,
      maxLines: 2,
      decoration: kInputDecoration.copyWith(
        labelText: 'Reason',
        hintText: 'Enter reason',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  Widget _btnSubmit() {
    return BlocBuilder<LeaveBloc, LeaveState>(
      buildWhen: (previous, current) {
        /// type dayCount or fullOrHalfDay. we need validate when switching day
        /// build when value not them same as prevoushy
        if (current.stateType == LeaveStateType.dayCount ||
            current.stateType == LeaveStateType.fullOrHalfDay &&
                current.dayCount != previous.dayCount) {
          return true;
        }

        /// Submit leave
        if (current.stateType == LeaveStateType.submit) {
          final ApiResult result = current.submitLeaveResult!;
          if (result.status == ApiStatus.loading) {
            /// loading
            CustomLoading.show(context);
          } else {
            CustomLoading.hide(context);
            if (result.isSuccess) {
              /// success
              Navigator.of(context).pop();
              // CustomDialog.success(context, "Request submitted!");
            } else {
              /// error
              CustomDialog.error(context,
                  errCode: result.statuscode, errMsg: result.errorMessage);
            }
          }
        }
        return false;
      },
      builder: (context, state) {
        return MainBtn(
          title: "Apply",
          isOk: state.dayCount! > 0 && leaveTypeId > 0,
          onPressed: _submit,
        );
      },
    );
  }

  ///
  List<Widget> _fullAndHalf() {
    return [
      /// ** BlocBuilder
      BlocBuilder<LeaveBloc, LeaveState>(
        buildWhen: (previous, current) {
          if (current.stateType == LeaveStateType.fullOrHalfDay) {
            return true;
          }

          return false;
        },
        builder: (context, state) {
          /// id 2 is Sick time off. no half day
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Full day
              Row(
                children: [
                  Checkbox(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      activeColor: kMainColor,
                      value: !state.isHalfDay!,
                      onChanged: (val) {
                        leaveBloc.add(LeaveDaySwitch(false));
                        _validate();
                      }),
                  const SizedBox(
                    width: 4.0,
                  ),
                  Text(
                    'Full Day',
                    style: kTextStyle,
                  ),
                ],
              ),

              /// Half day
              Row(
                children: [
                  Checkbox(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      activeColor: kMainColor,
                      value: state.isHalfDay,
                      onChanged: (val) {
                        leaveBloc.add(LeaveDaySwitch(true));
                        _validate();
                        // isFullDay = val;
                      }),
                  const SizedBox(
                    width: 4.0,
                  ),
                  Text(
                    'Half Day',
                    style: kTextStyle,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    ];
  }

  Widget _selectAmPm() {
    return SelectForm(
      data: amPmList,
      labelText: "AM / PM",
      initId: 0,
      onSelect: (d) {
        datePeriod = d;
      },
    );
  }

  Widget _totalDay() {
    return CustomCard(
      boxShadow: const [],
      background: Colors.grey.shade200,

      /// BlocBuilder
      child: BlocBuilder<LeaveBloc, LeaveState>(
        buildWhen: (previous, current) {
          ///
          if (current.stateType == LeaveStateType.dayCount) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          return Text(
            "Duration : ${num.parse(state.dayCount.toString())} day(s)",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.blackS13W400,
          );
        },
      ),
    );
  }

  ///*********************************************************
  ///
  ///*********************************************************

  void _validate() {
    leaveBloc.add(
      LeaveDayCount(
        from: dateFromTEC.text,
        to: dateToTEC.text,
      ),
    );
  }

  void _submit() {
    ///
    hideKeyboard(context);

    LeaveModel params = LeaveModel();
    params.leaveTypeId = leaveTypeId;
    params.dateTo = dateToTEC.text;
    params.dateFrom = dateFromTEC.text;
    params.isHalfDay = leaveBloc.state.isHalfDay;
    params.datePeriod = "";
    params.description = descTEC.text;

    /// half day, set dateFrom and dateTo to the same day
    if (params.isHalfDay!) {
      params.dateTo = params.dateFrom;
      params.datePeriod = datePeriod.keyword;
      params.requestDateFromPeriod = datePeriod.name; // to display back at list
    }
    leaveBloc.add(LeaveSubmit(params: params));
  }

  void _scrollDown() {
    // Define how far you want to scroll up (e.g., 100 pixels)
    const double scrollOffset = 150.0;

    // Check the current position to avoid negative scrolling
    final newOffset = (_scrollController.offset + scrollOffset).clamp(
      0.0, // Minimum offset is 0 (top of the list)
      _scrollController.position.maxScrollExtent, // Max scroll extent
    );

    // Animate to the new offset
    _scrollController.animateTo(
      newOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    leaveBloc.state.isHalfDay = false;
    // leaveBloc.state.isShowSelectFullHalf = true;

    dateFromTEC.dispose();
    dateToTEC.dispose();
    descTEC.dispose();
    _scrollController.dispose();

    ///
    // leaveBloc.state.listTypeResult!.status = ApiStatus.loading;
    // leaveBloc.state.listTypeResult!.data = LeaveModel();
    super.dispose();
  }
}
