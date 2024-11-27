import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:json_annotation/json_annotation.dart';
part 'sales_model.g.dart';

@JsonSerializable()
class SalesModel {
  int? id;
  String? customerName;
  int? partnerId;
  int? userId;

  String? todoDate;
  String? checkInDate;
  String? checkOutDate;

  String? status;
  String? address;
  String? customerCode;

  double? lat, long;
  String? photoLat, photoLong;

  bool? hasOrder;
  String? remark;
  double? gpsRange;

  int? checkInId;

  List<SalesModel>? list;
  SalesModel? data;

  String? photo;

  SalesModel();

  factory SalesModel.fromJson(Map<String, dynamic> json) =>
      _$SalesModelFromJson(json);

  Map<String, dynamic> toJson() => _$SalesModelToJson(this);

  SaleActivtyStatus? get getActivityStatus {
    if (status == SaleActivtyStatus.checkin.name) {
      return SaleActivtyStatus.checkin;
    }
    if (status == SaleActivtyStatus.checkout.name) {
      return SaleActivtyStatus.checkout;
    }
    if (status == SaleActivtyStatus.checkoutOrder.name) {
      return SaleActivtyStatus.checkoutOrder;
    }
    if (status == SaleActivtyStatus.todo.name) {
      return SaleActivtyStatus.todo;
    }
    return null;
  }

  /// Copy to new address
  SalesModel copy(SalesModel newData) {
    SalesModel d = SalesModel();

    d.id = newData.id;
    d.customerName = newData.customerName;
    d.partnerId = newData.partnerId;
    d.userId = newData.userId;

    d.todoDate = newData.todoDate;
    d.checkInDate = newData.checkInDate;
    d.checkOutDate = newData.checkOutDate;

    d.lat = newData.lat;
    d.long = newData.long;
    d.photoLat = newData.photoLat;
    d.photoLong = newData.photoLong;

    d.hasOrder = newData.hasOrder;
    d.remark = newData.remark;
    d.gpsRange = newData.gpsRange;

    d.list = List<SalesModel>.from(list ?? []);

    return d;
  }
}
