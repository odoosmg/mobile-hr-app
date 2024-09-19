// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 3;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel()
      ..id = fields[0] as int?
      ..name = fields[1] as String?
      ..email = fields[2] as String?
      ..phone = fields[3] as String?
      ..department = fields[4] as String?
      ..position = fields[5] as String?
      ..company = fields[6] as String?
      ..image = fields[7] as String?
      ..manager = fields[8] as String?
      ..status = fields[9] as String?
      ..employeeName = fields[10] as String?
      ..departmentName = fields[11] as String?;
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.department)
      ..writeByte(5)
      ..write(obj.position)
      ..writeByte(6)
      ..write(obj.company)
      ..writeByte(7)
      ..write(obj.image)
      ..writeByte(8)
      ..write(obj.manager)
      ..writeByte(9)
      ..write(obj.status)
      ..writeByte(10)
      ..write(obj.employeeName)
      ..writeByte(11)
      ..write(obj.departmentName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel()
  ..id = (json['id'] as num?)?.toInt()
  ..name = json['name'] as String?
  ..email = json['email'] as String?
  ..phone = json['phone'] as String?
  ..department = json['department'] as String?
  ..position = json['position'] as String?
  ..company = json['company'] as String?
  ..image = json['image'] as String?
  ..manager = json['manager'] as String?
  ..status = json['status'] as String?
  ..employeeName = json['employee_name'] as String?
  ..departmentName = json['department_name'] as String?;

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'department': instance.department,
      'position': instance.position,
      'company': instance.company,
      'image': instance.image,
      'manager': instance.manager,
      'status': instance.status,
      'employee_name': instance.employeeName,
      'department_name': instance.departmentName,
    };
