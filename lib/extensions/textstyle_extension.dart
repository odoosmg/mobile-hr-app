import 'dart:ui';

import 'package:flutter/material.dart' show Colors, TextStyle, TextTheme;
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:hrm_employee/utlis/app_color.dart';

extension TextstyleExtension on TextTheme {
  TextStyle get textFont => const TextStyle(fontFamily: 'Manrope');

  /// Check theme color.
  /// all copyWith will change follow
  TextStyle get blackColor => textFont.copyWith(color: Colors.black);

  TextStyle get whiteColor => textFont.copyWith(color: Colors.white);

  TextStyle get redColor => textFont.copyWith(color: Colors.red);

  TextStyle get greyColor => textFont.copyWith(color: Colors.grey);

  TextStyle get mainColor => textFont.copyWith(color: AppColor.kMainColor);

  ///*************************
  ///           BLACK
  ///*************************/
  TextStyle get blackS10W400 =>
      blackColor.copyWith(fontSize: 10, fontWeight: FontWeight.w400);
  TextStyle get blackS12W400 =>
      blackColor.copyWith(fontSize: 12, fontWeight: FontWeight.w400);
  TextStyle get blackS12W700 =>
      blackS12W400.copyWith(fontWeight: FontWeight.w700);
  TextStyle get blackS13W400 =>
      blackColor.copyWith(fontSize: 13, fontWeight: FontWeight.w400);
  TextStyle get blackS13W400NoChange =>
      blackS13W400.copyWith(color: AppColor.kBlackColor);
  TextStyle get blackS13W500 =>
      blackS13W400.copyWith(fontWeight: FontWeight.w500);
  TextStyle get blackS13W700 =>
      blackS13W400.copyWith(fontWeight: FontWeight.w700);
  TextStyle get blackS13W700NoChange =>
      blackS13W700.copyWith(color: AppColor.kBlackColor);

  TextStyle get blackS14W400 => blackS13W400.copyWith(fontSize: 14);
  TextStyle get blackS14W500 =>
      blackS14W400.copyWith(fontWeight: FontWeight.w400);

  TextStyle get blackS14W700 =>
      blackS14W400.copyWith(fontWeight: FontWeight.w700);

  TextStyle get blackS15W400 => blackS13W400.copyWith(fontSize: 15);
  TextStyle get blackS15W400NoChange =>
      blackS15W400.copyWith(color: AppColor.kBlackColor);
  TextStyle get blackS15W500 =>
      blackS15W400.copyWith(fontWeight: FontWeight.w500);
  TextStyle get blackS15W500NoChange =>
      blackS15W500.copyWith(color: AppColor.kBlackColor);
  TextStyle get blackS15W700 =>
      blackS15W400.copyWith(fontWeight: FontWeight.w700);

  /// Not changing theme
  TextStyle get blackS15W700NoChange =>
      blackS15W700.copyWith(color: AppColor.kBlackColor);
  TextStyle get blackS17W400 => blackS13W400.copyWith(fontSize: 17);
  TextStyle get blackS17W400NoChange =>
      blackS17W400.copyWith(color: AppColor.kBlackColor);
  TextStyle get blackS17W700 =>
      blackS17W400.copyWith(fontWeight: FontWeight.w700);
  TextStyle get blackS17W700NoChage =>
      blackS17W700.copyWith(color: AppColor.kBlackColor);

  TextStyle get blackS20W700 => blackS17W700.copyWith(fontSize: 20);

  ///*************************
  ///           WHITE
  ///*************************/

  TextStyle get whiteS13W400 =>
      whiteColor.copyWith(fontSize: 13, fontWeight: FontWeight.w400);
  TextStyle get whiteS13W400NoChange =>
      whiteS13W400.copyWith(color: AppColor.kWhiteColor);

  TextStyle get whiteS13W500 =>
      whiteS13W400.copyWith(fontWeight: FontWeight.w500);

  TextStyle get whiteS13W700 =>
      whiteS13W500.copyWith(fontWeight: FontWeight.w700);

