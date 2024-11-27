import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/SaleActivity/Sale/sales_model.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Button/main_btn_submit.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Customer/select_customer_field.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/GoogleMap/googlemap_location.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Modal/custom_bottom_sheet_modal.dart';
import 'package:hrm_employee/Screens/components/appbar/custom_appbar.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/app_trans.dart';
import 'package:hrm_employee/utlis/measurement.dart';
import 'package:hrm_employee/utlis/measurement_widget_extension.dart';

class SASaleManualCheckinScreen extends StatefulWidget {
  static const route = '/sale-checkin';
  const SASaleManualCheckinScreen({super.key});

  @override
  State<SASaleManualCheckinScreen> createState() =>
      _SASaleManualCheckinScreenState();
}

class _SASaleManualCheckinScreenState extends State<SASaleManualCheckinScreen> {
  /// Argument
  DateTime argSelectedDate = DateTime.now();

  // final SaleController saleController = Get.find<SaleController>();

  final Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();

  final Completer<GoogleMapController> googleMapController2 =
      Completer<GoogleMapController>();

  String address = '';

  double lat = 0.0, long = 0.0;

  BtnStatus btnStatus = BtnStatus.disabled;

  /// for store and append to list
  SalesModel data = SalesModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.titleActions(title: AppTrans.t.checkIn),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: Measurement.screenPadding,
            left: Measurement.screenPadding,
            right: Measurement.screenPadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// CUSTOMER NAME
              SelectCustomerField(onSelected: (c) async {
                ///
                FocusManager.instance.primaryFocus!.unfocus();

                address = (c.address ?? "");
                long = (c.long ?? 0);
                lat = (c.lat ?? 0);

                ///
                data.address = address;
                data.customerName = c.name;
                data.status = "todo"; // default status
                data.partnerId = c.id;
                data.lat = lat;
                data.long = long;
                data.gpsRange = c.gpsRange;

                ///
                btnStatus = BtnStatus.ok;
                _gotoPoistion();
              }),
              Measurement.screenPadding.kHeight,

              /// ADDRESS
              Text(
                AppTrans.t.address,
                style: Theme.of(context).textTheme.blackS15W700,
              ),
              Measurement.gap.kHeight,

              Text(
                address,
                style: Theme.of(context).textTheme.blackS15W400,
              ),

              Measurement.screenPadding.kHeight,

              /// MAP,
              _map(),

              32.kHeight,

              /// BTN check-in
              Center(
                child: MainBtnSubmit(
                  title: AppTrans.t.checkIn.toUpperCase(),
                  status: btnStatus,
                  onPressed: _manualCheckin,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _map() {
    return GestureDetector(
      onTap: () {
        /// Modal
        CustomBotttomSheetModal(context).closeTitle(
          /// set to false can drag map
          enableDrag: false,
          title: AppTrans.t.location,
          child: Expanded(
            child: GoogleMapLocation(
              googleMapController: googleMapController2,
              isGetDirection: true,
              lat: lat,
              long: long,
            ),
          ),
        );
      },
      child: Container(
        height: 200,
        color: Colors.transparent,
        width: double.infinity,
        child: IgnorePointer(
          child: GoogleMapLocation(
            googleMapController: googleMapController,
            lat: lat,
            long: long,
          ),
        ),
      ),
    );
  }

  /// go to position
  Future<void> _gotoPoistion() async {
    final GoogleMapController controller = await googleMapController.future;
    return await controller
        .animateCamera(CameraUpdate.newCameraPosition(positoin()));
  }

  ///
  CameraPosition positoin() {
    return CameraPosition(
      target: LatLng(lat, long),
      zoom: Measurement.googleMapZoom,
    );
  }

  void _manualCheckin() {
    // saleController.manuanlCheckIn(context, data, argSelectedDate).then((value) {
    //   if (value.isSuccess) {
    //     Get.back();
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
