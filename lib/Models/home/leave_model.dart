import 'package:hrm_employee/Models/form/select_form_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'leave_model.g.dart';

@JsonSerializable()
class LeaveModel {
  int? id;
  String? name;
  String? allocate;
  String? approved;
  String? remaining;

  String? dateForm, dateTo;
  String? description;
  bool? isHalfDay;
  String? datePeriod;
  int? leaveTypeId;

  List<SelectFormModel>? leaveTypeList;

  LeaveModel();

  factory LeaveModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveModelFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveModelToJson(this);
}
