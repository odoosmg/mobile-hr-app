part of 'table_calendar_dialog_bloc.dart';

class TableCalendarDialogEvent {}

/// TCD =- TableCalendarDialog
class TCDSelectedDate extends TableCalendarDialogEvent {
  final DateTime date;
  TCDSelectedDate(this.date);
}

class TCDFocusDate extends TableCalendarDialogEvent {
  final DateTime date;
  TCDFocusDate(this.date);
}

class TCDPageChange extends TableCalendarDialogEvent {}
