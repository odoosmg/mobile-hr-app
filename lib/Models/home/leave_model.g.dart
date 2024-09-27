// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveModel _$LeaveModelFromJson(Map<String, dynamic> json) => LeaveModel()
  ..id = (json['id'] as num?)?.toInt()
  ..name = json['name'] as String?
  ..allocate = json['allocate'] as String?
  ..approved = json['approved'] as String?
  ..remaining = json['remaining'] as String?
  ..dateForm = json['date_form'] as String?
  ..dateTo = json['date_to'] as String?
  ..description = json['description'] as String?
  ..isHalfDay = json['is_half_day'] as bool?
  ..datePeriod = json['date_period'] as String?
  ..leaveTypeId = (json['leave_type_id'] as num?)?.toInt()
  ..leaveTypeList = (json['leave_type_list'] as List<dynamic>?)
      ?.map((e) => SelectFormModel.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$LeaveModelToJson(LeaveModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'allocate': instance.allocate,
      'approved': instance.approved,
      'remaining': instance.remaining,
      'date_form': instance.dateForm,
      'date_to': instance.dateTo,
      'description': instance.description,
      'is_half_day': instance.isHalfDay,
      'date_period': instance.datePeriod,
      'leave_type_id': instance.leaveTypeId,
      'leave_type_list': instance.leaveTypeList,
    };