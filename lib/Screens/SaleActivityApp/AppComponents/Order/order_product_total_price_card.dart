import 'package:flutter/material.dart';
import 'package:hrm_employee/GlobalComponents/dialog/custom_dialog.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Fields/customer_textfield.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Others/cus_card.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/app_trans.dart';
import 'package:hrm_employee/utlis/measurement.dart';

class OrderProductTotalPriceCard extends StatefulWidget {
  final double subTotal;
  final double discount;
  final double total;
  final Color? background;
  final Function(double)? onDiscount;
  const OrderProductTotalPriceCard({
    super.key,
    required this.subTotal,
    required this.discount,
    required this.total,
    this.background,
    this.onDiscount,
  });

  @override
  State<OrderProductTotalPriceCard> createState() =>
      _OrderProductTotalPriceCardState();
}

class _OrderProductTotalPriceCardState
    extends State<OrderProductTotalPriceCard> {
  final TextEditingController discTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _calculateProductPrice(context);
  }

  Widget _calculateProductPrice(BuildContext context) {
    return CusCard(
      background: widget.background ?? Colors.grey.shade400,
      child: Column(
        children: [
          /// subtotal
          _rowSpaceBetween(
              AppTrans.t.subTotal.toUpperCase(), "${widget.subTotal}\$"),
          // Measurement.screenPadding.height,

          /// discount
          // _rowSpaceBetween(AppTrans.t.discount.toUpperCase(), "$discount%"),
          // Measurement.screenPadding.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppTrans.t.discount.toUpperCase(),
                style: Theme.of(context).textTheme.blackS13W400,
              ),
              InkWell(
                onTap: () {
                  CustomDialog.dialog(
                    context,
                    title: CustomTextField(
                      title: "Discount",
                      hintText: "Enter discount",
                      keyboardType: TextInputType.number,
                      controller: discTEC,
                    ),
                    actions: [
                      /// Cancel
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          AppTrans.t.cancel.toUpperCase(),
                          style: Theme.of(context).textTheme.greyS14W400,
                        ),
                      ),

                      /// Submit
                      TextButton(
                        onPressed: () {
                          if (widget.onDiscount != null) {
                            double d = 0;
                            if (discTEC.text.isNotEmpty) {
                              d = double.parse(discTEC.text);
                            }
                            widget.onDiscount!.call(d);
                          }
                          Navigator.pop(context);
                        },
                        child: Text(
                          AppTrans.t.submit.toUpperCase(),
                          style: Theme.of(context).textTheme.blackS15W700,
                        ),
                      )
                    ],
                  );
                },
                child: Container(
                  alignment: Alignment.centerRight,
                  // color: Colors.red,
                  width: Measurement.widthPercent(context, 0.4),
                  height: 50,
                  child: Text(
                    "${widget.discount}%",
                    style: Theme.of(context).textTheme.blackS13W700,
                  ),
                ),
              )
            ],
          ),

          /// total
          _rowSpaceBetween(AppTrans.t.total.toUpperCase(), "${widget.total}\$"),
        ],
      ),
    );
  }

  Widget _rowSpaceBetween(String text1, String text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: Theme.of(context).textTheme.blackS13W400,
        ),
        Text(
          text2,
          style: Theme.of(context).textTheme.blackS13W700,
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
