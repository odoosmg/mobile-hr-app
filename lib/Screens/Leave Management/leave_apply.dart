// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/GlobalComponents/button/main_btn.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/leave/leave_model.dart';
import 'package:hrm_employee/Screens/Home/bloc/home_bloc.dart';
import 'package:hrm_employee/Screens/Leave%20Management/bloc/leave_bloc.dart';
import 'package:hrm_employee/Screens/components/kbuilder/k_builder.dart';
import 'package:hrm_employee/Screens/components/select/SelectForm/ui/select_form.dart';
import 'package:hrm_employee/extensions/date_extension.dart';
import 'package:hrm_employee/utlis/measurement.dart';
import 'package:provider/provider.dart';
import 'package:hrm_employee/Screens/components/select/SelectForm/cubit/select_form_cubit.dart';
import 'package:hrm_employee/Models/form/select_form_model.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../GlobalComponents/button_global.dart';
import '../../constant.dart';

class LeaveApply extends StatefulWidget {
  const LeaveApply({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LeaveApplyState createState() => _LeaveApplyState();
}

class _LeaveApplyState extends State<LeaveApply> {
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
  int leaveTypeId = 0;
  String datePeroid = "";
  String formatLabelDate = "yyyy-MM-dd";

  @override
  void initState() {
    leaveBloc = context.read<LeaveBloc>();
    leaveBloc.add(LeaveTypeListForm());

    /// init default date and calculate day count
    dateFromTEC.text = DateTime.now().dateFormat(toFormat: formatLabelDate)!;
    dateToTEC.text = dateFromTEC.text;

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
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Leave Apply',
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
      body: _body(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Container(
            width: context.width(),
            padding: const EdgeInsets.all(20.0),
            height: Measurement.heightPercent(context, 0.78),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
              color: Colors.white,
            ),
            child: _blocBuilder(),
          ),
        ],
      ),
    );
  }

  BlocBuilder _blocBuilder() {
    return BlocBuilder<LeaveBloc, LeaveState>(
      buildWhen: (previous, current) {
        if (current.stateType == LeaveStateType.leaveTypeList) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        return KBuilder(
            status: state.listTypeResult!.status!,
            builder: (st) {
              return st == ApiStatus.loading ? Container() : _display();
            });
      },
    );
  }

  Widget _display() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20.0,
        ),

        /// Leave type
        _leaveType(),

        ..._selectDate(),

        /// description
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: _description(),
        ),

        /// btn
        _btnSubmit(),
      ],
    );
  }

  Widget _leaveType() {
    return SelectForm(
      data: leaveBloc.state.listTypeResult?.data?.leaveTypeList ?? [],
      initId: 4,
      labelText: "Leave Type",
      onSelect: (d) {},
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
      ..._fullAndHalf(),
    ];
  }

  Widget _fromDate() {
    return AppTextField(
      textFieldType: TextFieldType.NAME,
      readOnly: true,
      onTap: () async {
        var date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100));
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
        var date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100));

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
      textFieldType: TextFieldType.MULTILINE,
      maxLines: 2,
      decoration: kInputDecoration.copyWith(
        labelText: 'Description',
        hintText: 'Enter description',
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
        return false;
      },
      builder: (context, state) {
        print("state.dayCount == ${state.dayCount}");
        return MainBtn(
          title: "Apply",
          isOk: state.dayCount! > 0,
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
      onSelect: (d) {},
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

  @override
  void dispose() {
    leaveBloc.state.isHalfDay = false;

    dateFromTEC.dispose();
    dateToTEC.dispose();
    descTEC.dispose();

    ///
    // leaveBloc.state.listTypeResult!.status = ApiStatus.loading;
    // leaveBloc.state.listTypeResult!.data = LeaveModel();
    super.dispose();
  }
}
