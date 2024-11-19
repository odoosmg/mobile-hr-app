part of 'leave_bloc.dart';

class LeaveState {
  LeaveStateType? stateType;
  ApiResult<LeaveModel>? listTypeResult;
  ApiResult? submitLeaveResult;
  ApiResult<LeaveModel>? myLeaveListResult;
  ApiResult<LeaveModel>? leaveActionResult;
  ApiResult<LeaveModel>? toApproveListResult;
  ApiResult<InOutModel>? attendanceListResult;

  double? dayCount; // how many day request leave
  bool? isHalfDay;

  LeaveState({
    this.stateType,
    this.dayCount,
    this.isHalfDay,
    this.listTypeResult,
    this.submitLeaveResult,
    this.myLeaveListResult,
    this.leaveActionResult,
    this.toApproveListResult,
    this.attendanceListResult,
  });

  LeaveState copyWith(LeaveState d) {
    return LeaveState(
      stateType: d.stateType,
      dayCount: d.dayCount,
      isHalfDay: d.isHalfDay,
      listTypeResult: d.listTypeResult,
      submitLeaveResult: d.submitLeaveResult,
      myLeaveListResult: d.myLeaveListResult,
      toApproveListResult: d.toApproveListResult,
      leaveActionResult: leaveActionResult,
      attendanceListResult: attendanceListResult,
    );
  }
}

final class LeaveInitial extends LeaveState {
  @override
  bool? get isHalfDay => false;

  @override
  double? get dayCount => 1; // today, so count as 1

  @override
  // bool? get isShowSelectFullHalf => true;

  @override
  ApiResult<LeaveModel>? get listTypeResult => ApiResult()
    ..status = ApiStatus.loading
    ..data = LeaveModel();

  @override
  ApiResult<LeaveModel>? get submitLeaveResult =>
      ApiResult()..status = ApiStatus.loading;

  @override
  ApiResult<LeaveModel>? get myLeaveListResult =>
      ApiResult()..status = ApiStatus.loading;
  @override
  ApiResult<LeaveModel>? get toApproveListResult =>
      ApiResult()..status = ApiStatus.loading;

  @override
  ApiResult<LeaveModel>? get leaveActionResult =>
      ApiResult()..status = ApiStatus.loading;

  @override
  ApiResult<InOutModel>? get attendanceListResult =>
      ApiResult()..status = ApiStatus.loading;
}

enum LeaveStateType {
  fullOrHalfDay,
  leaveTypeList,
  isShowFullHalf,
  dayCount,
  submit,
  myLeaveList,
  toApproveList,
  leaveAction,
  attendanceList,
}
