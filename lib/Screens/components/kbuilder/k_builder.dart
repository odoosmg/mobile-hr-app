import 'package:hrm_employee/GlobalComponents/button/main_btn.dart';
import 'package:hrm_employee/GlobalComponents/others/loading_inidicator.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:flutter/material.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/app_color.dart';
import 'package:hrm_employee/utlis/app_trans.dart';
import 'package:hrm_employee/utlis/measurement_widget_extension.dart';

class KBuilder extends StatelessWidget {
  final ApiStatus status;
  final Widget Function(ApiStatus) builder;

  final Widget? loading;
  final Widget? empty;
  final Widget? failed;
  final Widget? connectionError;

  /// display when not null
  final Function? onRetry;

  const KBuilder({
    super.key,
    required this.status,
    required this.builder,
    this.loading,
    this.empty,
    this.failed,
    this.connectionError,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    // return BlocProvider(
    //   create: (_) => KBuilderCubit(),
    //   child: _child(context.read<KBuilderCubit>().state),
    // );
    return _child(context, status);
  }

  Widget _child(BuildContext context, ApiStatus st) {
    switch (st) {
      case ApiStatus.loading:
        return _loading();
      case ApiStatus.success:
        return builder(st);
      case ApiStatus.connectionError:
        return _connectionErr(context);
      case ApiStatus.loginExpired:
        // Get.offAllNamed(LoginPage.route);
        return Container();
      case ApiStatus.empty:
        return _empty(context);
      default:
        return _failed(context);
    }
  }

  Widget _loading() {
    return _center(
        child: loading ??
            const SizedBox(
              height: 60,

              /// somehow, Column is fixed size too big inidicator
              child: Column(
                children: [
                  Center(
                      child: CustomCircularProgressindicator(
                    color: AppColor.kMainColor,
                  ))
                ],
              ),
            ));
  }

  Widget _failed(BuildContext context) {
    return failed ??
        _retry(
          context: context,
          text: AppTrans.t.processFailedMsg,
          iconData: Icons.error_outline,
        );
  }

  Widget _connectionErr(BuildContext context) {
    return connectionError ??
        _retry(
            context: context,
            text: AppTrans.t.connectionErrMsg,
            iconData: Icons.wifi_off);
  }

  Widget _empty(BuildContext context) {
    return _center(
      child: empty ??
          Center(
            child: Column(
              children: [
                // AppAssets.icons.emptyFolder.image(
                //   width: 100,
                //   color: AppColor.grey,
                // ),
                Text(
                  AppTrans.t.emptyContent,
                  style: Theme.of(context).textTheme.greyS15W400,
                ),
              ],
            ),
          ),
    );
  }

  Widget _center({required Widget child}) {
    return Container(
      // heightFactor: 3,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(
        top: 50,
      ),
      child: child,
    );
  }

  Widget _retry(
      {required BuildContext context,
      required String text,
      required IconData iconData}) {
    return _center(
        child: Column(
      children: [
        Icon(
          iconData,
          size: 30,
          color: AppColor.kGreyTextColor,
        ),
        10.kHeight,
        Text(text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.greyS15W400),
        10.kHeight,
        if (onRetry != null)
          SizedBox(
            width: 150,
            child: MainBtn(
              title: AppTrans.t.retry,
              titleStyle: Theme.of(context).textTheme.whiteS14W700,
              onPressed: () {
                onRetry!.call();
              },
            ),
          )
      ],
    ));
  }
}
