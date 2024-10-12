part of 'public_holiday_bloc.dart';

class PublicHolidayState {
  PublicHolidayStateType? stateType;
  ApiResult<PublicHolidayModel>? listResult;

  PublicHolidayState({
    this.stateType,
    this.listResult,
  });

  PublicHolidayState copyWith(PublicHolidayState d) {
    return PublicHolidayState(
      stateType: d.stateType,
      listResult: d.listResult,
    );
  }
}

final class PublicHolidayInitial extends PublicHolidayState {
  @override
  ApiResult<PublicHolidayModel>? get listResult => ApiResult()
    ..status = ApiStatus.loading
    ..data = PublicHolidayModel();
}

enum PublicHolidayStateType {
  list,
}
