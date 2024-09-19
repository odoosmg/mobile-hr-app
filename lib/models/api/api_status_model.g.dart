// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiStatusModel<T> _$ApiStatusModelFromJson<T>(Map<String, dynamic> json) =>
    ApiStatusModel<T>()
      ..statusCode = (json['status_code'] as num?)?.toInt()
      ..errorMessage = json['error_message'] as String?;

Map<String, dynamic> _$ApiStatusModelToJson<T>(ApiStatusModel<T> instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'error_message': instance.errorMessage,
    };
