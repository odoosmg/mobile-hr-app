part of 'employee_bloc.dart';

class EmployeeState {
  EmployeeStateType? stateType;
  ApiResult<EmployeeModel>? listResult;
  EmployeeState({
    this.stateType,
    this.listResult,
  });

  EmployeeState copyWith(EmployeeState d) {
    return EmployeeState(
      stateType: d.stateType,
      listResult: d.listResult,
    );
  }
}

final class EmployeeInitial extends EmployeeState {
  @override
  ApiResult<EmployeeModel>? get listResult => ApiResult()
    ..status = ApiStatus.loading
    ..data = EmployeeModel();
}

enum EmployeeStateType {
  list,
}
