part of 'public_holiday_bloc.dart';

class PublicHolidayState {
  PublicHolidayStateType? stateType;
  ApiResult<PublicHolidayModel>? listResult;
  PublicHolidayModel? calendarHolidays;

  PublicHolidayState({
    this.stateType,
    this.listResult,
    this.calendarHolidays,
  });

  PublicHolidayState copyWith(PublicHolidayState d) {
    return PublicHolidayState(
      stateType: d.stateType,
      listResult: d.listResult,
      calendarHolidays: d.calendarHolidays,
    );
  }
}

final class PublicHolidayInitial extends PublicHolidayState {
  @override
  ApiResult<PublicHolidayModel>? get listResult => ApiResult()
    ..status = ApiStatus.loading
    ..data = PublicHolidayModel();

  @override
  PublicHolidayModel get calendarHolidays => PublicHolidayModel();
}

enum PublicHolidayStateType {
  list,
  calendarHolidays,
}
