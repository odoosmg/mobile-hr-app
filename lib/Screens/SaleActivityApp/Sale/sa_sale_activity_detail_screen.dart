import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hrm_employee/Models/SaleActivity/Sale/sales_model.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Checkbox/custom_checkbox_1.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/GoogleMap/open_goooglemap.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Others/cus_card.dart';
import 'package:hrm_employee/Screens/components/appbar/custom_appbar.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/app_color.dart';
import 'package:hrm_employee/utlis/app_trans.dart';
import 'package:hrm_employee/utlis/measurement.dart';
import 'package:hrm_employee/utlis/measurement_widget_extension.dart';

class SASaleActivityDetailScreen extends StatefulWidget {
  static const route = '/sale-activity-detail';
  const SASaleActivityDetailScreen({super.key});

  @override
  State<SASaleActivityDetailScreen> createState() =>
      _SASaleActivityDetailScreenState();
}

class _SASaleActivityDetailScreenState
    extends State<SASaleActivityDetailScreen> {
  int argId = 0;

  // final SaleController saleController = Get.find<SaleController>();

  SalesModel data = SalesModel();

  @override
  void initState() {
    // saleController.detail(argId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.saTitleAction(title: 'Activity detail'),
      body: _getBuilder(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          // top: Measurement.screenPadding,
          left: Measurement.screenPadding,
          right: Measurement.screenPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Date
            ..._text(AppTrans.t.date, data.checkInDate ?? ""),

            /// Customer name
            ..._text(AppTrans.t.customerName, data.customerName ?? ""),

            /// Remark
            ..._text(AppTrans.t.remark, data.remark ?? ""),
            Measurement.screenPadding.kHeight,

            /// Image
            _image(),
            Measurement.screenPadding.kHeight,

            /// lat,long and view map
            _latlonViewMap(),

            4.kHeight,

            /// Has order
            IgnorePointer(
              child: CustomCheckbox1(
                  initValue: data.hasOrder,
                  onChanged: (v) {},
                  child: Text(
                    AppTrans.t.hasOrder,
                    style: Theme.of(context).textTheme.blackS15W400,
                  )),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _text(String text1, String text2) {
    return [
      Measurement.screenPadding.kHeight,
      Text(
        text1,
        style: Theme.of(context).textTheme.blackS15W700,
      ),
      Measurement.gap.kHeight,
      Text(
        text2,
        style: Theme.of(context).textTheme.blackS15W400,
      )
    ];
  }

  Widget _image() {
    return CusCard(
      padding: const EdgeInsets.all(4),
      borderRadius: BorderRadius.circular(0),
      background: AppColor.saMain,
      child: Container(
        height: 400,
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            image: DecorationImage(
              image: MemoryImage(base64Decode(data.photo ?? "")),
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  Row _latlonViewMap() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${data.photoLat}, ${data.photoLong}",
          style: Theme.of(context).textTheme.greyS13W400,
        ),

        /// View map
        InkWell(
          onTap: () {
            OpenGoogleMap().openInApp(
                context: context,
                lat: double.parse(data.photoLat!),
                long: double.parse(data.photoLong!));
          },
          child: Text(
            AppTrans.t.viewMap,
            style: Theme.of(context).textTheme.mainS13W700,
          ),
        )
      ],
    );
  }

  Widget _getBuilder() {
    return Container();
    // return GetBuilder<SaleController>(
    //     global: false,
    //     init: saleController,
    //     builder: (builder) {
    //       return KBuilder(
    //         status: saleController.detailResult.status!,
    //         onRetry: () {
    //           saleController.detailResult.status!(ApiStatus.loading);
    //           saleController.detail(argId);
    //         },
    //         builder: (status) {
    //           data = saleController.detailResult.data?.data ?? SalesModel();
    //           return status == ApiStatus.loading ? Container() : _body();
    //         },
    //       );
    //     });
  }

  @override
  void dispose() {
    // saleController.detailResult.status!(ApiStatus.loading);
    // saleController.detailResult.data = SalesModel();
    super.dispose();
  }
}
