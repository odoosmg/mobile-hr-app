import 'package:hrm_employee/Models/auth/user_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'employee_model.g.dart';

@JsonSerializable()
class EmployeeModel {
  int? id;
  List<UserModel>? list;

  EmployeeModel();

  factory EmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeModelToJson(this);
}
