// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel()
  ..name = json['name'] as String?
  ..productName = json['product_name'] as String?
  ..salePrice = (json['sale_price'] as num?)?.toDouble()
  ..productUom = json['product_uom'] as String?
  ..productUomQty = (json['product_uom_qty'] as num?)?.toInt()
  ..productUomId = (json['product_uom_id'] as num?)?.toInt()
  ..qty = (json['qty'] as num?)?.toInt()
  ..discount = (json['discount'] as num?)?.toDouble()
  ..globalDiscount = (json['global_discount'] as num?)?.toDouble()
  ..foc = (json['foc'] as num?)?.toInt()
  ..pricePerUnit = (json['price_per_unit'] as num?)?.toDouble()
  ..priceUnit = (json['price_unit'] as num?)?.toDouble()
  ..total = (json['total'] as num?)?.toDouble()
  ..subTotal = (json['sub_total'] as num?)?.toDouble()
  ..list = (json['list'] as List<dynamic>?)
      ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
      .toList()
  ..orderLines = (json['order_lines'] as List<dynamic>?)
      ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'product_name': instance.productName,
      'sale_price': instance.salePrice,
      'product_uom': instance.productUom,
      'product_uom_qty': instance.productUomQty,
      'product_uom_id': instance.productUomId,
      'qty': instance.qty,
      'discount': instance.discount,
      'global_discount': instance.globalDiscount,
      'foc': instance.foc,
      'price_per_unit': instance.pricePerUnit,
      'price_unit': instance.priceUnit,
      'total': instance.total,
      'sub_total': instance.subTotal,
      'list': instance.list,
      'order_lines': instance.orderLines,
    };
