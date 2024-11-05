// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveModel _$LeaveModelFromJson(Map<String, dynamic> json) => LeaveModel()
  ..id = (json['id'] as num?)?.toInt()
  ..employeeId = (json['employee_id'] as num?)?.toInt()
  ..initId = (json['init_id'] as num?)?.toInt()
  ..name = json['name'] as String?
  ..employeeName = json['employee_name'] as String?
  ..allocate = json['allocate'] as String?
  ..approved = json['approved'] as String?
  ..remaining = json['remaining'] as String?
  ..dateFrom = json['date_from'] as String?
  ..dateTo = json['date_to'] as String?
  ..description = json['description'] as String?
  ..isHalfDay = json['is_half_day'] as bool?
  ..datePeriod = json['date_period'] as String?
  ..leaveTypeId = (json['leave_type_id'] as num?)?.toInt()
  ..leaveTypeName = json['leave_type_name'] as String?
  ..numberOfDays = (json['number_of_days'] as num?)?.toDouble()
  ..state = json['state'] as String?
  ..leaveTypeList = (json['leave_type_list'] as List<dynamic>?)
      ?.map((e) => SelectFormModel.fromJson(e as Map<String, dynamic>))
      .toList()
  ..leaveAllocatedSummary = (json['leave_allocated_summary'] as List<dynamic>?)
      ?.map((e) => LeaveModel.fromJson(e as Map<String, dynamic>))
      .toList()
  ..toApprovedList = (json['to_approved_list'] as List<dynamic>?)
      ?.map((e) => LeaveModel.fromJson(e as Map<String, dynamic>))
      .toList()
  ..list = (json['list'] as List<dynamic>?)
      ?.map((e) => LeaveModel.fromJson(e as Map<String, dynamic>))
      .toList()
  ..requestDateFromPeriod = json['request_date_from_period'] as String?
  ..requestUnitHalf = json['request_unit_half'] as bool?;

Map<String, dynamic> _$LeaveModelToJson(LeaveModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employee_id': instance.employeeId,
      'init_id': instance.initId,
      'name': instance.name,
      'employee_name': instance.employeeName,
      'allocate': instance.allocate,
      'approved': instance.approved,
      'remaining': instance.remaining,
      'date_from': instance.dateFrom,
      'date_to': instance.dateTo,
      'description': instance.description,
      'is_half_day': instance.isHalfDay,
      'date_period': instance.datePeriod,
      'leave_type_id': instance.leaveTypeId,
      'leave_type_name': instance.leaveTypeName,
      'number_of_days': instance.numberOfDays,
      'state': instance.state,
      'leave_type_list': instance.leaveTypeList,
      'leave_allocated_summary': instance.leaveAllocatedSummary,
      'to_approved_list': instance.toApprovedList,
      'list': instance.list,
      'request_date_from_period': instance.requestDateFromPeriod,
      'request_unit_half': instance.requestUnitHalf,
    };
