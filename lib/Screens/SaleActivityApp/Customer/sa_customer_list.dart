import 'package:flutter/material.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:hrm_employee/utlis/measurement.dart';
import 'package:hrm_employee/utlis/measurement_widget_extension.dart';
// ignore: unused_import, depend_on_referenced_packages
import 'package:nb_utils/nb_utils.dart';
import 'package:hrm_employee/Models/SaleActivity/Customer/customer_model.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Button/main_appbar_btn_icon.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Customer/customer_cell.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/Customer/sa_customer_add_screen.dart';
import 'package:hrm_employee/Screens/components/appbar/custom_appbar.dart';
import 'package:hrm_employee/utlis/app_trans.dart';

class SACustomerListScreen extends StatefulWidget {
  const SACustomerListScreen({super.key});

  @override
  State<SACustomerListScreen> createState() => _SACustomerListScreenState();
}

class _SACustomerListScreenState extends State<SACustomerListScreen> {
  // final CustomerController customerController = Get.find<CustomerController>();

  final EasyRefreshController easyRefreshController = EasyRefreshController(
      controlFinishLoad: true, controlFinishRefresh: true);

  @override
  void initState() {
    // customerController.getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.saTitleAction(
        title: AppTrans.t.customer,
        actions: [
          MainAppbarBtnIcon(
            iconData: Icons.add_reaction_rounded,
            onPressed: () {
              // Get.toNamed(CustomerAddPage.route)

              SACustomerAddScreen().launch(context);
            },
          ),
          Measurement.screenPadding.kPdRight,
        ],
      ),
      body: Column(
        children: [CustomerCell(data: CustomerModel())],
      ),
      /*
      body: Padding(
        padding: const EdgeInsets.only(
          left: Measurement.screenPadding,
          right: Measurement.screenPadding,
        ),
        child: _getBuilder(),
      ),
      */
    );
  }
/*
  Widget _getBuilder() {
    return GetBuilder<CustomerController>(builder: (builder) {
      return KBuilder(
        status: customerController.listResult.status!,
        onRetry: () {
          customerController.listResult.status!(ApiStatus.loading);
          _onRefresh();
        },
        builder: (status) {
          return status == ApiStatus.loading ? Container() : _easyRefresh();
        },
      );
    });
  }

  Widget _easyRefresh() {
    return CustomEasyRefresh(
      controller: easyRefreshController,
      onRefresh: _onRefresh,
      onLoad: _onLoad,
      child: _listView(),
    );
  }

  Widget _listView() {
    List<CustomerModel> data = customerController.listResult.data?.list ?? [];
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.only(
                top: Measurement.screenPadding,

                /// list item space bottom
                bottom: index == data.length - 1 ? 20 : 0,
              ),
              child: CustomerCell(data: data[index]));
        });
  }

  ///=================================================================
  ///
  ///=================================================================

  void _onRefresh() {
    customerController.getList().then((value) {
      if (value.isSuccess) {
        easyRefreshController.finishRefresh(IndicatorResult.success);
        easyRefreshController.resetFooter();
      } else {
        easyRefreshController.finishRefresh(IndicatorResult.fail);
      }
    });
  }

  void _onLoad() {
    /// page = totalpages.
    /// No need to retrieve more
    if (customerController.listResult.data!.page ==
        customerController.listResult.data!.totalPages) {
      easyRefreshController.finishLoad(IndicatorResult.noMore);
      return;
    }
    customerController.getList(true).then((value) {
      if (value.isSuccess) {
        easyRefreshController.finishLoad(IndicatorResult.success);
      } else {
        easyRefreshController.finishLoad(IndicatorResult.fail);
      }
    });
  }

  @override
  void dispose() {
    customerController.listResult.status!(ApiStatus.loading);
    customerController.listResult.data = CustomerModel();
    super.dispose();
  }
  */
}