  TextStyle get whiteS14W700 =>
      whiteColor.copyWith(fontSize: 17, fontWeight: FontWeight.w700);

  TextStyle get whiteS15W400 => whiteS13W400.copyWith(fontSize: 15);
  TextStyle get whiteS15W500 =>
      whiteS15W400.copyWith(fontWeight: FontWeight.w500);

  TextStyle get whiteS15W500NoChange =>
      whiteS15W500.copyWith(color: AppColor.kWhiteColor);
  TextStyle get whiteS17W400 => whiteS15W400.copyWith(fontSize: 17);
  TextStyle get whiteS17W700 =>
      whiteS17W400.copyWith(fontWeight: FontWeight.w700);
  TextStyle get whiteS17W700NoChange =>
      whiteS17W700.copyWith(color: AppColor.kWhiteColor);
  TextStyle get whiteS20W700NoChange =>
      whiteS17W700NoChange.copyWith(fontSize: 20);
  TextStyle get whiteS15W700 =>
      whiteS17W400.copyWith(fontWeight: FontWeight.w700);

  ///*************************
  ///           RED
  ///*************************/

  TextStyle get redS13W400 =>
      redColor.copyWith(fontSize: 13, fontWeight: FontWeight.w400);

  TextStyle get redS14W400 => redS13W400.copyWith(fontWeight: FontWeight.w500);

  TextStyle get redS13W500 => redS13W400.copyWith(fontWeight: FontWeight.w500);
  TextStyle get redS17W400 => redS13W400.copyWith(fontSize: 17);
  TextStyle get redS15W400 => redS13W400.copyWith(fontSize: 15);
  TextStyle get redS15W700 => redS15W400.copyWith(fontWeight: FontWeight.w700);
  TextStyle get redS17W7500 => redS17W400.copyWith(fontWeight: FontWeight.w500);
  TextStyle get redS17W700 => redS17W400.copyWith(fontWeight: FontWeight.w700);

  ///*************************
  ///           GREY
  ///*************************/

  TextStyle get greyS13W400 =>
      greyColor.copyWith(fontSize: 13, fontWeight: FontWeight.w400);

  TextStyle get greyS14W400 => greyS13W400.copyWith(fontSize: 14);
  TextStyle get greyS14W700 =>
      greyS14W400.copyWith(fontWeight: FontWeight.w700);

  TextStyle get greyS13W500 =>
      greyS13W400.copyWith(fontWeight: FontWeight.w500);

  TextStyle get greyS13W700 =>
      greyS13W400.copyWith(fontWeight: FontWeight.w700);

  TextStyle get greyS15W400 =>
      greyColor.copyWith(fontSize: 15, fontWeight: FontWeight.w400);

  TextStyle get greyS15W700 =>
      greyS15W400.copyWith(fontWeight: FontWeight.w700);

  TextStyle get greyS17W400 => greyS14W400.copyWith(fontSize: 17);
  TextStyle get greyS17W700 =>
      greyS15W700.copyWith(fontWeight: FontWeight.w700);

  ///*************************
  ///           MAIN
  ///*************************/

  TextStyle get mainS13W400 =>
      mainColor.copyWith(fontSize: 13, fontWeight: FontWeight.w400);
  TextStyle get mainS13W500 =>
      mainS13W400.copyWith(fontWeight: FontWeight.w500);

  TextStyle get mainS14W400 => mainS13W400.copyWith(fontSize: 14);
  TextStyle get mainS14W500 =>
      mainS14W400.copyWith(fontWeight: FontWeight.w500);
  TextStyle get mainS15W400 => mainS13W400.copyWith(fontSize: 15);

  TextStyle get mainS15W500 =>
      mainS15W400.copyWith(fontWeight: FontWeight.w500);

  TextStyle get mainS13W700 =>
      mainS13W400.copyWith(fontWeight: FontWeight.w700);

  ///
  // TextStyle get hintText => TextStyle(
  //     color: AppColor.grey.withOpacity(0.7),
  //     fontSize: 14,
  //     fontWeight: FontWeight.w400,
  //     fontFamily: FontFamily.roboto);
}
