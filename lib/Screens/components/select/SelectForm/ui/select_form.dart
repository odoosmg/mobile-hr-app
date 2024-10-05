// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/constant.dart';
import 'package:hrm_employee/Screens/components/select/SelectForm/cubit/select_form_cubit.dart';
import 'package:hrm_employee/Models/form/select_form_model.dart';

class SelectForm extends StatefulWidget {
  final List<SelectFormModel> data;
  final String labelText;
  final int? initId;
  final Function(SelectFormModel) onSelect;
  const SelectForm({
    super.key,
    required this.data,
    required this.labelText,
    required this.onSelect,
    this.initId,
  });

  @override
  State<SelectForm> createState() => _SelectFormState();
}

class _SelectFormState extends State<SelectForm> {
  final cubit = SelectFormCubit();

  SelectFormModel? selectedItem;

  @override
  void initState() {
    /// init id
    if (widget.initId != null && widget.data.isNotEmpty) {
      selectedItem = widget.data
          .where((element) => element.id == widget.initId)
          .singleOrNull;
      cubit.select(selectedItem);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _select();
  }

  ///
  Widget _select() {
    return SizedBox(
      height: 66.0,
      child: FormField(
        builder: (FormFieldState<SelectFormModel> field) {
          return InputDecorator(
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              isCollapsed: true,
              contentPadding: const EdgeInsets.all(16),
              labelText: widget.labelText,
              labelStyle: kTextStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),

            /// ** Bloc
            child: BlocBuilder<SelectFormCubit, SelectFormModel?>(
              bloc: cubit,
              builder: (context, state) {
                selectedItem = state;
                return DropdownButtonHideUnderline(
                  child: _dropdownItem(),
                );
              },
            ),
          );
        },
      ),
    );
  }

  ///
  DropdownButton<SelectFormModel> _dropdownItem() {
    List<DropdownMenuItem<SelectFormModel>> dropDownItems = widget.data
        .map((e) => DropdownMenuItem(
              value: e,
              child: Text(e.name!),
            ))
        .toList();

    return DropdownButton(
      items: dropDownItems,
      value: selectedItem,
      onChanged: (value) {
        cubit.select(value!);
        widget.onSelect.call(value);
      },
    );
  }

  @override
  void dispose() {
    // context.read<SelectFormCubit>().select(null);
    super.dispose();
  }
}
