import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/GlobalComponents/bloc/form-data/form_data_bloc.dart';
import 'package:hrm_employee/GlobalComponents/dialog/custom_dialog.dart';
import 'package:hrm_employee/Models/form/select_form_model.dart';
import 'package:hrm_employee/Repository/form_data_repository.dart';
import 'package:hrm_employee/Screens/components/kbuilder/k_builder.dart';
import 'package:hrm_employee/Services/app_services.dart';
import 'package:hrm_employee/Services/database_service.dart';
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

  List<SelectFormModel> items = [];

  late FormDataBloc formDataBloc;

  List<SelectFormModel> selectedItems = [];

  @override
  void initState() {
    // selectedItems = [items[0], items[1]];
    // selectedName = _selectedName(selectedItems);

    formDataBloc = context.read<FormDataBloc>();
    formDataBloc.add(FormDataCompanyList(false));
    selectedName = _selectedName([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /// selected id
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
              child: BlocConsumer<FormDataBloc, FormDataState>(
                // bloc: FormDataBloc(FormDataRepository()),
                listener: (context, state) {
                  print("liten ===== $state");
                },
                buildWhen: (previous, current) {
                  print("build ======");
                  return current.stateType == FormDataStateType.companyList;
                },
                builder: (context, state) {
                  return KBuilder(
                    status: state.companyList!.status!,
                    builder: (st) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: state.companyList!.data!
                            .map(
                              (e) => CheckboxListTile(
                                  value: e.isSelected,
                                  // checkColor: ,
                                  fillColor:
                                      MaterialStateColor.resolveWith((states) {
                                    return e.isSelected!
                                        ? AppColor.kMainColor
                                        : Colors.transparent;
                                  }),
                                  title: Text(
                                    e.name!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .blackS14W500,
                                  ),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  onChanged: (isChecked) {
                                    ///
                                    setStateT(() {
                                      e.isSelected = !e.isSelected!;
                                    });
                                  }),
                            )
                            .toList(),
                      );
                    },
                  );
                },
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

                  /// Update box
                  SelectFormModel box =
                      AppServices.instance<DatabaseService>().getFormData ??
                          SelectFormModel();
                  box.companySelected = selectedItems;
                  AppServices.instance<DatabaseService>().putFormData(box);

                  ///
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
    if (data.isEmpty) {
      return "Select company";
    }
    return data.map((e) => e.name!).toList().join(", ");
  }
}
