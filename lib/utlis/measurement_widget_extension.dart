import 'package:flutter/material.dart';

extension MeasurementWidgetExtension on num {
  SizedBox get kHeight => SizedBox(
        // ignore: unnecessary_this
        height: this.toDouble(),
      );

  SizedBox get kWidth => SizedBox(
        // ignore: unnecessary_this
        width: this.toDouble(),
      );

  //********************************
  //              PADDING
  //********************************/

  /// Padding right
  Padding get kPdRight => Padding(
        // ignore: unnecessary_this
        padding: EdgeInsets.only(right: this.toDouble()),
      );

  Padding get kPdLeft => Padding(
        // ignore: unnecessary_this
        padding: EdgeInsets.only(left: this.toDouble()),
      );

  Padding get kPdTop => Padding(
        // ignore: unnecessary_this
        padding: EdgeInsets.only(top: this.toDouble()),
      );
  Padding get kPdBottom => Padding(
        // ignore: unnecessary_this
        padding: EdgeInsets.only(bottom: this.toDouble()),
      );
  Padding get kPdAll => Padding(
        // ignore: unnecessary_this
        padding: EdgeInsets.all(this.toDouble()),
      );
}
