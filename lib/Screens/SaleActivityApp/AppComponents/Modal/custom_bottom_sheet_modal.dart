import 'package:flutter/material.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/app_trans.dart';
import 'package:hrm_employee/utlis/measurement.dart';
import 'package:hrm_employee/utlis/measurement_widget_extension.dart';

class CustomBotttomSheetModal {
  final BuildContext context;
  CustomBotttomSheetModal(this.context);

  Future closeTitle({
    required String title,
    required Widget child,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet(
      context: context,
      enableDrag: enableDrag,
      isScrollControlled: true,
      builder: (BuildContext ctx) {
        return FractionallySizedBox(
          heightFactor: 0.95,
          widthFactor: 1,
          child: Column(
            children: [
              Measurement.screenPadding.kHeight,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: Measurement.screenPadding),
                      width: 50,
                      height: 30,
                      alignment: Alignment.center,
                      child: Text(
                        AppTrans.t.close,
                        style: Theme.of(context).textTheme.greyS17W700,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: Measurement.screenPadding),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.blackS17W700,
                    ),
                  ),

                  /// space for middle
                  Text(""),
                ],
              ),

              6.kHeight,

              ///
              child
            ],
          ),
        );
      },
    );
  }
}
