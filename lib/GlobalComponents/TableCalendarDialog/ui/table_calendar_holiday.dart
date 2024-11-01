// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/Services/app_services.dart';
import 'package:hrm_employee/Services/database_service.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:hrm_employee/GlobalComponents/TableCalendarDialog/bloc/table_calendar_dialog_bloc.dart';
import 'package:hrm_employee/Models/PublicHoliday/public_holiday_model.dart';
import 'package:hrm_employee/extensions/date_extension.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/app_color.dart';

/// *******
/// Becareful when use  this.
/// public holiday retreive from local database
/// so when use ensure that publicHolidayBloc value is not null

class CustomTableCalendarHoliday extends StatefulWidget {
  final Function(DateTime) onSelected;
  const CustomTableCalendarHoliday({super.key, required this.onSelected});

  @override
  State<CustomTableCalendarHoliday> createState() =>
      _CustomTableCalendarHolidayState();
}

class _CustomTableCalendarHolidayState
    extends State<CustomTableCalendarHoliday> {
  final calendarBloc = TableCalendarDialogBloc();

  DateTime selectDate = DateTime.now();

  PublicHolidayModel publicHoliday = PublicHolidayModel();
  List<PublicHolidayModel> publicHolidayList = [];

  @override
  void initState() {
    calendarBloc.add(TCDFocusDate(DateTime.now()));

    publicHolidayList =
        AppServices.instance<DatabaseService>().getPublicHoliday?.list ?? [];

    /// prevent empty when use -1
    if (publicHolidayList.isNotEmpty) {
      publicHoliday = publicHolidayList[DateTime.now().month - 1];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => calendarBloc,
      child: _tableCalendar(),
    );
  }

  Widget _tableCalendar() {
    return BlocBuilder<TableCalendarDialogBloc, TableCalendarDialogState>(
      buildWhen: (previous, current) {
        return true;
      },
      builder: (context, state) {
        return TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: state.focusedDate!,
          currentDay: state.selectedDate,

          startingDayOfWeek: StartingDayOfWeek.monday,
          weekendDays: const [DateTime.sunday],
          headerStyle: const HeaderStyle(
            formatButtonShowsNext: false,
            formatButtonVisible: false,
          ),

          /// Fixed focusedData and currentyDay
          selectedDayPredicate: (day) => isSameDay(state.selectedDate, day),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: Theme.of(context).textTheme.blackS13W400NoChange,
            weekendStyle: Theme.of(context).textTheme.redS13W400,
          ),
          // enabledDayPredicate: (date) {
          //   // return false;
          //   return date.isAfter(date.subtract(Duration(days: 1))) &&
          //       date.isBefore(date.add(Duration(days: 1)));
          // },
          onDaySelected: (selectedDay, focusedDay) {
            widget.onSelected.call(selectedDay);

            /// To not select holiday
            /// sunday condition && selectedDay.weekday != 7
            if (!_isHoliday(selectedDay)) {
              calendarBloc.add(TCDSelectedDate(selectedDay));
            }
          },

          onPageChanged: (focusedDay) {
            /// check only current year
            if (focusedDay.year == DateTime.now().year) {
              publicHoliday = publicHolidayList[focusedDay.month - 1];
            }

            ///
            calendarBloc.add(TCDFocusDate(focusedDay));
          },
          calendarBuilders: CalendarBuilders(
            todayBuilder: (context, day, focusedDay) {
              return _selectedDate(day.day.toString());
            },
            selectedBuilder: (context, day, focusedDay) {
              return _selectedDate(day.day.toString());
            },
            defaultBuilder: (context, day, focusedDay) {
              return _selectedBuilder(day);
            },
            // disabledBuilder: (context, day, focusedDay) {
            //   return _disabledDate(day.day.toString());
            // },
            disabledBuilder: (context, date, _) {
              return Center(
                child: Text(
                  '${date.day}',
                  style: TextStyle(
                      color: Colors.green), // Style for disabled dates
                ),
              );
            },
          ),
          calendarStyle: CalendarStyle(
              // disabledTextStyle: Theme.of(context).textTheme.redColor,
              // disabledDecoration:
              //     BoxDecoration(color: Colors.red, shape: BoxShape.circle),

              // todayTextStyle: Theme.of(context).textTheme.whiteS13W400,
              // cellMargin: EdgeInsets.all(10),
              // selectedDecoration: const BoxDecoration(
              //   color: AppColor.kDangerColor,
              //   shape: BoxShape.circle,
              // ),
              // todayDecoration: BoxDecoration(
              //   color: AppColor.kMainColor,
              //   border: Border.fromBorderSide(
              //     BorderSide(
              //       style: BorderStyle.solid,
              //       color: AppColor.kMainColor,
              //     ),
              //   ),
              //   shape: BoxShape.circle,
              // ),
              ),
        );
      },
    );
  }

  Widget _selectedDate(String date) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: CircleAvatar(
          backgroundColor: Colors.blue,
          radius: 20,
          child: Text(
            date,
            style: Theme.of(context)
                .textTheme
                .blackS14W400
                .copyWith(color: AppColor.kWhiteColor),
          ),
        ),
      ),
    );
  }

  Widget _disabledDate(String date) {
    return Text(date, style: Theme.of(context).textTheme.redS14W400);
  }

  Widget _selectedBuilder(DateTime date) {
    Color color = AppColor.kBlackColor;

    /// check holiday only in current year
    if (date.year == DateTime.now().year) {
      /// if has holiday
      if (_isHoliday(date)) {
        color = AppColor.kDangerColor;
      }
    }
    return Container(
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 6),
      child: Text(
        date.day.toString(),
        style: Theme.of(context).textTheme.blackS15W400.copyWith(color: color),
      ),
    );
  }

  bool _isHoliday(DateTime date) {
    return publicHoliday
        .getListStrDates()
        .contains(date.dateFormat(toFormat: "yyyy-MM-dd"));
  }
}
