part of 'leave_bloc.dart';

class LeaveState {
  LeaveStateType? stateType;
  ApiResult<LeaveModel>? listTypeResult;
  ApiResult? submitLeaveResult;
  ApiResult<LeaveModel>? myLeaveListResult;
  ApiResult<LeaveModel>? leaveActionResult;
  ApiResult<LeaveModel>? toApproveListResult;

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
    );
  }
}

final class LeaveInitial extends LeaveState {
  @override
  bool? get isHalfDay => false;

  @override
  double? get dayCount {
    final holidays =
        AppServices.instance<DatabaseService>().getPublicHoliday?.list ?? [];

    /// if today is holiday return 0
    if (holidays.isNotEmpty) {
      if (holidays[DateTime.now().month - 1]
          .getListStrDates()
          .contains(DateTime.now().dateFormat(toFormat: "yyyy-MM-dd"))) {
        return 0;
      }
    }

    /// default value set as 1
    return 1;
  }

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
}

enum LeaveStateType {
  fullOrHalfDay,
  leaveTypeList,
  isShowFullHalf,
  dayCount,
  submit,
  myLeaveList,
  toApproveList,
  leaveAction
}
