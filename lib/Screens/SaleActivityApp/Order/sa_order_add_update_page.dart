import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hrm_employee/GlobalComponents/dialog/custom_loading.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/SaleActivity/Order/orders_model.dart';
import 'package:hrm_employee/Models/SaleActivity/Order/product_model.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Button/main_btn_submit.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Customer/select_customer_field.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Customer/select_distr_custtype.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Fields/customer_textfield.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Order/product_card.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Others/cus_card.dart';
import 'package:hrm_employee/Screens/components/appbar/custom_appbar.dart';
import 'package:hrm_employee/Services/app_services.dart';
import 'package:hrm_employee/Services/navigation_service.dart';
import 'package:hrm_employee/extensions/date_extension.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/app_color.dart';
import 'package:hrm_employee/utlis/app_trans.dart';
import 'package:hrm_employee/utlis/measurement.dart';
import 'package:hrm_employee/utlis/measurement_widget_extension.dart';

class SAOrderAddUpdatePage extends StatefulWidget {
  static const route = '/order-add';
  const SAOrderAddUpdatePage({super.key});

  @override
  State<SAOrderAddUpdatePage> createState() => _SAOrderAddUpdatePageState();
}

class _SAOrderAddUpdatePageState extends State<SAOrderAddUpdatePage> {
  // final OrderController orderController = Get.find<OrderController>();

  /// null mean is not update
  /// value is number mean is update.
  OrdersModel? argData = OrdersModel();

  late TextStyle fieldTitleStyle;

  String customerAddress = '';

  int customerId = 0, distributorId = 0;
  String partnerName = "";

  final TextEditingController remarkTEC = TextEditingController();
  final TextEditingController dateTEC = TextEditingController();

  ProductModel productData = ProductModel();

  BtnStatus btnStatus = BtnStatus.disabled;

  bool isUpdateForm = false;

  OrdersModel detailData = OrdersModel();

