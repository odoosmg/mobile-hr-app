import 'package:flutter/material.dart';
import 'package:hrm_employee/Models/SaleActivity/Sale/sales_model.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Others/cus_card.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Others/cus_card_status.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/measurement.dart';
import 'package:hrm_employee/utlis/measurement_widget_extension.dart';

class SaleCell extends StatelessWidget {
  final Function()? onTap;
  final SalesModel data;
  const SaleCell({super.key, required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CusCard(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: Measurement.widthPercent(context, 0.5),

                  /// customer name
                  child: Text(
                    data.customerName ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.blackS15W700NoChange,
                  ),
                ),

                /// status
                CusCardStatus(
                  background: data.getActivityStatus!.bgColor,
                  child: Text(
                    data.status ?? "",
                    style: Theme.of(context).textTheme.whiteS13W400NoChange,
                  ),
                ),
              ],
            ),
            4.kHeight,

            /// Address
            // SizedBox(
            //   width: Measurement.widthPercent(context, 0.6),
            //   child: Text(
            //     data.address ?? '',
            //     maxLines: 1,
            //     overflow: TextOverflow.ellipsis,
            //     style:Theme.of(context).textTheme.blackS15W400NoChange,
            //   ),
            // ),
            // 2.height,

            /// location
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Icon(
                    Icons.location_on_sharp,
                    color: Colors.black54,
                    size: 18,
                  ),
                ),
                3.kPdRight,
                SizedBox(
                  width: Measurement.widthPercent(context, 0.7),
                  child: Text(
                    data.address ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.blackS15W400NoChange,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
