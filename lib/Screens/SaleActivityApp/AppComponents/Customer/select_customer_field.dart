import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hrm_employee/Models/SaleActivity/Customer/customer_model.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Fields/custom_type_ahead.dart';
import 'package:hrm_employee/utlis/app_trans.dart';
import 'package:hrm_employee/utlis/measurement.dart';

class SelectCustomerField extends StatefulWidget {
  final Function(CustomerModel) onSelected;
  final String? initName;
  const SelectCustomerField({
    super.key,
    required this.onSelected,
    this.initName,
  });

  @override
  State<SelectCustomerField> createState() => _SelectCustomerFieldState();
}

class _SelectCustomerFieldState extends State<SelectCustomerField> {
  // final CustomerController customerController = Get.find<CustomerController>();

  Timer? _debounceTimer;
  String selectedName = '';
  List<CustomerModel> data = <CustomerModel>[];

  TextEditingController typeAheadTEC = TextEditingController();

  @override
  void initState() {
    // _getCustomer("");
    if (widget.initName != null) {
      typeAheadTEC.text = widget.initName!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: invalid_use_of_protected_member
    return _field(data);
  }

  Widget _field(List<CustomerModel> list) {
    return CustomTypeAhead<CustomerModel>(
        title: AppTrans.t.customer,
        isRequired: true,
        controller: typeAheadTEC,
        onChanged: (text) {},
        itemBuilder: (context, d) {
          return Container(
            alignment: Alignment.centerLeft,
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.grey.shade500,
                  height: 1,
                  width: double.infinity,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 14, left: Measurement.screenPadding),
                  child: Text(d.name ?? ""),
                )
              ],
            ),
          );
        },
        suggestionsCallback: (str) async {
          return await _getCustomer(str);
        },
        onSelected: (d) {
          selectedName = d.name!;
          typeAheadTEC.text = d.name ?? "";
          widget.onSelected.call(d);
        });
  }

  _onTypingFinished(String text) {
    if (_debounceTimer != null) {
      _debounceTimer!.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      // Call your callback function here
      // print('Typing finished: $text');
      _getCustomer(text);
    });
  }

  Future<List<CustomerModel>> _getCustomer(String text) async {
    return [];
    // return await customerController.search(text).then((value) {
    //   data.value = value.data?.list ?? [];
    //   // ignore: invalid_use_of_protected_member
    //   return data.value;
    // });
  }
}
