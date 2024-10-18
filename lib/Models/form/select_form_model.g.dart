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
      ..keyword = fields[2] as String?
      ..isSelected = fields[3] as bool?
      ..companySelected = (fields[4] as List?)?.cast<SelectFormModel>()
      ..companyList = (fields[5] as List?)?.cast<SelectFormModel>();
  }

  @override
  void write(BinaryWriter writer, SelectFormModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.keyword)
      ..writeByte(3)
      ..write(obj.isSelected)
      ..writeByte(4)
      ..write(obj.companySelected)
      ..writeByte(5)
      ..write(obj.companyList);
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
      ..keyword = json['keyword'] as String?
      ..isSelected = json['is_selected'] as bool?
      ..companySelected = (json['company_selected'] as List<dynamic>?)
          ?.map((e) => SelectFormModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..companyList = (json['company_list'] as List<dynamic>?)
          ?.map((e) => SelectFormModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$SelectFormModelToJson(SelectFormModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'keyword': instance.keyword,
      'is_selected': instance.isSelected,
      'company_selected': instance.companySelected,
      'company_list': instance.companyList,
    };
