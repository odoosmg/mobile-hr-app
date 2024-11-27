import 'package:json_annotation/json_annotation.dart';
part 'customer_model.g.dart';

@JsonSerializable()
class CustomerModel {
  int? id;
  String? name;
  String? address;
  double? lat, long;
  String? email;
  String? phone;

  String? customerType;
  String? status;
  double? gpsRange;
  String? salemanId;
  String? salemanName;

  List<CustomerModel>? list;
  CustomerModel? data;

  int? customerTypeId;

  CustomerModel();

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);
}
