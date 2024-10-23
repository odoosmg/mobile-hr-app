// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_permission_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppPermissionModelAdapter extends TypeAdapter<AppPermissionModel> {
  @override
  final int typeId = 5;

  @override
  AppPermissionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppPermissionModel()
      ..id = fields[0] as int?
      ..isApprover = fields[1] as bool?
      ..leave = fields[2] as AppPermissionModel?
      ..isRetrieveSuccess = fields[3] as bool?
      ..data = fields[4] as AppPermissionModel?;
  }

  @override
  void write(BinaryWriter writer, AppPermissionModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.isApprover)
      ..writeByte(2)
      ..write(obj.leave)
      ..writeByte(3)
      ..write(obj.isRetrieveSuccess)
      ..writeByte(4)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppPermissionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppPermissionModel _$AppPermissionModelFromJson(Map<String, dynamic> json) =>
    AppPermissionModel()
      ..id = (json['id'] as num?)?.toInt()
      ..isApprover = json['is_approver'] as bool?
      ..leave = json['leave'] == null
          ? null
          : AppPermissionModel.fromJson(json['leave'] as Map<String, dynamic>)
      ..isRetrieveSuccess = json['is_retrieve_success'] as bool?
      ..data = json['data'] == null
          ? null
          : AppPermissionModel.fromJson(json['data'] as Map<String, dynamic>);

Map<String, dynamic> _$AppPermissionModelToJson(AppPermissionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'is_approver': instance.isApprover,
      'leave': instance.leave,
      'is_retrieve_success': instance.isRetrieveSuccess,
      'data': instance.data,
    };
