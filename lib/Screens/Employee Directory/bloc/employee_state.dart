part of 'employee_bloc.dart';

class EmployeeState {
  EmployeeStateType? stateType;
  ApiResult<EmployeeModel>? listResult;
  ApiResult<UserModel>? detailResult;

  EmployeeState({
    this.stateType,
    this.listResult,
    this.detailResult,
  });

  EmployeeState copyWith(EmployeeState d) {
    return EmployeeState(
      stateType: d.stateType,
      listResult: d.listResult,
      detailResult: d.detailResult,
    );
  }
}

final class EmployeeInitial extends EmployeeState {
  @override
  ApiResult<EmployeeModel>? get listResult => ApiResult()
    ..status = ApiStatus.loading
    ..data = EmployeeModel();

  @override
  ApiResult<UserModel>? get detailResult => ApiResult()
    ..status = ApiStatus.loading
    ..data = UserModel();
}

enum EmployeeStateType {
  list,
  detail,
}
