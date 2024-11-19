// ignore_for_file: depend_on_referenced_packages

import 'package:intl/intl.dart' show DateFormat;

extension DateExtension on DateTime {
  ///
  String? dateFormat({
    /// specify currentDate format,
    /// to able to convert to new format.
    /// current flutter date format.
    /// *note: somehow 'uuu' and 'mmm' not working
    String currentFormat = "yyyy-MM-dd HH:mm:ss",
    String toFormat = "dd-MM-yyyy",
  }) {
    try {
      // ignore: unnecessary_this
      String d = this.toString();

      /// original
      String currentDate = DateFormat(currentFormat).format(DateTime.parse(d));

      /// new fomart
      String newDateTime =
          DateFormat(toFormat).format(DateTime.parse(currentDate));

      return newDateTime.toString();
    } catch (e) {
      /// return null, specify error
      return null;
    }
  }

  String? utcToLocal({
    String currentFormat = "yyyy-MM-dd HH:mm:ss",
    String toForamt = "yyyy-MM-dd HH:mm:ss",
  }) {
    try {
      // ignore: unnecessary_this
      String date = this.toString();

      /// utc to local
      DateTime d = DateFormat(currentFormat).parse(date, true).toLocal();
      return d
          .dateFormat(currentFormat: "yyyy-MM-dd HH:mm:ss", toFormat: toForamt)
          .toString();
    } catch (e) {
      return null;
    }
  }
}
