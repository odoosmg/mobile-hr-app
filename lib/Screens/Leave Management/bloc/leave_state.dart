part of 'leave_bloc.dart';

class LeaveState {
  LeaveStateType? stateType;
  ApiResult<LeaveModel>? listTypeResult;
  bool? isHalfDay;

  LeaveState({
    this.stateType,
    this.isHalfDay,
    this.listTypeResult,
  });

  LeaveState copyWith(LeaveState d) {
    return LeaveState(
      stateType: d.stateType,
      isHalfDay: d.isHalfDay,
      listTypeResult: d.listTypeResult,
    );
  }
}

final class LeaveInitial extends LeaveState {
  @override
  bool? get isHalfDay => false;

  @override
  ApiResult<LeaveModel>? get listTypeResult => ApiResult()
    ..status = ApiStatus.loading
    ..data = LeaveModel();
}

enum LeaveStateType {
  fullAndHalfDay,
  leaveTypeList,
}