  @override
  void initState() {
    fieldTitleStyle =
        Theme.of(AppServices.instance<NavigatorService>().getCurrentContext)
            .textTheme
            .greyS15W400;
    // isUpdateForm = (argData != null);

    dateTEC.text = DateTime.now().dateFormat(toFormat: "yyyy-MM-dd").toString();

    if (isUpdateForm) {
      // orderController.deail(argData?.id ?? 0).then((value) {
      //   if (value.isSuccess) {
      //     detailData = orderController.detailResult.data!.data!;

      //     _initData(detailData);
      //   }
      // });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.titleActions(
          title:
              isUpdateForm ? AppTrans.t.updateOrder : AppTrans.t.addNewOrder),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: Measurement.screenPadding,
            right: Measurement.screenPadding,
            top: Measurement.screenPadding,
          ),
          child: _checkForm(),
        ),
      ),
    );
  }

  /// Add or Update form
  Widget _checkForm() {
    return isUpdateForm ? _getBuilderDetail() : _display();
  }

  Widget _getBuilderDetail() {
    return Container();
    // return GetBuilder<OrderController>(builder: (builder) {
    //   return KBuilder(
    //     status: orderController.detailResult.status!,
    //     onRetry: () {
    //       orderController.detailResult.status!(ApiStatus.loading);
    //       orderController.deail(argData?.id ?? 0);
    //     },
    //     // child: _body(),
    //     builder: (status) {
    //       return status == ApiStatus.loading ? Container() : _display();
    //     },
    //   );
    // });
  }

  Widget _display() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Date
        _date(),

        /// Customer
        ..._customer(),

        /// Delivery address
        ..._deliveryAddress(),

        /// Remark
        ..._remark(),

        /// Distributor
        ..._distributor(),

        /// Product
        /// init form UpdateForm
        ProductCard(
          initData: detailData.orderLines,
          initGlobalDiscount: detailData.globalDiscount,
          onAction: (data) {
            productData = data;
            _validate();
          },
          onGlobalDiscount: (gdiscount, total) {
            productData.globalDiscount = gdiscount;
            productData.total = total;
          },
        ),

        /// Btn Create
        _btnCreate(),

        30.kHeight,
      ],
    );
  }

  Widget _date() {
    return IgnorePointer(
      child: Row(
        children: <Widget>[
          /// Order date
          Flexible(
            child: CustomTextField(
              title: AppTrans.t.orderDate,
              titleTextStyle: fieldTitleStyle,
              controller: dateTEC,
              suffixIcon: const Icon(Icons.date_range_rounded,
                  color: AppColor.kBlackColor),
            ),
          ),
          16.kWidth,

          /// Delivery date
          Flexible(
            child: CustomTextField(
              title: AppTrans.t.deliveryDate,
              titleTextStyle: fieldTitleStyle,
              controller: dateTEC,
              suffixIcon: const Icon(Icons.date_range_rounded,
                  color: AppColor.kBlackColor),
            ),
          ),
        ],
      ),
    );
  }

  /// Select customer
  List<Widget> _customer() {
    return [
      Measurement.screenPadding.kHeight,

      /// Customer
      SelectCustomerField(
        initName: partnerName,
        onSelected: (d) {
          customerAddress = d.address!;
          customerId = d.id ?? 0;
          partnerName = d.name ?? "";

          _validate();
        },
      ),
    ];
  }

  /// Retrieve from customer.
  /// cannnot typing
  List<Widget> _deliveryAddress() {
    return [
      Measurement.screenPadding.kHeight,
      Text(
        AppTrans.t.deliveryAddress,
        style: fieldTitleStyle,
      ),
      Measurement.gap.kHeight,
      CusCard(
        padding: const EdgeInsets.only(
          left: 10,
          top: 14,
          bottom: 14,
        ),
        boxShadow: const [],
        borderRadius: BorderRadius.circular(Measurement.cardBorderRadius),
        background: Colors.grey.shade400.withOpacity(0.8),
        child: Text(
          customerAddress,
          style: Theme.of(context).textTheme.blackS15W500NoChange,
        ),
      ),
    ];
  }

  List<Widget> _remark() {
    return [
      Measurement.screenPadding.kHeight,
      CustomTextField(
        title: AppTrans.t.remark,
        controller: remarkTEC,
        maxLines: 3,
        keyboardType: TextInputType.multiline,
        titleTextStyle: fieldTitleStyle,
      ),
    ];
  }

  List<Widget> _distributor() {
    return [
      Measurement.screenPadding.kHeight,
      SelectDistrCusttype(
          initId: detailData.distributorId,
          type: KSelectType.distributor,
          onSelect: (d) {
            distributorId = d.id ?? 0;
            _validate();
          }),
    ];
  }

  Widget _btnCreate() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 30),
      child: MainBtnSubmit(
        title: isUpdateForm ? AppTrans.t.updateOrder : AppTrans.t.createOrder,
        status: btnStatus,
        onPressed: _submit,
      ),
    );
  }

  ///******************************************************
  ///
  ///*******************************************************/

  void _validate() {
    if (customerId > 0 &&
        distributorId > 0 &&
        (productData.orderLines ?? []).isNotEmpty) {
      btnStatus = BtnStatus.ok;
    } else {
      btnStatus = BtnStatus.disabled;
    }
  }

  ///
  Future<void> _submit() async {
    /*
    CustomLoading.show(context);

    /// will remove
    await Future.delayed(const Duration(seconds: 1));

    /// Add alot data,
    /// to make it referecen at list page
    OrdersModel orderData = OrdersModel();
    orderData.customerId = customerId;
    orderData.partnerName = partnerName;
    orderData.distributorId = distributorId;
    orderData.remark = remarkTEC.text;

    orderData.dateStr = dateTEC.text;
    orderData.dateOrder = dateTEC.text;
    orderData.deliveryDate = dateTEC.text;
    orderData.deliveryAddress = customerAddress.value;
    orderData.amount = productData.total;
    orderData.statusValue = OrderStatus.quotation.name;

    if (isUpdateForm) {
      /// UPDATE
      orderController
          .updateOrder(argData?.id ?? 0, orderData, productData)
          .then((value) async {
        CustomLoading.close(context: context);
        if (value.isSuccess) {
          /// update reference
          argData!.deliveryAddress = orderData.deliveryAddress;
          argData!.partnerName = orderData.partnerName;
          argData!.amount = orderData.amount;
          orderController.update();

          /// back
          Get.back();
        } else {
          CustomDialog.error(context, value.statuscode, value.errorMessage);
        }
      });
    } else {
      /// ADD
      orderController.add(orderData, productData).then((value) async {
        CustomLoading.close(context: context);
        if (value.isSuccess) {
          Get.back();
        } else {
          CustomDialog.error(context, value.statuscode, value.errorMessage);
        }
      });
    }
    */
  }

  /// init data form updateForm
  void _initData(OrdersModel data) {
    dateTEC.text = data.dateOrder ?? "";
    customerId = data.partnerId ?? 0;
    distributorId = data.distributorId ?? 0;
    partnerName = detailData.partnerName ?? "";
    customerAddress = data.deliveryAddress ?? "";
    remarkTEC.text = data.note ?? "";

    productData.orderLines = detailData.orderLines ?? [];

    productData.total = detailData.amount ?? 0;
    productData.globalDiscount = detailData.globalDiscount ?? 0;

    /// update keys
    /// key different from AddForm
    productData.orderLines!.map((e) {
      e.qty = e.productUomQty;
      e.name = e.productName;

      // set this. calculate with qty and discount
      e.salePrice = e.getItemPrice;
      e.pricePerUnit = e.priceUnit;
      e.id = e.productId;
      e.productUomId = int.parse(e.productUom ?? "0");
    }).toList();

    /// validate
    _validate();
  }

  ///******************************************************
  ///
  ///*******************************************************/

  @override
  void dispose() {
    remarkTEC.dispose();
    dateTEC.dispose();
    // orderController.detailResult.status!(ApiStatus.loading);
    // orderController.detailResult.data = OrdersModel();
    super.dispose();
  }
}
