import 'package:flutter/material.dart';
import 'package:hrm_employee/utlis/app_color.dart';
import 'dart:developer' as developer;

enum ApiStatus {
  loading,
  success,
  failed,
  connectionError,
  loginExpired,
  unAuthorize,
  empty; // empty data

  int? get statusCode {
    switch (this) {
      case loading:
        return null;
      case connectionError:
        return 503;
      case unAuthorize:
        return 401;

      /// means both is success
      case success:
      case empty:
        return 200;
      default:
        return 400;
    }
  }
}

enum Method {
  get('GET'),
  post('POST'),
  put('PUT'),
  delete('DELETE');

  const Method(this.name);
  final String name;
}

enum Logger {
  red("31"),
  green("32"),
  yellow("33"),
  blue("34"),
  magenta("35"),
  cyan("36"),
  white("37");

  final String code;
  const Logger(this.code);

  void log(String text) => debugPrint('\x1B[${code}m$text\x1B[0m');
  // void log(String text) => developer.log('# $text');
}

enum AppEnviroment {
  dev('dev'),
  stag('stag'),
  prod('prod');

  const AppEnviroment(this.name);
  final String name;
}

enum BtnStatus { ok, disabled, loading }

enum AttendanceDayStatus {
  present, // checkin
  absent, // not come to work
  holiday; // holiday day

  Color get bgColor {
    switch (this) {
      case present:
        return AppColor.kGreenColor;
      case absent:
        return AppColor.kDangerColor;

      default:

        /// holiday
        return Colors.transparent;
    }
  }
}

enum AttendanceInOutStatus { checkIn, checkOut }

enum LeaveStatus {
  approved,
  refused,
  pending;

  Color get getColor {
    switch (this) {
      case approved:
        return AppColor.kGreenColor;
      case refused:
        return AppColor.kDangerColor;
      default:

        /// pending
        return AppColor.kAlertColor;
    }
  }

  IconData get iconData {
    switch (this) {
      case approved:
        return Icons.check;
      case refused:
        return Icons.close;
      default:

        /// pending
        return Icons.hourglass_empty;
    }
  }

  String get keyword {
    switch (this) {
      case approved:
        return "approve";
      case refused:
        return "refuse";
      default:
        return "to_approve";
    }
  }

  String get name {
    switch (this) {
      case approved:
        return "Approved";
      case refused:
        return "Refused";
      default:
        return "To Approv";
    }
  }
}

enum SaleActivtyStatus {
  todo("todo"),
  checkin("check-in"),
  checkout("check-out"),
  checkoutOrder("check-out-order");

  const SaleActivtyStatus(this.name);
  final String name;

  Color get bgColor {
    switch (this) {
      case todo:
        return Colors.grey;
      case checkout:
        return const Color.fromARGB(255, 193, 148, 82);
      case checkoutOrder:
        return Colors.green.shade700;
      default:

        /// checkin
        return const Color.fromARGB(255, 72, 141, 197);
    }
  }
}
