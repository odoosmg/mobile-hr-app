import 'package:flutter/material.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/app_color.dart';

class CustomDialog {
  ///
  static Future dialog(
    BuildContext context, {
    Widget? title,
    Widget? content,
    List<Widget>? actions,
  }) {
    return animation(
        context: context,
        child: AlertDialog(
          title: title,
          content: content,
          actions: actions,
        ));
  }

  static Future error(
    BuildContext context, {
    int? errCode,
    String? errMsg,
  }) {
    return animation(
      context: context,
      child: AlertDialog(
        icon: const Icon(
          Icons.error,
          size: 40,
          color: AppColor.kDangerColor,
        ),
        title: Text(
          "Error $errCode",
          style: Theme.of(context).textTheme.redS17W7500,
        ),
        content: Text(
          errMsg ?? '',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.greyS15W400,
        ),
        actions: [
          /// use naviator, able to close current dialog
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'close'.toUpperCase(),
              style: Theme.of(context).textTheme.greyS14W400,
            ),
          ),
        ],
      ),
    );
  }

  static Future success(
    BuildContext context,
    String? msg,
  ) {
    return animation(
      context: context,
      child: AlertDialog(
        icon: Icon(
          Icons.check_circle_outline,
          size: 40,
          color: Colors.green.shade500,
        ),
        content: Text(
          msg ?? '',
          textAlign: TextAlign.center,
          // style: Get.textTheme.blackS15W400,
          style: Theme.of(context).textTheme.blackS15W400,
        ),
        actions: [
          /// use naviator, able to close current dialog
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "close".toUpperCase(),
              style: Theme.of(context).textTheme.greyS14W400,
            ),
          ),
        ],
      ),
    );
  }

  /// Has animation
  static Future animation({
    required BuildContext context,
    Widget? child,
    bool barrierDismissible = true,
  }) {
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: barrierDismissible,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });
  }
}
