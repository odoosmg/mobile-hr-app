import 'package:flutter/material.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Button/main_appbar_btn_icon.dart';
import 'package:hrm_employee/utlis/app_color.dart';

class ProductBtnAdd extends StatefulWidget {
  final BtnStatus status;
  final Function()? onpressed;
  const ProductBtnAdd({super.key, required this.status, this.onpressed});

  @override
  State<ProductBtnAdd> createState() => _ProductBtnAddState();
}

class _ProductBtnAddState extends State<ProductBtnAdd> {
  @override
  Widget build(BuildContext context) {
    return MainAppbarBtnIcon(
      height: 45,
      width: 100,
      background: widget.status == BtnStatus.ok
          ? Colors.green.shade700
          : AppColor.saGrey,
      iconData: Icons.add_shopping_cart_rounded,
      onPressed: () {
        ///
        if (widget.status != BtnStatus.ok) {
          return;
        }

        widget.onpressed?.call();
      },
    );
  }
}
