// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'in_out_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InOutModel _$InOutModelFromJson(Map<String, dynamic> json) => InOutModel()
  ..id = (json['id'] as num?)?.toInt()
  ..checkInId = (json['check_in_id'] as num?)?.toInt()
  ..checkIn = (json['check_in'] as num?)?.toInt()
  ..checkOutDatetime = json['check_out_datetime'] as String?
  ..checkInDatetime = json['check_in_datetime'] as String?
  ..latestCheckIn = json['latest_check_in'] == null
      ? null
      : InOutModel.fromJson(json['latest_check_in'] as Map<String, dynamic>)
  ..latestCheckOut = json['latest_check_out'] == null
      ? null
      : InOutModel.fromJson(json['latest_check_out'] as Map<String, dynamic>)
  ..leaveSummary = (json['leave_summary'] as List<dynamic>?)
      ?.map((e) => LeaveModel.fromJson(e as Map<String, dynamic>))
      .toList()
  ..todayLeave = (json['today_leave'] as List<dynamic>?)
      ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
      .toList()
  ..list = (json['list'] as List<dynamic>?)
      ?.map((e) => InOutModel.fromJson(e as Map<String, dynamic>))
      .toList()
  ..page = (json['page'] as num?)?.toInt()
  ..workHours = (json['work_hours'] as num?)?.toDouble()
  ..dataStatus = $enumDecodeNullable(_$ApiStatusEnumMap, json['data_status']);

Map<String, dynamic> _$InOutModelToJson(InOutModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'check_in_id': instance.checkInId,
      'check_in': instance.checkIn,
      'check_out_datetime': instance.checkOutDatetime,
      'check_in_datetime': instance.checkInDatetime,
      'latest_check_in': instance.latestCheckIn,
      'latest_check_out': instance.latestCheckOut,
      'leave_summary': instance.leaveSummary,
      'today_leave': instance.todayLeave,
      'list': instance.list,
      'page': instance.page,
      'work_hours': instance.workHours,
      'data_status': _$ApiStatusEnumMap[instance.dataStatus],
    };

const _$ApiStatusEnumMap = {
  ApiStatus.loading: 'loading',
  ApiStatus.success: 'success',
  ApiStatus.failed: 'failed',
  ApiStatus.connectionError: 'connectionError',
  ApiStatus.loginExpired: 'loginExpired',
  ApiStatus.unAuthorize: 'unAuthorize',
  ApiStatus.empty: 'empty',
};
