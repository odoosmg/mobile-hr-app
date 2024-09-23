// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SessionAdapter extends TypeAdapter<Session> {
  @override
  final int typeId = 1;

  @override
  Session read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Session()
      ..id = fields[0] as int?
      ..username = fields[1] as String?
      ..accessToken = fields[2] as String?
      ..userId = fields[3] as int?
      ..data = fields[4] as Session?
      ..refreshToken = fields[5] as String?
      ..myProfile = fields[6] as UserModel?;
  }

  @override
  void write(BinaryWriter writer, Session obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.accessToken)
      ..writeByte(3)
      ..write(obj.userId)
      ..writeByte(4)
      ..write(obj.data)
      ..writeByte(5)
      ..write(obj.refreshToken)
      ..writeByte(6)
      ..write(obj.myProfile);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
  ..refreshToken = json['refresh_token'] as String?
  ..myProfile = json['my_profile'] == null
      ? null
      : UserModel.fromJson(json['my_profile'] as Map<String, dynamic>);

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'access_token': instance.accessToken,
      'user_id': instance.userId,
      'data': instance.data,
      'refresh_token': instance.refreshToken,
      'my_profile': instance.myProfile,
    };
