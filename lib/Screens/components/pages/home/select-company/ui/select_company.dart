import 'package:flutter/material.dart';
import 'package:hrm_employee/GlobalComponents/dialog/custom_dialog.dart';
import 'package:hrm_employee/Models/form/select_form_model.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/app_color.dart';
import 'package:hrm_employee/utlis/measurement.dart';

class SelectCompany extends StatefulWidget {
  /// 1st arg = List of id
  /// 2nd arg = List of selected item
  final void Function(List<int>, List<SelectFormModel>) onChanged;
  const SelectCompany({super.key, required this.onChanged});

  @override
  State<SelectCompany> createState() => _SelectCompanyState();
}

class _SelectCompanyState extends State<SelectCompany> {
  String selectedName = "";

  final List<SelectFormModel> items = [
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

  List<SelectFormModel> selectedItems = [];

  @override
  void initState() {
    selectedItems = [items[0], items[1]];
    selectedName = _selectedName(selectedItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /// selcted id
        List<int> ids = selectedItems.map((e) => e.id!).toList();

        /// update list
        items.map((e) {
          if (ids.contains(e.id)) {
            e.isSelected = true;
          } else {
            e.isSelected = false;
          }
        }).toList();

        /// Dialog
        _dialog();
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
                selectedName,
                style: Theme.of(context).textTheme.whiteS13W400,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.keyboard_arrow_down)
          ],
        ),
      ),
    );
  }

  void _dialog() {
    showDialog(
      context: context,
      builder: (contex) {
        return StatefulBuilder(builder: (context, setStateT) {
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
                          value: e.isSelected,
                          // checkColor: ,
                          fillColor: MaterialStateColor.resolveWith((states) {
                            return e.isSelected!
                                ? AppColor.kMainColor
                                : Colors.transparent;
                          }),
                          title: Text(
                            e.name!,
                            style: Theme.of(context).textTheme.blackS14W500,
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (isChecked) {
                            ///
                            setStateT(() {
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
                onPressed: () {
                  if (items.where((e) => e.isSelected!).toList().isEmpty) {
                    _validationDialog();
                    return;
                  }
                  selectedItems = items.where((e) => e.isSelected!).toList();

                  widget.onChanged.call(
                    selectedItems.map((e) => e.id!).toList(),
                    selectedItems,
                  );

                  setState(() {
                    selectedName = _selectedName(selectedItems);
                  });
                  Navigator.pop(context);
                },
                child: const Text('Apply'),
              ),
            ],
          );
        });
      },
    );
  }

  void _validationDialog() {
    CustomDialog.dialog(context,
        title: Text(
          "Validation Failed.",
          style: Theme.of(context).textTheme.redS17W700,
        ),
        content: Text(
          "At least one company is selected.",
          style: Theme.of(context).textTheme.blackS14W400,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'close'.toUpperCase(),
              style: Theme.of(context).textTheme.greyS14W400,
            ),
          ),
        ]);
  }

  String _selectedName(List<SelectFormModel> data) {
    return data.map((e) => e.name!).toList().join(", ");
  }
}
