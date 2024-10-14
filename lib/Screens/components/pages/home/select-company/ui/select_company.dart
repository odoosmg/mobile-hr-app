import 'package:flutter/material.dart';
import 'package:hrm_employee/GlobalComponents/dialog/custom_dialog.dart';
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
                  children: items
                      .map(
                        (e) => CheckboxListTile(
                            value: false,
                            // checkColor: ,
                            fillColor: MaterialStateColor.resolveWith((states) {
                              return Colors.transparent;
                              return AppColor.kMainColor;
                            }),
                            title: Text(
                              e,
                              style: Theme.of(context).textTheme.blackS14W500,
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (isChecked) {}),
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
