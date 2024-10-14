part of 'public_holiday_bloc.dart';

class PublicHolidayEvent {}

class PublicHolidayByYear extends PublicHolidayEvent {
  final int year;
  final int month;
  PublicHolidayByYear(this.year, this.month);
}

class PublicHolidayCalendarHolidays extends PublicHolidayEvent {
  final int month;
  PublicHolidayCalendarHolidays(this.month);
}
