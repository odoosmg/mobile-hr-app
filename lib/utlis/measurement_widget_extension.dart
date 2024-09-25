import 'package:flutter/material.dart';

extension MeasurementWidgetExtension on num {
  SizedBox get height => SizedBox(
        // ignore: unnecessary_this
        height: this.toDouble(),
      );

  SizedBox get width => SizedBox(
        // ignore: unnecessary_this
        width: this.toDouble(),
      );

  //********************************
  //              PADDING
  //********************************/

  /// Padding right
  Padding get pdRight => Padding(
        // ignore: unnecessary_this
        padding: EdgeInsets.only(right: this.toDouble()),
      );

  Padding get pdLeft => Padding(
        // ignore: unnecessary_this
        padding: EdgeInsets.only(left: this.toDouble()),
      );

  Padding get pdTop => Padding(
        // ignore: unnecessary_this
        padding: EdgeInsets.only(top: this.toDouble()),
      );
  Padding get pdBottom => Padding(
        // ignore: unnecessary_this
        padding: EdgeInsets.only(bottom: this.toDouble()),
      );
  Padding get pdAll => Padding(
        // ignore: unnecessary_this
        padding: EdgeInsets.all(this.toDouble()),
      );
}
