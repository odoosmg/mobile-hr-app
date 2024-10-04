// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
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
  final dateController = TextEditingController();
  List<String> numberOfInstallment = [
    'Annual Leave',
    'Casual Leave',
    'Compensatory Leave',
    'Exam Leave',
    'Sick Leave'
  ];
  String installment = 'Annual Leave';

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Container(
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _leaveType() {
    return SizedBox(
      height: 60.0,
      child: FormField(
        builder: (FormFieldState<dynamic> field) {
          return InputDecorator(
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: 'Select Leave Type',
                labelStyle: kTextStyle,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
            child: DropdownButtonHideUnderline(child: getInstallment()),
          );
        },
      ),
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
      _toDate(),
      const SizedBox(
        height: 20.0,
      ),
      _selectAmPm(),
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
        dateController.text = date.toString().substring(0, 10);
      },
      controller: dateController,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(
            Icons.date_range_rounded,
            color: kGreyTextColor,
          ),
          labelText: 'From Date',
          hintText: '11/09/2021'),
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
        dateController.text = date.toString().substring(0, 10);
      },
      controller: dateController,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(
            Icons.date_range_rounded,
            color: kGreyTextColor,
          ),
          labelText: 'To Date',
          hintText: '11/09/2021'),
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
    return ButtonGlobal(
      buttontext: 'Apply',
      buttonDecoration: kButtonDecoration.copyWith(color: kMainColor),
      onPressed: null,
    );
  }

  DropdownButton<String> getInstallment() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String installment in numberOfInstallment) {
      var item = DropdownMenuItem(
        value: installment,
        child: Text(installment),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      items: dropDownItems,
      value: installment,
      onChanged: (value) {
        setState(() {
          installment = value!;
        });
      },
    );
  }

  ///
  DropdownButton<SelectFormModel> _dropdownItem(
    List<SelectFormModel> list,
    SelectFormModel selectedItem,
  ) {
    List<DropdownMenuItem<SelectFormModel>> dropDownItems = list
        .map((e) => DropdownMenuItem(
              value: e,
              child: Text(e.name!),
            ))
        .toList();

    return DropdownButton(
      items: dropDownItems,
      value: selectedItem,
      onChanged: (value) {},
    );
  }

  ///
  List<Widget> _fullAndHalf() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  activeColor: kMainColor,
                  value: isFullDay,
                  onChanged: (val) {
                    setState(() {
                      isFullDay = val!;
                    });
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
          Row(
            children: [
              Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  activeColor: kMainColor,
                  value: !isFullDay,
                  onChanged: (val) {
                    setState(() {
                      isFullDay = !isFullDay;
                    });
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
      ),
    ];
  }

  ///
  Widget _selectAmPm() {
    return SizedBox(
      height: 60.0,
      child: FormField(
        builder: (FormFieldState<SelectFormModel> field) {
          return InputDecorator(
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: 'AM / PM',
                labelStyle: kTextStyle,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
            child: DropdownButtonHideUnderline(
              child: _dropdownItem(
                amPmList,
                amPmList[0],
              ),
            ),
          );
        },
      ),
    );
  }

  ///*********************************************************
  ///
  ///*********************************************************

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }
}
