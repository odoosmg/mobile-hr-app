import 'package:flutter/material.dart';
import 'package:hrm_employee/GlobalComponents/others/loading_inidicator.dart';

class CustomLoading {
  static bool isShown = false;

  static Future show(BuildContext context) {
    isShown = true;

    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) {
        return Center(child: CustomCircularProgressindicator());
      },
    );
  }

  static hide(BuildContext context) {
    if (isShown) {
      isShown = false;
      // if (context != null) {
      //   return Navigator.pop(context);
      // }

      return Navigator.pop(context);

      /// close dialog
      // return Get.back(id: 1);
    }
  }
}
