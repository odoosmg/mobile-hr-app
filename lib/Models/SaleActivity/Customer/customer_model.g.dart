// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerModel _$CustomerModelFromJson(Map<String, dynamic> json) =>
    CustomerModel()
      ..id = (json['id'] as num?)?.toInt()
      ..name = json['name'] as String?
      ..address = json['address'] as String?
      ..lat = (json['lat'] as num?)?.toDouble()
      ..long = (json['long'] as num?)?.toDouble()
      ..email = json['email'] as String?
      ..phone = json['phone'] as String?
      ..customerType = json['customer_type'] as String?
      ..status = json['status'] as String?
      ..gpsRange = (json['gps_range'] as num?)?.toDouble()
      ..salemanId = json['saleman_id'] as String?
      ..salemanName = json['saleman_name'] as String?
      ..list = (json['list'] as List<dynamic>?)
          ?.map((e) => CustomerModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..data = json['data'] == null
          ? null
          : CustomerModel.fromJson(json['data'] as Map<String, dynamic>)
      ..customerTypeId = (json['customer_type_id'] as num?)?.toInt();

Map<String, dynamic> _$CustomerModelToJson(CustomerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'lat': instance.lat,
      'long': instance.long,
      'email': instance.email,
      'phone': instance.phone,
      'customer_type': instance.customerType,
      'status': instance.status,
      'gps_range': instance.gpsRange,
      'saleman_id': instance.salemanId,
      'saleman_name': instance.salemanName,
      'list': instance.list,
      'data': instance.data,
      'customer_type_id': instance.customerTypeId,
    };
