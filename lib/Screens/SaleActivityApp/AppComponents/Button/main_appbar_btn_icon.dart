import 'package:flutter/material.dart';
import 'package:hrm_employee/utlis/app_color.dart';

class MainAppbarBtnIcon extends StatelessWidget {
  final Function()? onPressed;
  final IconData iconData;
  final double width;
  final double height;
  final Color background;
  const MainAppbarBtnIcon({
    super.key,
    required this.iconData,
    this.height = 40,
    this.width = 40,
    this.background = AppColor.kMainColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          elevation: 2,
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: background,
        ),
        child: Icon(
          iconData,
          size: 20,
          color: AppColor.kWhiteColor,
        ),
      ),
    );
  }
}
