import 'package:flutter/material.dart';
import 'package:hrm_employee/Models/SaleActivity/Order/orders_model.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Order/order_product_total_price_card.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Others/cus_card.dart';
import 'package:hrm_employee/Screens/components/appbar/custom_appbar.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/app_color.dart';
import 'package:hrm_employee/utlis/app_trans.dart';
import 'package:hrm_employee/utlis/measurement.dart';
import 'package:hrm_employee/utlis/measurement_widget_extension.dart';

class SAOrderDetailScreen extends StatefulWidget {
  static const route = '/order-detail';
  const SAOrderDetailScreen({super.key});

  @override
  State<SAOrderDetailScreen> createState() => _SAOrderDetailScreenState();
}

class _SAOrderDetailScreenState extends State<SAOrderDetailScreen> {
  // final OrderController orderController = Get.find<OrderController>();
  // final CustomerController customerController = Get.find<CustomerController>();

  OrdersModel data = OrdersModel();

  final int orderId = 0;

  String distributorName = "";

  @override
  void initState() {
    _getDetail();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.saTitleAction(title: AppTrans.t.orderDetail),
      // backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(
          left: Measurement.screenPadding,
          right: Measurement.screenPadding,
        ),
        child: _getBuilder(),
      )),
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Order date
        ..._text(AppTrans.t.orderDate, data.dateOrder ?? ""),

        /// Delivery date
        ..._text(AppTrans.t.deliveryDate, data.deliveryDate ?? ""),

        /// Customer name
        ..._text(AppTrans.t.customer, data.partnerName ?? ""),

        /// Address
        ..._text(AppTrans.t.deliveryAddress, data.deliveryAddress ?? ""),

        /// Remark
        ..._text(AppTrans.t.remark, data.note ?? ""),

        /// Distributor name
        // ..._text(AppTrans.t.distributor, data.partnerName ?? ""),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.kHeight,
            Text(
              AppTrans.t.distributor,
              style: Theme.of(context).textTheme.blackS15W500,
            ),
            Measurement.gap.kHeight,
            Text(
              distributorName,
              style: Theme.of(context).textTheme.blackS14W400,
            ),
          ],
        ),

        /// Product
        ..._product()
      ],
    );
  }

  List<Widget> _product() {
    return [
      20.kHeight,
      Text(
        AppTrans.t.product,
        style: Theme.of(context).textTheme.blackS15W500,
      ),
      4.kHeight,

      // _productCard(),
      ...((data.orderLines ?? [])
          .map((e) => _productCard(
                name: e.productName ?? "",

                ///
                price: e.getItemPrice,
                qty: e.productUomQty,
                foc: e.foc,
                discount: e.discount,
              ))
          .toList()),

      Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 30),
        child: OrderProductTotalPriceCard(
          subTotal: data.getSubTotal,
          discount: data.globalDiscount ?? 0,
          total: data.getTotalPrice,
        ),
      )
    ];
  }

  Widget _productCard(
      {required String name,
      double? price,
      double? discount,
      int? foc,
      int? qty}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: CusCard(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.blackS13W700NoChange,
            ),
            4.kHeight,
            _prdouctItem("Qty", (qty ?? 0).toString()),
            _prdouctItem("Price", "$price\$"),
            _prdouctItem("FOC", (foc ?? 0).toString()),
            _prdouctItem("Discount", "$discount%"),
          ],
        ),
      ),
    );
  }

  Widget _prdouctItem(String text1, text2) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(top: Measurement.gap),
          width: Measurement.widthPercent(context, 0.3),
          child: Text(
            text1,
            style: Theme.of(context).textTheme.blackS13W400NoChange,
          ),
        ),
        Text(
          text2,
          style: Theme.of(context)
              .textTheme
              .blackS13W400
              .copyWith(color: AppColor.kBlackColor.withOpacity(0.7)),
        ),
      ],
    );
  }

  List<Widget> _text(String text1, String text2) {
    return [
      20.kHeight,
      Text(
        text1,
        style: Theme.of(context).textTheme.blackS15W500,
      ),
      Measurement.gap.kHeight,
      Text(
        text2,
        style: Theme.of(context).textTheme.blackS14W400,
      ),
    ];
  }

  Widget _getBuilder() {
    return Container();
    // return GetBuilder<OrderController>(builder: (builder) {
    //   data = orderController.detailResult.data?.data ?? OrdersModel();

    //   return KBuilder(
    //     status: orderController.detailResult.status!,
    //     onRetry: () {
    //       orderController.detailResult.status!(ApiStatus.loading);
    //       _getDetail();
    //     },
    //     // child: _body(),
    //     builder: (status) {
    //       return status == ApiStatus.loading ? Container() : _body();
    //     },
    //   );
    // });
  }

  void _getDetail() {
    // orderController.deail(orderId).then((v) {
    //   /// get list
    //   customerController.distributorList().then((v2) {
    //     (v2.data?.list ?? []).map((e) {
    //       if (e.id == orderController.detailResult.data!.data!.distributorId!) {
    //         distributorName(e.name);

    //         return true;
    //       }
    //     }).toList();
    //   });
    //   // if (v.isSuccess) {
    //   //   data = orderController.detailResult.data?.data ?? OrdersModel();
    //   // }
    // });
  }

  @override
  void dispose() {
    // orderController.detailResult.status!(ApiStatus.loading);
    // orderController.detailResult.data = OrdersModel();
    super.dispose();
  }
}
