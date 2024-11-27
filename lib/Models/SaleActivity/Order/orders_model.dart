import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/SaleActivity/Order/product_model.dart';
import 'package:hrm_employee/utlis/measurement.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orders_model.g.dart';

@JsonSerializable()
class OrdersModel {
  int? id;

  String? name;
  int? partnerId;

  String? dateOrder;
  String? deliveryDate;
  String? partnerName;
  double? amount;
  String? status;
  String? statusValue;
  int? deliveryAddressId;
  String? deliveryAddress;

  // List<OrdersModel>? data;
  List<OrdersModel>? list;

  String? dateStr;

  int? customerId, distributorId, orderId;

  String? remark, note;

  double? globalDiscount;

  OrdersModel? data;

  List<ProductModel>? orderLines;

  OrdersModel();

  /// total sub item price
  double get getSubTotal {
    double d = 0;

    (orderLines ?? []).map((e) {
      return d += e.getItemPrice;
    }).toList();

    return d;
  }

  ///
  OrderStatus get getStatus {
    if (statusValue == OrderStatus.cancelled.name) {
      return OrderStatus.cancelled;
    }

    if (statusValue == OrderStatus.saleOrder.name) {
      return OrderStatus.saleOrder;
    }
    return OrderStatus.quotation;
  }

  /// with global discount
  double get getTotalPrice {
    return Measurement.discount(getSubTotal, globalDiscount ?? 0);
  }

  factory OrdersModel.fromJson(Map<String, dynamic> json) =>
      _$OrdersModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OrdersModelToJson(this);
}
