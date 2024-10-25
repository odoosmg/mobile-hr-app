// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_holiday_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PublicHolidayModelAdapter extends TypeAdapter<PublicHolidayModel> {
  @override
  final int typeId = 6;

  @override
  PublicHolidayModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PublicHolidayModel()
      ..id = fields[0] as int?
      ..name = fields[1] as String?
      ..date = fields[2] as String?
      ..month = fields[3] as String?
      ..list = (fields[4] as List?)?.cast<PublicHolidayModel>()
      ..holidays = (fields[5] as List?)?.cast<PublicHolidayModel>();
  }

  @override
  void write(BinaryWriter writer, PublicHolidayModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.month)
      ..writeByte(4)
      ..write(obj.list)
      ..writeByte(5)
      ..write(obj.holidays);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PublicHolidayModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
          .toList();

Map<String, dynamic> _$PublicHolidayModelToJson(PublicHolidayModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'date': instance.date,
      'month': instance.month,
      'list': instance.list,
      'holidays': instance.holidays,
    };
