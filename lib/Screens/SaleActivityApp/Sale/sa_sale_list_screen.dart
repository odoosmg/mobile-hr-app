import 'package:flutter/material.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/Sale/sa_sale_activity_detail_screen.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/Sale/sa_sale_checkin_screen.dart';
// ignore: unused_import
import 'package:nb_utils/nb_utils.dart';
import 'package:hrm_employee/Models/SaleActivity/Sale/sales_model.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Button/main_appbar_btn_icon.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Sale/sale_cell.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Sale/sale_table_calendar.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/Sale/sa_sale_todo_checkin_screen.dart';
import 'package:hrm_employee/Screens/components/appbar/custom_appbar.dart';
import 'package:hrm_employee/utlis/app_color.dart';
import 'package:hrm_employee/utlis/app_trans.dart';
import 'package:hrm_employee/utlis/measurement_widget_extension.dart';
import 'package:intl/intl.dart';

import 'package:hrm_employee/extensions/textstyle_extension.dart';

class SASaleListPage extends StatefulWidget {
  const SASaleListPage({super.key});

  @override
  State<SASaleListPage> createState() => _SASaleListPageState();
}

class _SASaleListPageState extends State<SASaleListPage> {
  EasyRefreshController easyRefreshController =
      EasyRefreshController(controlFinishRefresh: true);

  DateTime date = DateTime.now();

  @override
  void initState() {
    // _onRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.titleActions(
        // backgroundColor: Colors.grey,
        title: AppTrans.t.saleActivity,
        actions: [
          MainAppbarBtnIcon(
              iconData: Icons.add,
              onPressed: () {
                // Get.toNamed(SaleCheckinPage.route, arguments: [date]),
              })
        ],
      ),
      body: Column(
        children: [
          /// Calendar

          SaleTableCalendar(
            onSelectedDate: (d) {
              /// to not call when click on the same date
              if (date == d) {
                return;
              }
              date = d;

              /// status to
              // saleController.listResult.status!(ApiStatus.loading);
              // saleController.update();
              // _onRefresh();
            },
          ),

          20.kHeight,

          InkWell(
              onTap: () {
                // SASaleTodoCheckinScreen().launch(context);
                // SASaleCheckinScreen().launch(context);
                SASaleActivityDetailScreen().launch(context);
              },
              child: SaleCell(data: SalesModel()..status = "todo")),

          /// Cell
          // GetBuilder<SaleController>(builder: (builder) {
          //   return KBuilder(
          //     status: saleController.listResult.status!,
          //     empty: _empty(),
          //     onRetry: () {
          //       saleController.listResult.status!(ApiStatus.loading);
          //       _onRefresh();
          //     },
          //     builder: (status) {
          //       return status == ApiStatus.loading
          //           ? Container()
          //           : _easyRefresh();
          //     },
          //   );
          // }),
        ],
      ),
    );
  }

  // Widget _easyRefresh() {
  //   return Expanded(
  //       child: CustomEasyRefresh(
  //     onRefresh: _onRefresh,
  //     controller: easyRefreshController,
  //     child: _listView(),
  //   ));
  // }

  // ListView _listView() {
  //   // int count = saleController.listResult.data?.list?.length ?? 0;
  //   List<SalesModel> data = saleController.listResult.data?.list ?? [];
  //   return ListView.builder(
  //       itemCount: data.length,
  //       itemBuilder: (context, index) {
  //         return Padding(
  //           padding: EdgeInsets.only(
  //             top: Measurement.screenPadding,
  //             left: Measurement.screenPadding,
  //             right: Measurement.screenPadding,

  //             /// list item space bottom
  //             bottom: index == data.length - 1 ? 20 : 0,
  //           ),
  //           child: SaleCell(
  //             data: data[index],
  //             onTap: () {
  //               if (data[index].getActivityStatus ==
  //                   SaleActivtyStatus.checkin) {
  //                 /// Sale checkout
  //                 Get.toNamed(SaleCheckoutPage.route, arguments: [data[index]]);
  //               } else {
  //                 /// Todo , goto checkin
  //                 if (data[index].getActivityStatus == SaleActivtyStatus.todo) {
  //                   Get.toNamed(
  //                     SaleCheckinPage2.route,
  //                     arguments: [data[index]],
  //                   );
  //                 } else {
  //                   /// Sale Detail
  //                   Get.toNamed(
  //                       arguments: [data[index].id],
  //                       SaleActivityDetailPage.route);
  //                 }
  //               }
  //             },
  //           ),
  //         );
  //       });
  // }

  // Column _empty() {
  //   return Column(
  //     children: [
  //       const Icon(
  //         Icons.coffee,
  //         color: AppColor.red,
  //         size: 50,
  //       ),
  //       Text(
  //         AppTrans.t.noTask,
  //         style: Get.textTheme.greyS15W400,
  //       )
  //     ],
  //   );
  // }

  // _onRefresh() async {
  //   String d = date.dateFormat(toFormat: "yyyy-MM-dd").toString();
  //   await saleController.getList(d, d).then((value) {
  //     if (value.isSuccess) {
  //       easyRefreshController.finishRefresh(IndicatorResult.success);
  //       easyRefreshController.resetFooter();
  //     } else {
  //       easyRefreshController.finishRefresh(IndicatorResult.fail);
  //     }
  //   });
  // }

  // @override
  // void dispose() {
  //   saleController.listResult.status!(ApiStatus.loading);
  //   saleController.listResult.data = SalesModel();
  //   super.dispose();
  // }
}
