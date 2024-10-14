import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/PublicHoliday/public_holiday_model.dart';
import 'package:hrm_employee/Models/api/api_result.dart';
import 'package:hrm_employee/Repository/public_holiday_repository.dart';

part 'public_holiday_event.dart';
part 'public_holiday_state.dart';

class PublicHolidayBloc extends Bloc<PublicHolidayEvent, PublicHolidayState> {
  final PublicHolidayRepository publicHolidayRepository;
  PublicHolidayBloc(this.publicHolidayRepository)
      : super(PublicHolidayInitial()) {
    on<PublicHolidayByYear>(_holidayByYear);
    on<PublicHolidayCalendarHolidays>(_calendarHolidays);
  }

  void _holidayByYear(
      PublicHolidayByYear event, Emitter<PublicHolidayState> emit) async {
    state.stateType = PublicHolidayStateType.list;
    state.listResult!.status = ApiStatus.loading;
    emit(state.copyWith(state));

    await publicHolidayRepository.byYear(event.year.toString()).then((value) {
      /// after get data, rebuild calendar
      if (value.isSuccess) {
        state.stateType = PublicHolidayStateType.calendarHolidays;
        state.calendarHolidays = state.listResult!.data!.list![event.month - 1];
        emit(state.copyWith(state));
      }
      state.listResult = value;
      emit(state.copyWith(state));
    });
  }

  void _calendarHolidays(PublicHolidayCalendarHolidays event,
      Emitter<PublicHolidayState> emit) async {
    state.stateType = PublicHolidayStateType.calendarHolidays;
    state.calendarHolidays = state.listResult!.data!.list![event.month - 1];
    emit(state.copyWith(state));
  }
}
