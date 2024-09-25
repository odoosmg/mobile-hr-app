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
}
