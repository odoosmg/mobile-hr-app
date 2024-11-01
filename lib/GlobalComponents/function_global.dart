import 'package:flutter/material.dart';
import 'package:hrm_employee/GlobalComponents/TableCalendarDialog/ui/table_calendar_holiday.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/app_color.dart';
import 'package:hrm_employee/utlis/measurement_widget_extension.dart';

Future<DateTime?> showHolidayCalendar({
  required BuildContext context,
  String? title,
}) async {
  /// store date value
  DateTime d = DateTime.now();
  bool isOk = false;
  await showDialog<DateTime?>(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              10.kHeight,
              Text(
                title ?? "Select a Date",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              /// Table Calendar
              CustomTableCalendarHoliday(
                onSelected: (date) {
                  d = date;
                },
              ),

              /// Button
              Container(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: Theme.of(context)
                            .textTheme
                            .blackS15W700
                            .copyWith(color: Colors.purple.shade700),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        isOk = true;
                        // print("ok ==== $d");
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Ok",
                        style: Theme.of(context)
                            .textTheme
                            .blackS15W700
                            .copyWith(color: Colors.purple.shade700),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  /// if submit Ok button return date
  if (isOk) {
    return d;
  }
  return null;
}
