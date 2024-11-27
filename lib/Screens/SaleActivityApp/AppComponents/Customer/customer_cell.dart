import 'package:flutter/material.dart';
import 'package:hrm_employee/Models/SaleActivity/Customer/customer_model.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Others/cus_card.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/app_color.dart';
import 'package:hrm_employee/utlis/measurement.dart';
import 'package:hrm_employee/utlis/measurement_widget_extension.dart';

class CustomerCell extends StatelessWidget {
  final CustomerModel data;
  final Function()? onTap;
  const CustomerCell({
    super.key,
    required this.data,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CusCard(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: Measurement.screenPadding, top: 10),
                  child: SizedBox(
                    width: Measurement.widthPercent(context, 0.55),

                    /// Name
                    child: Text(
                      data.name ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.blackS15W700NoChange,
                    ),
                  ),
                ),

                ///
                if ((data.customerType ?? "").isNotEmpty) _smallCard(context)
              ],
            ),

            if ((data.phone ?? "").isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: Measurement.screenPadding),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Phone
                    Flexible(
                      flex: 0,
                      child: Text(
                        data.phone!,
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.greyS15W400,
                      ),
                    ),

                    if ((data.email ?? "").isNotEmpty)
                      Flexible(
                        flex: 3,
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: Measurement.gap,
                                  right: Measurement.gap),
                              child: Icon(
                                Icons.circle_rounded,
                                size: 6,
                                color: Colors.grey,
                              ),
                            ),

                            /// Email
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: Measurement.screenPadding),
                                child: Text(
                                  data.email!,
                                  // textAlign: TextAlign.right,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style:
                                      Theme.of(context).textTheme.greyS15W400,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                  ],
                ),
              ),

            /// location
            // if ((data.customerType ?? "").isNotEmpty)
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    left: Measurement.screenPadding,
                    bottom: 4,
                    right: Measurement.gap,
                  ),
                  child: Icon(
                    Icons.location_on_sharp,
                    size: 18,
                    color: AppColor.saGrey,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 2),
                  width: Measurement.widthPercent(context, 0.7),
                  child: Text(
                    data.address ?? "",
                    style: Theme.of(context).textTheme.greyS15W400,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),

            10.kHeight
          ],
        ),
      ),
    );
  }

  Padding _smallCard(BuildContext context) {
    return Padding(
      /// padding with card
      padding: const EdgeInsets.only(bottom: 6),
      child: CusCard(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 4),
        width: null,
        background: Colors.grey.shade300,
        boxShadow: const [],
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(Measurement.cardRadius),
            bottomLeft: Radius.circular(Measurement.cardRadius)),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 4),

          /// Pharmacy Name
          child: Text(
            data.customerType!,
            style: Theme.of(context).textTheme.blackS13W400NoChange,
          ),
        ),
      ),
    );
  }
}
