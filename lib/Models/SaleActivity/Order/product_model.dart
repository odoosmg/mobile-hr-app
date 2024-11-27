import 'package:hrm_employee/utlis/measurement.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  String? name, productName;

  double? salePrice;
  String? productUom; // unit
  int? productUomQty;
  int? productUomId;

  int? qty;
  double? discount, globalDiscount;
  int? foc;

  /// pice in 1 item, this value should not override
  double? pricePerUnit, priceUnit;

  double? total, subTotal;

  List<ProductModel>? list;
  List<ProductModel>? orderLines;

  ProductModel();

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  /// Calculate discount only in item. not in global
  /// use in OrderList and OrderDetail
  double get getItemPrice => Measurement.discount(
      (priceUnit ?? 0) * (productUomQty ?? 1), (discount ?? 0));

  /// different key
  /// use in OrderAdd and OrderUpdatre
  double get getItemPrice2 =>
      Measurement.discount((pricePerUnit ?? 0) * (qty ?? 1), (discount ?? 0));

  double get subTotalPrice {
    double tt = 0;
    for (int i = 0; i < orderLines!.length; i++) {
      tt += orderLines![i].salePrice ?? 0;
    }
    return tt;
  }

  @override
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
