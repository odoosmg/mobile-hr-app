import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Button/main_btn_submit.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/GoogleMap/open_goooglemap.dart';
import 'package:hrm_employee/utlis/app_trans.dart';

class GoogleMapLocation extends StatefulWidget {
  final double lat;
  final double long;
  final double? zoom;

  /// Display when not null
  final Completer<GoogleMapController> googleMapController;

  /// Display when not null
  final Function(double, double)? onDropLocation;
  final bool isGetDirection;
  const GoogleMapLocation({
    super.key,
    required this.googleMapController,
    required this.lat,
    required this.long,
    this.zoom,
    this.onDropLocation,
    this.isGetDirection = false,
  });

  @override
  State<GoogleMapLocation> createState() => _GoogleMapLocationState();
}

class _GoogleMapLocationState extends State<GoogleMapLocation> {
  double la = 0, lo = 0;

  @override
  void initState() {
    la = widget.lat;
    lo = widget.long;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _googleMap();
  }

  Widget _googleMap() {
    return IgnorePointer(
      ignoring: false,
      child: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,

            ///
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.lat, widget.long),
              zoom: widget.zoom ?? 14.4746,
            ),

            ///
            onMapCreated: (GoogleMapController controller) {
              widget.googleMapController.complete(controller);
            },
            zoomControlsEnabled: false,
            myLocationEnabled: true,
            mapToolbarEnabled: false,
            myLocationButtonEnabled: false,

            ///
            onCameraMove: (position) {
              la = position.target.latitude;
              lo = position.target.longitude;
            },

            ///
            markers: {
              /// onDropLocation != null. means have drop location
              if (widget.lat > 0 && widget.onDropLocation == null)
                Marker(
                  markerId: const MarkerId("userlocation"),
                  position: LatLng(widget.lat, widget.long),
                  infoWindow: const InfoWindow(
                    title: "Current Location",
                  ),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRose),
                )
            },
          ),
          if (widget.onDropLocation != null)
            const IgnorePointer(
              ignoring: true,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Icon(
                    Icons.location_on_sharp,
                    size: 40,
                    color: Colors.pink,
                  ),
                ),
              ),
            ),

          /// Btn Drop
          if (widget.onDropLocation != null)
            _bottomBtn(
              title: AppTrans.t.drop,
              onPressed: () {
                if (widget.onDropLocation != null) {
                  widget.onDropLocation!.call(la, lo);
                  Navigator.pop(context);
                }
              },
            ),

          /// Btn Get Direction
          if (widget.isGetDirection)
            _bottomBtn(
              title: AppTrans.t.getDirection,
              onPressed: () async {
                OpenGoogleMap().openInApp(
                    context: context, lat: widget.lat, long: widget.long);
              },
            )
        ],
      ),
    );
  }

  Container _bottomBtn({
    required String title,
    required Function() onPressed,
  }) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
        width: 200,
        child: MainBtnSubmit(
          title: title,
          status: BtnStatus.ok,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
