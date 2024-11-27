// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesModel _$SalesModelFromJson(Map<String, dynamic> json) => SalesModel()
  ..id = (json['id'] as num?)?.toInt()
  ..customerName = json['customer_name'] as String?
  ..partnerId = (json['partner_id'] as num?)?.toInt()
  ..userId = (json['user_id'] as num?)?.toInt()
  ..todoDate = json['todo_date'] as String?
  ..checkInDate = json['check_in_date'] as String?
  ..checkOutDate = json['check_out_date'] as String?
  ..status = json['status'] as String?
  ..address = json['address'] as String?
  ..customerCode = json['customer_code'] as String?
  ..lat = (json['lat'] as num?)?.toDouble()
  ..long = (json['long'] as num?)?.toDouble()
  ..photoLat = json['photo_lat'] as String?
  ..photoLong = json['photo_long'] as String?
  ..hasOrder = json['has_order'] as bool?
  ..remark = json['remark'] as String?
  ..gpsRange = (json['gps_range'] as num?)?.toDouble()
  ..checkInId = (json['check_in_id'] as num?)?.toInt()
  ..list = (json['list'] as List<dynamic>?)
      ?.map((e) => SalesModel.fromJson(e as Map<String, dynamic>))
      .toList()
  ..data = json['data'] == null
      ? null
      : SalesModel.fromJson(json['data'] as Map<String, dynamic>)
  ..photo = json['photo'] as String?;

Map<String, dynamic> _$SalesModelToJson(SalesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customer_name': instance.customerName,
      'partner_id': instance.partnerId,
      'user_id': instance.userId,
      'todo_date': instance.todoDate,
      'check_in_date': instance.checkInDate,
      'check_out_date': instance.checkOutDate,
      'status': instance.status,
      'address': instance.address,
      'customer_code': instance.customerCode,
      'lat': instance.lat,
      'long': instance.long,
      'photo_lat': instance.photoLat,
      'photo_long': instance.photoLong,
      'has_order': instance.hasOrder,
      'remark': instance.remark,
      'gps_range': instance.gpsRange,
      'check_in_id': instance.checkInId,
      'list': instance.list,
      'data': instance.data,
      'photo': instance.photo,
    };
