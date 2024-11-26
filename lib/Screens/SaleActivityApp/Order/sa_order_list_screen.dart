import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Button/main_appbar_btn_icon.dart';
import 'package:hrm_employee/Screens/components/appbar/custom_appbar.dart';
import 'package:hrm_employee/utlis/app_color.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({super.key});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  final EasyRefreshController easyRefreshController = EasyRefreshController(
      controlFinishLoad: true, controlFinishRefresh: true);

  @override
  void initState() {
    // _onRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.titleActions(
        title: "Order",
        actions: [
          MainAppbarBtnIcon(
            iconData: Icons.add_shopping_cart,
            onPressed: () {
              //  Get.toNamed(OrderAddUpdatePage.route)
            },
          )
        ],
      ),
      body: Container(),
      // body: GetBuilder<OrderController>(
      //   builder: (builder) {
      //     return KBuilder(
      //       status: orderController.listResult.status!,
      //       onRetry: () {
      //         orderController.listResult.status!(ApiStatus.loading);
      //         _onRefresh();
      //       },
      //       builder: (status) {
      //         return status == ApiStatus.loading ? Container() : _easyRefresh();
      //       },
      //     );
      //   },
      // ),
    );
  }

/*
  Widget _easyRefresh() {
    return CustomEasyRefresh(
      controller: easyRefreshController,
      onRefresh: _onRefresh,
      onLoad: _onLoad,
      child: _listView(),
    );
  }
*/

/*
  ListView _listView() {
    int count = orderController.listResult.data?.list?.length ?? 0;
    List<OrdersModel> data = orderController.listResult.data?.list ?? [];
    return ListView.builder(
        itemCount: count,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              top: Measurement.screenPadding,
              left: Measurement.screenPadding,
              right: Measurement.screenPadding,

              /// list item space bottom
              bottom: index == data.length - 1 ? 20 : 0,
            ),
            child: OrderCell(
              data: data[index],
              onTap: () {
                if (data[index].getStatus == OrderStatus.quotation) {
                  /// update
                  Get.toNamed(
                    OrderAddUpdatePage.route,
                    arguments: [data[index]],
                  );
                } else {
                  /// detail
                  Get.toNamed(
                    OrderDetailPage.route,
                    arguments: [data[index].id],
                  );
                }
              },
            ),
          );
        });
  }
*/
  ///=================================================================
  ///
  ///=================================================================
/*
  void _onRefresh() {
    orderController.getList().then((value) {
      if (value.isSuccess) {
        easyRefreshController.finishRefresh(IndicatorResult.success);
        easyRefreshController.resetFooter();
      } else {
        easyRefreshController.finishRefresh(IndicatorResult.fail);
      }
    });
  }
*/

/*
  void _onLoad() {
    /// page = totalpages.
    /// No need to retrieve more
    if (orderController.listResult.data!.page ==
        orderController.listResult.data!.totalPages) {
      easyRefreshController.finishLoad(IndicatorResult.noMore);
      return;
    }
    orderController.getList(true).then((value) {
      if (value.isSuccess) {
        easyRefreshController.finishLoad(IndicatorResult.success);
      } else {
        easyRefreshController.finishLoad(IndicatorResult.fail);
      }
    });
  }
*/

/*
  @override
  void dispose() {
    orderController.listResult.status!(ApiStatus.loading);
    orderController.listResult.data = OrdersModel();
    super.dispose();
  }
*/
}
