import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:flutter/material.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/app_color.dart';
import 'package:hrm_employee/utlis/measurement.dart';
import 'package:hrm_employee/utlis/measurement_widget_extension.dart';

class InOutCard extends StatelessWidget {
  final String? checkinDate; // if null, bg is grey, not checked
  final String? checkoutDate;
  final AttendanceInOutStatus status;
  final Function(AttendanceInOutStatus?) onSubmit;
  const InOutCard({
    super.key,
    required this.onSubmit,
    required this.status,
    this.checkinDate,
    this.checkoutDate,
  });

  @override
  Widget build(BuildContext context) {
    return _checkInOutStatus(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _checkInOutStatus(context),

        /// BTN in-out
        Expanded(
          child: Container(
            height: 70,
            padding: const EdgeInsets.only(left: 4),
            width: 70,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  foregroundColor: Colors.white,
                  backgroundColor: status == AttendanceInOutStatus.checkOut
                      ? AttendanceDayStatus.absent.bgColor
                      : Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4))),
              onPressed: () {
                onSubmit.call(status);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(status == AttendanceInOutStatus.checkOut
                      ? Icons.logout
                      : Icons.login),
                  3.height,
                  Text(
                    status == AttendanceInOutStatus.checkOut ? "OUT" : "IN",
                    style: Theme.of(context).textTheme.whiteS13W500,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  /// Check in Checkout status,
  Widget _checkInOutStatus(BuildContext context) {
    return SizedBox(
      width: 260,
      height: 80,
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Measurement.btnRadius),
          side: const BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// checkin status
            _checkInOutTimeCard(
              /// have date white else gray
              color: checkinDate != null ? Colors.white : Colors.grey.shade100,
              width: 130,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Measurement.btnRadius),
                bottomLeft: Radius.circular(Measurement.btnRadius),
              ),
              child: _inOutTime(
                context: context,
                title: "IN TIME",
                time: checkinDate ?? "00:00",
                isCheckIn: checkinDate != null,
              ),
            ),

            /// middle line
            Container(
              height: double.infinity,
              width: 1,
              color: Colors.grey.shade500,
            ),

            /// checkout status
            _checkInOutTimeCard(
              width: 120,
              color: checkoutDate != null ? Colors.white : Colors.grey.shade100,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(Measurement.btnRadius),
                bottomRight: Radius.circular(Measurement.btnRadius),
              ),
              child: _inOutTime(
                context: context,
                title: "OUT TIME",
                time: checkoutDate ?? "00:00",
                isCheckIn: checkoutDate != null,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _checkInOutTimeCard({
    required Color color,
    required double width,
    required BorderRadiusGeometry borderRadius,
    required Widget child,
  }) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }

  /// Time and icon
  Widget _inOutTime(
      {required BuildContext context,
      required String title,
      required bool isCheckIn,
      required String time}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isCheckIn ? Icons.check_circle : Icons.check_circle_outline,
              size: 16,
              color: isCheckIn ? AppColor.kMainColor : AppColor.kGreyTextColor,
            ),
            Measurement.gap.width,
            Text(
              title,
              style: Theme.of(context).textTheme.mainS13W500,
            )
          ],
        ),
        2.height,
        Text(
          time,
          style: Theme.of(context).textTheme.blackS13W700,
        ),
      ],
    );
  }
}
