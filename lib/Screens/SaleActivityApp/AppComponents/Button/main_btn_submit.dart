import 'package:flutter/material.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/app_color.dart';
import 'package:hrm_employee/utlis/measurement.dart';

class MainBtnSubmit extends StatelessWidget {
  final String title;
  final BtnStatus status;
  final Function() onPressed;
  final double? width;
  final Widget? loading;
  const MainBtnSubmit({
    super.key,
    required this.title,
    required this.status,
    required this.onPressed,
    this.width,
    this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return status == BtnStatus.loading ? _loading() : _btn(context);
  }

  Widget _btn(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Measurement.cardBorderRadius),
          ),
          // Foreground color
          foregroundColor: AppColor.kWhiteColor,
          backgroundColor: status == BtnStatus.ok
              ? AppColor.saMain
              : AppColor.kGreyTextColor,
        ).copyWith(
          // foregroundColor: const WidgetStatePropertyAll(AppColor.white),
          // backgroundColor: const WidgetStatePropertyAll(AppColor.grey),
          elevation: ButtonStyleButton.allOrNull(0.1),
        ),
        onPressed: status == BtnStatus.ok ? onPressed : null,

        /// Title
        child: Text(
          title,
          style: Theme.of(context).textTheme.whiteS15W500,
        ),
      ),
    );
  }

  Widget _loading() {
    return loading ??
        const Center(
          child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(
              color: AppColor.saMain,
            ),
          ),
        );
  }
}
