part of 'leave_bloc.dart';

class LeaveState {
  LeaveStateType? stateType;
  ApiResult<LeaveModel>? listTypeResult;
  ApiResult? submitLeaveResult;
  ApiResult<EmployeeModel>? myLeaveListResult;

  double? dayCount; // how many day request leave
  bool? isHalfDay;

  // bool? isShowSelectFullHalf; // full or half day

  LeaveState({
    this.stateType,
    this.dayCount,
    this.isHalfDay,
    this.listTypeResult,
    this.submitLeaveResult,
    this.myLeaveListResult,
    // this.isShowSelectFullHalf,
  });

  LeaveState copyWith(LeaveState d) {
    return LeaveState(
      stateType: d.stateType,
      dayCount: d.dayCount,
      isHalfDay: d.isHalfDay,
      listTypeResult: d.listTypeResult,
      submitLeaveResult: d.submitLeaveResult,
      myLeaveListResult: d.myLeaveListResult,
      // isShowSelectFullHalf: d.isShowSelectFullHalf,
    );
  }
}

final class LeaveInitial extends LeaveState {
  @override
  bool? get isHalfDay => false;

  @override
  double? get dayCount => 1; // init value is today. so the count is 1

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
  ApiResult<EmployeeModel>? get myLeaveListResult =>
      ApiResult()..status = ApiStatus.loading;
}

enum LeaveStateType {
  fullOrHalfDay,
  leaveTypeList,
  isShowFullHalf,
  dayCount,
  submit,
  myLeaveList,
}
