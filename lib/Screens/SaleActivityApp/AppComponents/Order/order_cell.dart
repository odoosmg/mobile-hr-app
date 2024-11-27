import 'package:flutter/material.dart';
import 'package:hrm_employee/Models/SaleActivity/Order/orders_model.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Others/cus_card.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Others/cus_card_status.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/app_color.dart';
import 'package:hrm_employee/utlis/measurement.dart';
import 'package:hrm_employee/utlis/measurement_widget_extension.dart';

class OrderCell extends StatelessWidget {
  final OrdersModel data;
  final Function()? onTap;

  const OrderCell({super.key, required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CusCard(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Phamacy name and price
            _top(context),
            2.kHeight,

            /// Date
            _middle(context),
            2.kHeight,

            /// Address
            _bottom(context),

            4.kPdBottom,
          ],
        ),
      ),
    );
  }

  Row _top(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Phamacy Name
        SizedBox(
          width: Measurement.widthPercent(context, 0.6),
          child: Text(
            data.partnerName ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.blackS15W700NoChange,
          ),
        ),

        /// Price
        Expanded(
          child: Text(
            "${data.amount}\$",
            textAlign: TextAlign.right,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.blackS15W700,
          ),
        ),
      ],
    );
  }

  Widget _middle(BuildContext context) {
    return SizedBox(
      width: Measurement.widthPercent(context, 0.6),
      child: Row(
        children: [
          /// Date Order
          Text(
            data.dateOrder ?? "",
            style: Theme.of(context).textTheme.greyS15W400,
          ),
          const Padding(
            padding:
                EdgeInsets.only(left: Measurement.gap, right: Measurement.gap),
            child: Icon(
              Icons.circle_rounded,
              color: AppColor.kGreyTextColor,
              size: 6,
            ),
          ),

          /// Delivery date
          Text(
            data.deliveryDate ?? "",
            style: Theme.of(context).textTheme.greyS15W400,
          ),
        ],
      ),
    );
  }

  Widget _bottom(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Icon(
                Icons.location_on_sharp,
                size: 18,
                color: AppColor.saGrey,
              ),
            ),
            3.kPdRight,

            /// Address
            SizedBox(
              width: Measurement.widthPercent(context, 0.5),
              child: Text(
                data.deliveryAddress ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.greyS15W400,
              ),
            ),
          ],
        ),

        /// Status
        CusCardStatus(
          background: data.getStatus.bgColor,
          child: Text(
            data.statusValue ?? "",
            style: Theme.of(context).textTheme.whiteS13W400,
          ),
        ),
      ],
    );
  }
}
