import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/PublicHoliday/public_holiday_model.dart';
import 'package:hrm_employee/Screens/PublicHoliday/Bloc/public_holiday_bloc.dart';
import 'package:hrm_employee/Screens/components/appbar/custom_appbar.dart';
import 'package:hrm_employee/Screens/components/kbuilder/k_builder.dart';
import 'package:hrm_employee/Screens/components/others/custom_scaffold.dart';
import 'package:hrm_employee/Screens/components/others/xborder.dart';
import 'package:hrm_employee/Services/app_services.dart';
import 'package:hrm_employee/Services/database_service.dart';
import 'package:hrm_employee/extensions/date_extension.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/app_color.dart';
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

  /// month : for index
  /// year : for call api when goto next or previous year

  DateTime focusedDate = DateTime.now();

  @override
  void initState() {
    publicHolidayBloc = context.read<PublicHolidayBloc>();
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar.titleCompany(
          title: "Public Holiday", onChanged: (v, _) {}),
      body: Column(
        children: [
          _tableCalendar(),
          const Padding(
            padding:
                EdgeInsets.only(top: Measurement.screenPadding, bottom: 10),
            child: Xborder(),
          ),
          _daysBloc(),
        ],
      ),
    );
  }

  Widget _tableCalendar() {
    return TableCalendar(
      focusedDay: focusedDate,
      firstDay: DateTime(2010),
      lastDay: DateTime(2050),
      headerStyle: const HeaderStyle(formatButtonVisible: false),
      weekendDays: const [DateTime.sunday],
      daysOfWeekStyle: DaysOfWeekStyle(
        // weekdayStyle: Get.textTheme.blackS13W400NoChange,
        weekendStyle: Theme.of(context).textTheme.redS13W400,
      ),
      onPageChanged: (date) async {
        /// New year
        if (focusedDate.year != date.year) {
          focusedDate = date;
          _getData();
        }

        ///
        focusedDate = date;

        // await Future.delayed(Duration(milliseconds: 500));
        publicHolidayBloc.add(PublicHolidayCalendarHolidays(date.month));
      },
      calendarBuilders: CalendarBuilders(
        /// Today
        todayBuilder: (context, date, event) {
          return _calendarDays(date);
        },

        /// Default
        defaultBuilder: (context, date, focusedDay) {
          return _calendarDays(date);
        },
      ),
    );
  }

  Widget _daysBloc() {
    return BlocBuilder<PublicHolidayBloc, PublicHolidayState>(
        buildWhen: (previous, current) {
      return current.stateType == PublicHolidayStateType.calendarHolidays;
    }, builder: (ctx, state) {
      return KBuilder(
        status: state.listResult!.status!,
        onRetry: _getData,
        builder: (st) {
          return st == ApiStatus.loading
              ? Container()
              : _holiday(state.listResult?.data?.list![focusedDate.month - 1]
                      .holidays ??
                  []);
        },
      );
    });
  }

  Widget _holiday(List<PublicHolidayModel> holidays) {
    return Column(
      children: [
        for (int i = 0; i < holidays.length; i++) _holidayCell(holidays[i])
      ],
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

  Widget _holidayCell(PublicHolidayModel data) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 10),
      child: Row(
        children: [
          Column(
            children: [
              /// day
              Text(
                DateTime.parse(data.date!)
                    .dateFormat(toFormat: "dd")
                    .toString(),
                style: Theme.of(context).textTheme.blackS14W700,
              ),

              /// day of the week, Mon Tue...
              Text(
                  DateTime.parse(data.date!)
                      .dateFormat(toFormat: "EEE")
                      .toString(),
                  style: Theme.of(context).textTheme.blackS10W400),
            ],
          ),
          Measurement.screenPadding.kWidth,
          Expanded(
            child: Text(data.name ?? "",
                style: Theme.of(context).textTheme.blackS14W500),
          )
        ],
      ),
    );
  }

  ///
  Widget _calendarDays(DateTime date) {
    return BlocBuilder<PublicHolidayBloc, PublicHolidayState>(
        buildWhen: (previous, current) {
      return current.stateType == PublicHolidayStateType.calendarHolidays;
    }, builder: (ctx, state) {
      bool isHoliday = _isHoliday(date);
      return _calendarDeco(
        day: date.day,
        dayTextStyle: Theme.of(context).textTheme.redS13W400.copyWith(
            color: isHoliday // true = red
                ? AppColor.kDangerColor
                : AppColor.kBlackColor),
        color: isHoliday // background circle
            ? AppColor.kDangerColor
            : Colors.white,
        isDecoration: true,
      );
    });
  }

  bool _isHoliday(DateTime date) {
    List<String> holidayDays =
        publicHolidayBloc.state.calendarHolidays?.getListStrDates() ?? [];

    return holidayDays.contains(date.dateFormat(toFormat: "yyyy-MM-dd"));
  }

  void _getData() {
    publicHolidayBloc.add(
      PublicHolidayByYear(focusedDate.year, focusedDate.month),
    );
  }

  @override
  void dispose() {
    publicHolidayBloc.add(PublicHolidayDispose());
    super.dispose();
  }
}
