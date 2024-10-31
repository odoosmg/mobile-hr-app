part of 'table_calendar_dialog_bloc.dart';

class TableCalendarDialogState {
  StateType? stateType;
  DateTime? selectedDate;
  DateTime? focusedDate;

  TableCalendarDialogState({
    this.stateType,
    this.selectedDate,
    this.focusedDate,
  });

  TableCalendarDialogState copyWith(TableCalendarDialogState d) {
    return TableCalendarDialogState(
      stateType: d.stateType,
      selectedDate: d.selectedDate,
      focusedDate: d.focusedDate,
    );
  }
}

final class TableCalendarDialogInitial extends TableCalendarDialogState {
  // @override
  // DateTime get selectedDate => DateTime.now();

  @override
  DateTime get focusedDate => DateTime.now();
}

enum StateType {
  selectedDate,
}
