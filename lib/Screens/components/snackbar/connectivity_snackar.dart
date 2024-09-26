import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'package:hrm_employee/Services/app_services.dart';
import 'package:hrm_employee/Services/global_scaffold_messenger_service.dart';
import 'package:hrm_employee/Services/navigation_service.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/app_color.dart';
import 'package:hrm_employee/utlis/app_trans.dart';

class ConnectivitySnackbar {
  static bool isShow = false;
  static BuildContext context =
      AppServices.instance<NavigatorService>().getCurrentContext;

  static void online() {
    AppServices.instance<GlboalScaffoldMessengerState>()
        .key
        .currentState!
        .showSnackBar(
            SnackBar(duration: Duration(days: 1), content: Text("EEE aaa")));
    return;
    // if (isShow) {
    //   hide();
    // }
    defaultSnackbar(
      backgroundColor: AppColor.kGreenColor,
      iconData: Icons.wifi,
      msg: AppTrans.t.connectionOnlineMsg,
      duration: const Duration(seconds: 5),
    );
  }

  static void offline() {
    return;
    isShow = true;
    defaultSnackbar(
      backgroundColor: AppColor.kDangerColor,
      iconData: Icons.wifi_off_outlined,
      msg: AppTrans.t.connectionErrMsg,
      duration: const Duration(days: 1),
    );
  }

  static void defaultSnackbar({
    required Color backgroundColor,
    required IconData iconData,
    required String msg,
    required Duration duration,
  }) {
    Flushbar(
      isDismissible: false,
      backgroundColor: backgroundColor,
      animationDuration: const Duration(seconds: 1),
      forwardAnimationCurve: Curves.easeIn,
      reverseAnimationCurve: Curves.easeOut,
      duration: duration,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      titleText: Icon(
        iconData,
        color: Colors.white,
        size: 24,
      ),
      messageText: Text(
        msg,
        style: Theme.of(context).textTheme.whiteS13W700,
        textAlign: TextAlign.center,
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
    );
  }

  static void hide() {
    if (isShow) {
      isShow = false;
      Navigator.pop(context);
    }
  }
}
