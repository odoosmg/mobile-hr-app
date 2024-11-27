import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hrm_employee/GlobalComponents/others/loading_inidicator.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/SaleActivity/Customer/customer_model.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Button/main_btn_submit.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Customer/select_distr_custtype.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Fields/customer_textfield.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/GoogleMap/googlemap_location.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Modal/custom_bottom_sheet_modal.dart';
import 'package:hrm_employee/Screens/components/appbar/custom_appbar.dart';
import 'package:hrm_employee/Services/app_services.dart';
import 'package:hrm_employee/Services/location_service.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/app_trans.dart';
import 'package:hrm_employee/utlis/measurement.dart';
import 'package:hrm_employee/utlis/measurement_widget_extension.dart';

class SACustomerAddScreen extends StatefulWidget {
  static const route = "/customer-add";
  const SACustomerAddScreen({super.key});

  @override
  State<SACustomerAddScreen> createState() => _SACustomerAddScreenState();
}

class _SACustomerAddScreenState extends State<SACustomerAddScreen> {
  ///
  // final CustomerController customerController = Get.find<CustomerController>();

  final Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();

  final Completer<GoogleMapController> googleMapController2 =
      Completer<GoogleMapController>();

  double lat = 0.0, long = 0.0;

  final TextEditingController nameTEC = TextEditingController();
  final TextEditingController phoneTEC = TextEditingController();
  final TextEditingController addressTEC = TextEditingController();
  final TextEditingController emailTEC = TextEditingController();
  int customerTypeId = 0;
  String customerTypeName = '';

  BtnStatus btnStatus = BtnStatus.disabled;

  @override
  void initState() {
    /// checking permission
    AppServices.instance<LocationService>()
        .requestPermission()
        .then((permission) {
      AppServices.instance<LocationService>().getCurrentLocation().then((v) {
        lat = v.latitude;
        long = v.longitude;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.titleActions(title: AppTrans.t.addNewCustomer),
      body: Padding(
        padding: const EdgeInsets.only(
          left: Measurement.screenPadding,
          right: Measurement.screenPadding,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Name and Pharmacy
              Row(
                children: [
                  Flexible(flex: 1, child: _name()),
                  Measurement.screenPadding.kWidth,
                  Flexible(flex: 1, child: _selectCustomerType()),
                ],
              ),

              /// Phnoe number
              _phone(),

              /// Address
              _address(),

              /// Email
              _email(),
              24.kHeight,

              /// Map
              _map(),
              30.kHeight,

              /// Btn
              _btnCreate()
            ],
          ),
        ),
      ),
    );
  }

  Widget _name() {
    return Padding(
      padding: const EdgeInsets.only(top: Measurement.screenPadding),
      child: CustomTextField(
        title: AppTrans.t.name,
        titleTextStyle: Theme.of(context).textTheme.greyS15W400,
        isRequired: true,
        onChanged: (text) {
          nameTEC.text = text;

          _validate();
        },
      ),
    );
  }

  Widget _selectCustomerType() {
    return Padding(
      padding: const EdgeInsets.only(top: Measurement.screenPadding),
      // child: CustomTypeAhead(
      //   title: AppTrans.t.phamarcy,
      //   isRequired: true,
      // ),
      child: SelectDistrCusttype(
        type: KSelectType.customer,
        onSelect: (cus) {
          customerTypeId = cus.id ?? 0;
          customerTypeName = cus.name ?? "";

          _validate();
        },
      ),
    );
  }

  Widget _phone() {
    return Padding(
      padding: const EdgeInsets.only(top: Measurement.screenPadding),
      child: CustomTextField(
        title: AppTrans.t.phoneNumber,
        isRequired: true,
        titleTextStyle: Theme.of(context).textTheme.greyS15W400,
        keyboardType: TextInputType.number,
        onChanged: (text) {
          phoneTEC.text = text;

          _validate();
        },
      ),
    );
  }

  Widget _address() {
    return Padding(
      padding: const EdgeInsets.only(top: Measurement.screenPadding),
      child: CustomTextField(
        title: AppTrans.t.address,
        maxLines: 3,
        titleTextStyle: Theme.of(context).textTheme.greyS15W400,
        isRequired: true,
        onChanged: (text) {
          addressTEC.text = text;
          _validate();
        },
      ),
    );
  }

  Widget _email() {
    return Padding(
      padding: const EdgeInsets.only(top: Measurement.screenPadding),
      child: CustomTextField(
        title: AppTrans.t.email,
        titleTextStyle: Theme.of(context).textTheme.greyS15W400,
        onChanged: (text) {
          emailTEC.text = text;
        },
      ),
    );
  }

  Widget _map() {
    return

        /// MAP,
        GestureDetector(
            onTap: () {
              /// Modal
              CustomBotttomSheetModal(context).closeTitle(

                  /// set to false can drag map
                  enableDrag: false,
                  title: AppTrans.t.location,
                  child: Expanded(
                    child: GoogleMapLocation(
                      googleMapController: googleMapController2,
                      // isGetDirection: true,
                      lat: lat,
                      long: long,

                      /// (lat, long)
                      onDropLocation: (la, lo) async {
                        lat = 0;

                        /// delay a bit to make map trigger
                        await Future.delayed(const Duration(seconds: 1));
                        long = lo;
                        lat = la;
                      },
                    ),
                  ));
            },
            child: lat == 0 ? _mapLoading() : _displayMap());
  }

  Widget _btnCreate() {
    return MainBtnSubmit(
      title: AppTrans.t.createSth(AppTrans.t.customer),
      status: btnStatus,
      onPressed: () {
        ///
        CustomerModel d = CustomerModel();
        d.name = nameTEC.text;
        d.customerTypeId = customerTypeId;
        d.phone = phoneTEC.text;
        d.address = addressTEC.text;
        d.email = emailTEC.text;
        d.lat = lat;
        d.long = long;
        d.customerType = customerTypeName;

        ///
        // customerController.add(context, d).then((value) {
        //   if (value.isSuccess) {
        //     Get.back();
        //   }
        // });
      },
    );
  }

  Widget _displayMap() {
    return Container(
      height: 200,
      color: Colors.transparent,
      width: double.infinity,
      child: IgnorePointer(
        child: GoogleMapLocation(
          googleMapController: googleMapController,
          lat: lat,
          long: long,
          zoom: 14.23,
        ),
      ),
    );
  }

  Widget _mapLoading() {
    return SizedBox(
      width: 50,
      height: 200,
      child: CustomCircularProgressindicator(),
    );
  }

  void _validate() {
    if (nameTEC.text.isNotEmpty &&
        customerTypeId > 0 &&
        phoneTEC.text.isNotEmpty &&
        addressTEC.text.isNotEmpty) {
      btnStatus = BtnStatus.ok;
    } else {
      btnStatus = BtnStatus.disabled;
    }
  }

  @override
  void dispose() {
    nameTEC.dispose();
    phoneTEC.dispose();
    addressTEC.dispose();
    emailTEC.dispose();
    super.dispose();
  }
}
