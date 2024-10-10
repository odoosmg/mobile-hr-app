part of 'employee_bloc.dart';

class EmployeeEvent {}

class EmployeeList extends EmployeeEvent {}

class EmployeeDetail extends EmployeeEvent {
  final int id;
  EmployeeDetail(this.id);
}
