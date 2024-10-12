part of 'public_holiday_bloc.dart';

class PublicHolidayEvent {}

class PublicHolidayByYear extends PublicHolidayEvent {
  final String year;
  PublicHolidayByYear(this.year);
}

class PublicHolidayCalendarHolidays extends PublicHolidayEvent {
  final int index;
  PublicHolidayCalendarHolidays(this.index);
}
