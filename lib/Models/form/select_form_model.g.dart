// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_form_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SelectFormModelAdapter extends TypeAdapter<SelectFormModel> {
  @override
  final int typeId = 4;

  @override
  SelectFormModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SelectFormModel()
      ..id = fields[0] as int?
      ..name = fields[1] as String?
      ..keyword = fields[2] as String?;
  }

  @override
  void write(BinaryWriter writer, SelectFormModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.keyword);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectFormModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelectFormModel _$SelectFormModelFromJson(Map<String, dynamic> json) =>
    SelectFormModel()
      ..id = (json['id'] as num?)?.toInt()
      ..name = json['name'] as String?
      ..keyword = json['keyword'] as String?;

Map<String, dynamic> _$SelectFormModelToJson(SelectFormModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'keyword': instance.keyword,
    };
