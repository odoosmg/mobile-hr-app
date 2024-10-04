part of 'leave_bloc.dart';

class LeaveEvent {}

final class LeaveDaySwitch extends LeaveEvent {
  bool isFullday;
  LeaveDaySwitch(this.isFullday);
}
