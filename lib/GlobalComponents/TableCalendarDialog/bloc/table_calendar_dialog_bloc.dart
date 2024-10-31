import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/Models/PublicHoliday/public_holiday_model.dart';
import 'package:hrm_employee/Screens/PublicHoliday/Bloc/public_holiday_bloc.dart';
import 'package:hrm_employee/Services/app_services.dart';
import 'package:hrm_employee/Services/database_service.dart';

part 'table_calendar_dialog_event.dart';
part 'table_calendar_dialog_state.dart';

class TableCalendarDialogBloc
    extends Bloc<TableCalendarDialogEvent, TableCalendarDialogState> {
  TableCalendarDialogBloc() : super(TableCalendarDialogInitial()) {
    on<TCDSelectedDate>(_selectedDate);
    on<TCDPageChange>(_pageChange);
    on<TCDFocusDate>(_focusDate);
  }

  void _selectedDate(
      TCDSelectedDate event, Emitter<TableCalendarDialogState> emit) async {
    state.selectedDate = event.date;
    emit(state.copyWith(state));
  }

  void _focusDate(
      TCDFocusDate event, Emitter<TableCalendarDialogState> emit) async {
    state.focusedDate = event.date;
    emit(state.copyWith(state));
  }

  void _pageChange(
      TCDPageChange event, Emitter<TableCalendarDialogState> emit) async {
    emit(state.copyWith(state));
  }
}
