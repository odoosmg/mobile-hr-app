import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:flutter/material.dart';
import 'package:hrm_employee/Screens/Home/date_label_cubit/date_label_cubit.dart';
import 'package:hrm_employee/constant.dart';
import 'package:hrm_employee/extensions/date_extension.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/app_color.dart';
import 'package:hrm_employee/utlis/measurement.dart';
import 'package:hrm_employee/utlis/measurement_widget_extension.dart';

class InOutCard extends StatefulWidget {
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
  State<InOutCard> createState() => _InOutCardState();
}

class _InOutCardState extends State<InOutCard> {
  Timer? timer;
  final dateLabelCubit = DateLabelCubit();

  @override
  void initState() {
    ///
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      // context.read<HomeBloc>().add(DateLabel(DateTime.now()));
      dateLabelCubit.dateLabel();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// * Bloc
        /// Date Label
        BlocBuilder<DateLabelCubit, DateTime>(
          bloc: dateLabelCubit,
          buildWhen: (previous, current) {
            /// build when minutes equal
            return previous.dateFormat(toFormat: "mm") ==
                current.dateFormat(toFormat: "mm");
          },
          builder: (context, state) {
            return Column(
              children: [
                /// Date
                Text(
                  state.dateFormat(toFormat: "EEEE, MMM dd, yyyy").toString(),
                  style: kTextStyle.copyWith(color: kGreyTextColor),
                ),
                const SizedBox(
                  height: 10.0,
                ),

                /// Time
                Text(
                  '${state.dateFormat(toFormat: "H:mm")}',
                  style: kTextStyle.copyWith(
                      fontWeight: FontWeight.bold, fontSize: 25.0),
                ),
              ],
            );
          },
        ),
        _checkInOutStatus(context),

        /// Btn
        _btnChekInOut(),
      ],
    );
  }

  Widget _btnChekInOut() {
    /// is CheckIn
    bool isIn = widget.status == AttendanceInOutStatus.checkIn;
    return Container(
      margin: const EdgeInsets.only(top: Measurement.screenPadding),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color:
            isIn ? kGreenColor.withOpacity(0.1) : kAlertColor.withOpacity(0.1),
      ),
      child: GestureDetector(
        onTap: () {
          widget.onSubmit.call(widget.status);
        },
        child: CircleAvatar(
          radius: 70.0,
          backgroundColor: isIn ? kGreenColor : kAlertColor,
          child: Text(
            isIn ? 'Check In' : 'Check Out',
            style: kTextStyle.copyWith(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
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
              color: widget.checkinDate != null
                  ? Colors.white
                  : Colors.grey.shade100,
              width: 130,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Measurement.btnRadius),
                bottomLeft: Radius.circular(Measurement.btnRadius),
              ),
              child: _inOutTime(
                context: context,
                title: "IN TIME",
                time: widget.checkinDate ?? "00:00",
                isCheckIn: widget.checkinDate != null,
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
              color: widget.checkoutDate != null
                  ? Colors.white
                  : Colors.grey.shade100,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(Measurement.btnRadius),
                bottomRight: Radius.circular(Measurement.btnRadius),
              ),
              child: _inOutTime(
                context: context,
                title: "OUT TIME",
                time: widget.checkoutDate ?? "00:00",
                isCheckIn: widget.checkoutDate != null,
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
        2.kHeight,
        Text(
          time,
          style: Theme.of(context).textTheme.blackS13W700,
        ),
      ],
    );
  }

  @override
  dispose() {
    timer!.cancel();
    super.dispose();
  }
}
