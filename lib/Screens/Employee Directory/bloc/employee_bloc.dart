import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/Repository/employee_repository.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeRepository employeeRepository;
  EmployeeBloc(this.employeeRepository) : super(EmployeeInitial()) {
    on<EmployeeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
