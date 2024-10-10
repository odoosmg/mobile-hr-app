import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/api/api_result.dart';
import 'package:hrm_employee/Models/employee/employee_model.dart';
import 'package:hrm_employee/Repository/employee_repository.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeRepository employeeRepository;
  EmployeeBloc(this.employeeRepository) : super(EmployeeInitial()) {
    on<EmployeeList>(_list);
  }

  void _list(EmployeeList event, Emitter<EmployeeState> emit) async {
    state.stateType = EmployeeStateType.list;
    state.listResult!.status = ApiStatus.loading;
    emit(state.copyWith(state));

    await employeeRepository.list().then((value) {
      state.listResult = value;
      emit(state.copyWith(state));
    });
  }
}
