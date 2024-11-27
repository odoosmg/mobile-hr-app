import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:hrm_employee/extensions/date_extension.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/app_color.dart';
import 'package:hrm_employee/utlis/measurement.dart';

class SaleTableCalendar extends StatefulWidget {
  final Function(DateTime) onSelectedDate;
  const SaleTableCalendar({super.key, required this.onSelectedDate});

  @override
  State<SaleTableCalendar> createState() => _SaleTableCalendarState();
}

class _SaleTableCalendarState extends State<SaleTableCalendar> {
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: AppColor.white,
      padding: const EdgeInsets.only(bottom: Measurement.screenPadding),
      decoration: BoxDecoration(
        color: AppColor.kWhiteColor,

        /// shadow
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.shade500,
              blurRadius: 8,
              offset: const Offset(0.0, 0.2))
        ],
      ),
      child: TableCalendar(
        daysOfWeekHeight: 20,
        focusedDay: selectedDate,
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.now(),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,

          /// title style
          titleTextStyle: Theme.of(context).textTheme.blackS15W400NoChange,
          rightChevronIcon: const Icon(
            Icons.chevron_right,
            color: AppColor.kBlackColor,
          ),
          leftChevronIcon: const Icon(
            Icons.chevron_left,
            color: AppColor.kBlackColor,
          ),
        ),
        startingDayOfWeek: StartingDayOfWeek.monday,
        weekendDays: const [DateTime.sunday],

        /// Format
        calendarFormat: CalendarFormat.week,
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: Theme.of(context).textTheme.blackS13W400NoChange,
          weekendStyle: Theme.of(context).textTheme.redS13W400,
        ),

        /// Calendar Builer
        /// custom style
        calendarBuilders: CalendarBuilders(
          /// Today
          todayBuilder: (context, date, event) {
            return _calendarDeco(
              day: date.day,
              color: AppColor.saMain,
              dayTextStyle: Theme.of(context).textTheme.greyS13W700,

              /// prevent select other date,
              /// still select now()
              isDecoration:
                  selectedDate.dateFormat() == DateTime.now().dateFormat(),
            );
          },

          /// Default
          defaultBuilder: (context, date, focusedDay) {
            return _calendarDeco(
              day: date.day,
              dayTextStyle: Theme.of(context).textTheme.greyS13W700,
              isDecoration: false,
            );
          },

          /// Disabled
          disabledBuilder: (context, date, focusedDay) {
            return _calendarDeco(
              day: date.day,
              dayTextStyle: Theme.of(context)
                  .textTheme
                  .greyS13W400
                  .copyWith(color: AppColor.kGreyTextColor.withOpacity(0.7)),
              isDecoration: false,
            );
          },

          /// Selected
          selectedBuilder: (context, date, event) {
            return _calendarDeco(
                day: selectedDate.day,
                color: AppColor.saMain,
                dayTextStyle: Theme.of(context).textTheme.greyS13W700);
          },
        ),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            selectedDate = selectedDay;
          });
          widget.onSelectedDate.call(selectedDay);
          // setState(() {});
          // selectedDate.refresh;
        },
        selectedDayPredicate: (date) {
          // selectedDate(date);
          if (selectedDate == date) {
            return true;
          }
          return false;
        },
      ),
    );
  }

  Widget _calendarDeco({
    required int day,
    Color? color,
    TextStyle? dayTextStyle,

    /// if true, [color] must have value, if not will null error
    bool isDecoration = true,
  }) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: !isDecoration
          ? null
          : BoxDecoration(
              shape: BoxShape.circle,
              color: color?.withOpacity(0.2),
              border: Border.all(
                color: color!,
                width: 0.6,
              ),
            ),
      child: Center(
        child: Text(
          day.toString(),
          style: dayTextStyle ?? Theme.of(context).textTheme.blackS13W400,
        ),
      ),
    );
  }
}
