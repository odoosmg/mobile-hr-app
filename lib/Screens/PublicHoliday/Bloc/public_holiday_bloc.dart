import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/Models/api/api_result.dart';
import 'package:hrm_employee/Repository/public_holiday_repository.dart';

part 'public_holiday_event.dart';
part 'public_holiday_state.dart';

class PublicHolidayBloc extends Bloc<PublicHolidayEvent, PublicHolidayState> {
  final PublicHolidayRepository publicHolidayRepository;
  PublicHolidayBloc(this.publicHolidayRepository)
      : super(PublicHolidayInitial()) {
    on<PublicHolidayByYear>(_holidayByYear);
  }

  void _holidayByYear(
      PublicHolidayByYear event, Emitter<PublicHolidayState> emit) async {
    await publicHolidayRepository.byYear("2024").then((value) {});
  }
}
