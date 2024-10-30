import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/form/select_form_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 3)
@JsonSerializable()
class UserModel {
  static const boxName = 'UserModel';
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? email;

  @HiveField(3)
  String? phone;

  @HiveField(4)
  String? department;

  @HiveField(5)
  String? position;

  @HiveField(6)
  SelectFormModel? company;

  @HiveField(7)
  String? image;

  @HiveField(8)
  String? manager;

  @HiveField(9)
  String? status;

  @HiveField(10)
  String? employeeName;

  @HiveField(11)
  String? departmentName;

  @HiveField(12)
  String? companyName;

  UserModel();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  LeaveStatus? getLeaveStatus() {
    if (status == null) {
      return null;
    }

    switch (status) {
      case 'To Approve':
        return LeaveStatus.pending;
      case 'Refused':
        return LeaveStatus.refused;
      default:
        return LeaveStatus.approved;
    }
  }
}
