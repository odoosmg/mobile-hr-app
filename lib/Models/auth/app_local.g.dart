// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppLocalAdapter extends TypeAdapter<AppLocal> {
  @override
  final int typeId = 2;

  @override
  AppLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppLocal()
      ..id = fields[0] as int?
      ..isConnectInternet = fields[1] as bool?
      ..isDarkMode = fields[2] == null ? false : fields[2] as bool
      ..lang = fields[3] as String?
      ..isCallApi = fields[4] == null ? false : fields[4] as bool?;
  }

  @override
  void write(BinaryWriter writer, AppLocal obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.isConnectInternet)
      ..writeByte(2)
      ..write(obj.isDarkMode)
      ..writeByte(3)
      ..write(obj.lang)
      ..writeByte(4)
      ..write(obj.isCallApi);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppLocal _$AppLocalFromJson(Map<String, dynamic> json) => AppLocal()
  ..id = (json['id'] as num?)?.toInt()
  ..isConnectInternet = json['is_connect_internet'] as bool?
  ..isDarkMode = json['is_dark_mode'] as bool
  ..lang = json['lang'] as String?
  ..isCallApi = json['is_call_api'] as bool?;

Map<String, dynamic> _$AppLocalToJson(AppLocal instance) => <String, dynamic>{
      'id': instance.id,
      'is_connect_internet': instance.isConnectInternet,
      'is_dark_mode': instance.isDarkMode,
      'lang': instance.lang,
      'is_call_api': instance.isCallApi,
    };
