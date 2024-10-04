part of 'leave_bloc.dart';

class LeaveEvent {}

final class LeaveDaySwitch extends LeaveEvent {
  bool isFullday;
  LeaveDaySwitch(this.isFullday);
}

final class LeaveTypeListForm extends LeaveEvent {}

final class LeaveDayCount extends LeaveEvent {
  final String from;
  final String to;

  LeaveDayCount({
    required this.from,
    required this.to,
  });
}
