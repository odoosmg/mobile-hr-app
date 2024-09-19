// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) => Session()
  ..id = (json['id'] as num?)?.toInt()
  ..username = json['username'] as String?
  ..accessToken = json['access_token'] as String?
  ..userId = (json['user_id'] as num?)?.toInt()
  ..data = json['data'] == null
      ? null
      : Session.fromJson(json['data'] as Map<String, dynamic>)
  ..refreshToken = json['refresh_token'] as String?;

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'access_token': instance.accessToken,
      'user_id': instance.userId,
      'data': instance.data,
      'refresh_token': instance.refreshToken,
    };
