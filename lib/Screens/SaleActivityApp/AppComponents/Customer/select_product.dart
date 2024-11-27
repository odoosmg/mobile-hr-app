import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hrm_employee/Models/SaleActivity/Order/product_model.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Customer/type_ahead_item.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Fields/custom_type_ahead.dart';
import 'package:hrm_employee/utlis/app_trans.dart';

class SelectProduct extends StatefulWidget {
  final Function(ProductModel) onSelected;
  final String? initName;
  final bool isClearName;
  const SelectProduct({
    super.key,
    required this.onSelected,
    this.initName,
    this.isClearName = false,
  });

  @override
  State<SelectProduct> createState() => _SelectProductState();
}

class _SelectProductState extends State<SelectProduct> {
  // final CustomerController customerController = Get.find<CustomerController>();

  String selectedName = '';
  List<ProductModel> data = <ProductModel>[];

  TextEditingController typeAheadTEC = TextEditingController();

  @override
  void initState() {
    // if (widget.initName != null) {
    //   typeAheadTEC.text = widget.initName!;
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: invalid_use_of_protected_member
    return _field(data);
  }

  Widget _field(List<ProductModel> list) {
    return CustomTypeAhead<ProductModel>(
        title: AppTrans.t.product,
        controller: typeAheadTEC,
        onChanged: (text) {},
        itemBuilder: (context, d) {
          return TypeAheadItem(name: d.name ?? "");
        },
        suggestionsCallback: (str) async {
          return await _getList(str);
        },
        onSelected: (d) {
          // selectedName(d.name);
          typeAheadTEC.text = d.name ?? "";
          widget.onSelected.call(d);
        });
  }

  Future<List<ProductModel>> _getList(String text) async {
    return [];
    // return await customerController.productList(text).then((value) {
    //   data.value = value.data?.list ?? [];
    //   // ignore: invalid_use_of_protected_member
    //   return data.value;
    // });
  }
}
