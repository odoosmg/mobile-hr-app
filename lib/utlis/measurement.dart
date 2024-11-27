import 'package:flutter/material.dart';

class Measurement {
  static const double screenPadding = 20;
  static const double textFieldborderRadius = 4;
  static const double cardBorderRadius = 10;
  static const double cardRadius = 6;
  static const double gap = 6;
  static const double btnRadius = 6;

  static double widthPercent(BuildContext context, double percent) =>
      MediaQuery.of(context).size.width * percent;

  static double heightPercent(BuildContext context, double percent) =>
      MediaQuery.of(context).size.height * percent;

  static double discount(double price, double percent) {
    double pricePercent = price * (percent / 100);
    return price - pricePercent;
  }

  static const double googleMapZoom = 14.4746;
}
