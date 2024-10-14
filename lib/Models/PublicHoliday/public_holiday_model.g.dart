// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_holiday_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicHolidayModel _$PublicHolidayModelFromJson(Map<String, dynamic> json) =>
    PublicHolidayModel()
      ..id = (json['id'] as num?)?.toInt()
      ..name = json['name'] as String?
      ..date = json['date'] as String?
      ..month = json['month'] as String?
      ..list = (json['list'] as List<dynamic>?)
          ?.map((e) => PublicHolidayModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..holidays = (json['holidays'] as List<dynamic>?)
          ?.map((e) => PublicHolidayModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..listStrDates = (json['list_str_dates'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList();

Map<String, dynamic> _$PublicHolidayModelToJson(PublicHolidayModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'date': instance.date,
      'month': instance.month,
      'list': instance.list,
      'holidays': instance.holidays,
      'list_str_dates': instance.listStrDates,
    };
