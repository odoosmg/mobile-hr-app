// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdersModel _$OrdersModelFromJson(Map<String, dynamic> json) => OrdersModel()
  ..id = (json['id'] as num?)?.toInt()
  ..name = json['name'] as String?
  ..partnerId = (json['partner_id'] as num?)?.toInt()
  ..dateOrder = json['date_order'] as String?
  ..deliveryDate = json['delivery_date'] as String?
  ..partnerName = json['partner_name'] as String?
  ..amount = (json['amount'] as num?)?.toDouble()
  ..status = json['status'] as String?
  ..statusValue = json['status_value'] as String?
  ..deliveryAddressId = (json['delivery_address_id'] as num?)?.toInt()
  ..deliveryAddress = json['delivery_address'] as String?
  ..list = (json['list'] as List<dynamic>?)
      ?.map((e) => OrdersModel.fromJson(e as Map<String, dynamic>))
      .toList()
  ..dateStr = json['date_str'] as String?
  ..customerId = (json['customer_id'] as num?)?.toInt()
  ..distributorId = (json['distributor_id'] as num?)?.toInt()
  ..orderId = (json['order_id'] as num?)?.toInt()
  ..remark = json['remark'] as String?
  ..note = json['note'] as String?
  ..globalDiscount = (json['global_discount'] as num?)?.toDouble()
  ..data = json['data'] == null
      ? null
      : OrdersModel.fromJson(json['data'] as Map<String, dynamic>)
  ..orderLines = (json['order_lines'] as List<dynamic>?)
      ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$OrdersModelToJson(OrdersModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'partner_id': instance.partnerId,
      'date_order': instance.dateOrder,
      'delivery_date': instance.deliveryDate,
      'partner_name': instance.partnerName,
      'amount': instance.amount,
      'status': instance.status,
      'status_value': instance.statusValue,
      'delivery_address_id': instance.deliveryAddressId,
      'delivery_address': instance.deliveryAddress,
      'list': instance.list,
      'date_str': instance.dateStr,
      'customer_id': instance.customerId,
      'distributor_id': instance.distributorId,
      'order_id': instance.orderId,
      'remark': instance.remark,
      'note': instance.note,
      'global_discount': instance.globalDiscount,
      'data': instance.data,
      'order_lines': instance.orderLines,
    };
