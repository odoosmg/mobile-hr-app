part of 'leave_bloc.dart';

class LeaveEvent {}

final class LeaveDaySwitch extends LeaveEvent {
  bool isHalfDay;
  LeaveDaySwitch(this.isHalfDay);
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

final class LeaveSubmit extends LeaveEvent {
  final LeaveModel params;
  LeaveSubmit({required this.params});
}

final class LeaveShowFullHalf extends LeaveEvent {
  final bool isShow;
  LeaveShowFullHalf(this.isShow);
}

final class LeaveMyList extends LeaveEvent {
  final bool isLoading;
  final bool isRebuild;
  LeaveMyList({required this.isLoading, this.isRebuild = false});
}

final class LeaveToApproveList extends LeaveEvent {
  final bool isLoading;
  final bool isRebuild;
  LeaveToApproveList({required this.isLoading, this.isRebuild = false});
}

final class LeaveAction extends LeaveEvent {
  final LeaveModel data;
  final int index;
  final LeaveStatus status;
  LeaveAction({required this.data, required this.index, required this.status});
}

final class LeaveListScreenDispose extends LeaveEvent {}

final class LeaveInitialDayCount extends LeaveEvent {}

final class LeaveAttendanceList extends LeaveEvent {
  final bool isLoading;
  final bool isRefresh;
  LeaveAttendanceList({this.isRefresh = false, this.isLoading = false});
}

final class LeaveAttendanceListDispose extends LeaveEvent {}
