import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/api/api_result.dart';
import 'package:hrm_employee/Models/auth/user_model.dart';
import 'package:hrm_employee/Models/employee/employee_model.dart';
import 'package:hrm_employee/Repository/employee_repository.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeRepository employeeRepository;
  EmployeeBloc(this.employeeRepository) : super(EmployeeInitial()) {
    on<EmployeeList>(_list);
    on<EmployeeDetail>(_detail);
  }

  void _list(EmployeeList event, Emitter<EmployeeState> emit) async {
    state.stateType = EmployeeStateType.list;
    state.listResult!.status = ApiStatus.loading;
    emit(state.copyWith(state));

    await employeeRepository.list().then((value) {
      state.listResult = value;
      if (value.isSuccess) {
        if (value.data!.list!.isEmpty) {
          state.listResult!.status = ApiStatus.empty;
        }
      }
      emit(state.copyWith(state));
    });
  }

  void _detail(EmployeeDetail event, Emitter<EmployeeState> emit) async {
    state.stateType = EmployeeStateType.detail;
    state.detailResult!.status = ApiStatus.loading;
    emit(state.copyWith(state));

    await employeeRepository.detail(event.id).then((value) {
      state.detailResult = value;
      emit(state.copyWith(state));
    });
  }
}
