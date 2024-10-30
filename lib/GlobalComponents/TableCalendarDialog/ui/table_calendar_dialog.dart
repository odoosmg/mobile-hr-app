// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_employee/GlobalComponents/TableCalendarDialog/bloc/table_calendar_dialog_bloc.dart';
import 'package:hrm_employee/Models/PublicHoliday/public_holiday_model.dart';
import 'package:hrm_employee/Screens/Leave%20Management/leave_to_approve_list_screen.dart';
import 'package:hrm_employee/Services/app_services.dart';
import 'package:hrm_employee/Services/database_service.dart';
import 'package:hrm_employee/extensions/date_extension.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/app_color.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hrm_employee/Screens/Leave%20Management/bloc/leave_bloc.dart';
import 'package:hrm_employee/Screens/Leave%20Management/leave_apply.dart';
import 'package:hrm_employee/Screens/components/appbar/custom_appbar.dart';
import 'package:hrm_employee/Screens/components/others/custom_scaffold.dart';
import 'package:hrm_employee/Screens/Leave%20Management/leave_my_attendance_list.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../constant.dart';

class TableCalendarDialog extends StatefulWidget {
  const TableCalendarDialog({super.key});

  @override
  State<TableCalendarDialog> createState() => _TableCalendarDialogState();
}

class _TableCalendarDialogState extends State<TableCalendarDialog> {
  final calendarBloc = TableCalendarDialogBloc();

  DateTime selectDate = DateTime.now();

  PublicHolidayModel publicHoliday = PublicHolidayModel();

  @override
  void initState() {
    calendarBloc.add(TCDGetPublicHolidays());
    // publicHoliday =
    //     calendarBloc.state.publicHolidays![DateTime.now().month - 1];
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
          headerStyle: const HeaderStyle(
            formatButtonShowsNext: false,
            formatButtonVisible: false,
          ),
          // selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            calendarBloc.add(TCDSelectedDate(selectedDay));

            // Navigator.of(context)
            //     .pop(); // Close dialog on date selection
          },
          onPageChanged: (focusedDay) {
            publicHoliday =
                calendarBloc.state.publicHolidays![focusedDay.month - 1];
            // calendarBloc.add(TCDPageChange());
            calendarBloc.add(TCDFocusDate(focusedDay));
          },
          calendarBuilders: CalendarBuilders(
            selectedBuilder: (context, day, focusedDay) {
              return Text(
                day.day.toString(),
                style: Theme.of(context).textTheme.redS13W400,
              );
            },
            defaultBuilder: (context, day, focusedDay) {
              final PublicHolidayModel month = publicHoliday;
              // print("daa= ======= ${day.dateFormat(toFormat: "yyyy-MM-dd")}");
              // print("mongh ===== ${}");

              Color color = month
                      .getListStrDates()
                      .contains(day.dateFormat(toFormat: "yyyy-MM-dd"))
                  ? AppColor.kDangerColor
                  : AppColor.kBlackColor;
              return Container(
                padding: EdgeInsets.all(14),
                child: Text(
                  day.day.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .blackS15W400
                      .copyWith(color: color),
                ),
              );
            },
          ),

          calendarStyle: const CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: AppColor.kMainColor,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: AppColor.kMainColor,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}
