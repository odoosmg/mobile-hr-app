import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/Screens/PublicHoliday/Bloc/public_holiday_bloc.dart';
import 'package:hrm_employee/Screens/components/appbar/custom_appbar.dart';
import 'package:hrm_employee/Screens/components/others/custom_scaffold.dart';
import 'package:hrm_employee/Screens/components/others/xborder.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/measurement.dart';
import 'package:hrm_employee/utlis/measurement_widget_extension.dart';
import 'package:table_calendar/table_calendar.dart';

class PublicHolidayScreen extends StatefulWidget {
  const PublicHolidayScreen({super.key});

  @override
  State<PublicHolidayScreen> createState() => _PublicHolidayScreenState();
}

class _PublicHolidayScreenState extends State<PublicHolidayScreen> {
  late PublicHolidayBloc publicHolidayBloc;
  @override
  void initState() {
    publicHolidayBloc = context.read<PublicHolidayBloc>();
    publicHolidayBloc.add(PublicHolidayByYear());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar.titleActions(title: "Public Holiday"),
      body: Column(
        children: [
          _tableCalendar(),
          const Padding(
            padding:
                EdgeInsets.only(top: Measurement.screenPadding, bottom: 10),
            child: Xborder(),
          ),

          ///
          _dayCell(),

          _dayCell(),

          _dayCell(),
        ],
      ),
    );
  }

  Widget _tableCalendar() {
    return TableCalendar(
      focusedDay: DateTime.now(),
      firstDay: DateTime(2020),
      lastDay: DateTime(2050),
      headerStyle: const HeaderStyle(formatButtonVisible: false),
      weekendDays: const [DateTime.sunday],
      daysOfWeekStyle: DaysOfWeekStyle(
        // weekdayStyle: Get.textTheme.blackS13W400NoChange,
        weekendStyle: Theme.of(context).textTheme.redS13W400,
      ),
      calendarBuilders: CalendarBuilders(
        /// Today
        todayBuilder: (context, date, event) {
          return _calendarDeco(
            day: date.day,
            dayTextStyle: Theme.of(context).textTheme.redS13W400,
            isDecoration: false,
          );
        },

        /// Default
        defaultBuilder: (context, date, focusedDay) {
          return _calendarDeco(
            day: date.day,
            dayTextStyle: Theme.of(context).textTheme.redS13W400,
            isDecoration: false,
          );
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

  Widget _dayCell() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 10),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                "12",
                style: Theme.of(context).textTheme.blackS13W700,
              ),
              Text(
                "Tue",
                style: Theme.of(context).textTheme.blackS10W400,
              ),
            ],
          ),
          Measurement.screenPadding.width,
          Expanded(
            child: Text("Khmer New Year",
                style: Theme.of(context).textTheme.blackS14W500),
          )
        ],
      ),
    );
  }
}
