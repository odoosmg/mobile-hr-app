import 'package:flutter/material.dart';
import 'package:hrm_employee/utlis/app_color.dart';

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
}

enum AppEnviroment {
  dev('dev'),
  stag('stag'),
  prod('prod');

  const AppEnviroment(this.name);
  final String name;
}

enum BtnStatus { ok, disabled, loading }

/// To prevent(condition) build everytime on WhenBuild method
enum BlocEventType { requestApi, validateForm, others }

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
