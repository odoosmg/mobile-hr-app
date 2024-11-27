import 'package:flutter/material.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/SaleActivity/Customer/customer_model.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Customer/type_ahead_item.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Fields/custom_type_ahead.dart';
import 'package:hrm_employee/utlis/app_trans.dart';

/// **** Distribor or Customer type ****

class SelectDistrCusttype extends StatefulWidget {
  final int? initId;
  final KSelectType type; // work only 2 types. Distributor and CustomerType
  final Function(CustomerModel) onSelect;
  final Function()? onClear;
  const SelectDistrCusttype({
    super.key,
    this.initId,
    required this.type,
    required this.onSelect,
    this.onClear,
  });

  @override
  State<SelectDistrCusttype> createState() => _SelectDistrCusttypeState();
}

class _SelectDistrCusttypeState extends State<SelectDistrCusttype> {
  // final CustomerController customerController = Get.find<CustomerController>();

  final TextEditingController typeAheadTEC = TextEditingController();

  List<CustomerModel> data = <CustomerModel>[];
  @override
  void initState() {
    /// Dist or Customer
    if (widget.type == KSelectType.distributor) {
      _getDistributor();
    } else {
      _getCustomerType();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _field();
  }

  Widget _field() {
    return CustomTypeAhead<CustomerModel>(
        title: widget.type == KSelectType.distributor
            ? AppTrans.t.distributor
            : "Customer type",
        isRequired: true,
        controller: typeAheadTEC,
        onClear: widget.type == KSelectType.distributor
            ? () {
                typeAheadTEC.clear();
                widget.onSelect.call(CustomerModel());
              }
            : null,
        itemBuilder: (context, data) {
          return TypeAheadItem(name: data.name ?? "");
        },
        suggestionsCallback: (str) {
          return _filter(str);
        },
        onSelected: (d) {
          typeAheadTEC.text = d.name ?? "";

          /// call back
          widget.onSelect.call(d);
        });
  }

  /// filter
  List<CustomerModel> _filter(String query) {
    // ignore: invalid_use_of_protected_member
    List<CustomerModel> matches = [...data];
    matches.retainWhere(
        (d) => d.name!.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  Future<void> _getDistributor() async {
    ///
    // await customerController.distributorList().then((value) {
    //   if (value.isSuccess) {
    //     if (widget.initId != null) {
    //       typeAheadTEC.text = value.data!.list!
    //               .where((d) => d.id == widget.initId)
    //               .first
    //               .name ??
    //           "";
    //     }
    //     data(value.data!.list);
    //   }
    // });
  }

  ///
  Future<void> _getCustomerType() async {
    ///
    // await customerController.customerTypeList().then((value) {
    //   if (value.isSuccess) {
    //     if (widget.initId != null) {
    //       typeAheadTEC.text = value.data!.list!
    //               .where((d) => d.id == widget.initId)
    //               .first
    //               .name ??
    //           "";
    //     }
    //     data(value.data!.list);
    //   }
    // });
  }
}
