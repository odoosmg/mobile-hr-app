import 'package:hrm_employee/Helper/k_enum.dart';
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

  String? dateFrom, dateTo;
  String? description;
  bool? isHalfDay;
  String? datePeriod;
  int? leaveTypeId;
  String? leaveTypeName;
  double? numberOfDays;
  String? state;

  List<SelectFormModel>? leaveTypeList;
  List<LeaveModel>? leaveAllocatedSummary;
  List<LeaveModel>? list;

  LeaveModel();

  factory LeaveModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveModelFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveModelToJson(this);

  LeaveStatus? get getLeaveStatus {
    if (state == null) {
      return null;
    }

    switch (state) {
      case 'To Approve':
        return LeaveStatus.pending;
      case 'Refused':
        return LeaveStatus.refused;
      default:
        return LeaveStatus.approved;
    }
  }
}
