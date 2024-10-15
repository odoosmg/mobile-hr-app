import 'package:flutter/material.dart';
import 'package:hrm_employee/GlobalComponents/dialog/custom_dialog.dart';
import 'package:hrm_employee/Models/form/select_form_model.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/app_color.dart';
import 'package:hrm_employee/utlis/measurement.dart';

class SelectCompany extends StatefulWidget {
  const SelectCompany({super.key});

  @override
  State<SelectCompany> createState() => _SelectCompanyState();
}

class _SelectCompanyState extends State<SelectCompany> {
  final List<String> items = [
    'Flutter',
    'Node.js',
    'React Native',
    'Java',
    'Docker',
    'MySQL'
  ];

  final List<SelectFormModel> items2 = [
    SelectFormModel()
      ..id = 0
      ..name = "Company A"
      ..isSelected = false,
    SelectFormModel()
      ..id = 1
      ..name = "Company B"
      ..isSelected = false,
    SelectFormModel()
      ..id = 2
      ..name = "Company C"
      ..isSelected = false,
    SelectFormModel()
      ..id = 3
      ..name = "Company D"
      ..isSelected = false,
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(2),
                ),
              ),
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Company",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.blackS17W700,
              ),
              content: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: items2
                      .map(
                        (e) => CheckboxListTile(
                            value: e.isSelected,
                            // checkColor: ,
                            fillColor: MaterialStateColor.resolveWith((states) {
                              return e.isSelected!
                                  ? AppColor.kMainColor
                                  : Colors.transparent;
                              return AppColor.kMainColor;
                            }),
                            title: Text(
                              e.name!,
                              style: Theme.of(context).textTheme.blackS14W500,
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (isChecked) {
                              setState(() {
                                e.isSelected = !e.isSelected!;
                              });
                            }),
                      )
                      .toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel',
                      style: Theme.of(context).textTheme.greyS14W700),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Apply'),
                ),
              ],
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          children: [
            Container(
              // color: Colors.amber,
              alignment: Alignment.center,
              width: Measurement.widthPercent(context, 0.3),
              height: 100,
              child: Text(
                "Soma, CADO, CA..",
                style: Theme.of(context).textTheme.whiteS13W400,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(Icons.keyboard_arrow_down)
          ],
        ),
      ),
    );
  }
}
