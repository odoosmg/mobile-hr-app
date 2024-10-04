part of 'leave_bloc.dart';

class LeaveState {
  LeaveStateType? stateType;
  ApiResult<LeaveModel>? listTypeResult;

  double? dayCount; // how many day request leave
  bool? isHalfDay;

  LeaveState({
    this.stateType,
    this.dayCount,
    this.isHalfDay,
    this.listTypeResult,
  });

  LeaveState copyWith(LeaveState d) {
    return LeaveState(
      stateType: d.stateType,
      dayCount: d.dayCount,
      isHalfDay: d.isHalfDay,
      listTypeResult: d.listTypeResult,
    );
  }
}

final class LeaveInitial extends LeaveState {
  @override
  bool? get isHalfDay => false;

  @override
  double? get dayCount => 1; // init value is today. so the count is 1

  @override
  ApiResult<LeaveModel>? get listTypeResult => ApiResult()
    ..status = ApiStatus.loading
    ..data = LeaveModel();
}

enum LeaveStateType {
  fullOrHalfDay,
  leaveTypeList,
  dayCount,
}
