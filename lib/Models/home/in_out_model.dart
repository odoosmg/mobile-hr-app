import 'package:json_annotation/json_annotation.dart';
part 'in_out_model.g.dart';

@JsonSerializable()
class InOutModel {
  int? id;
  int? checkInId;
  int? checkIn; // will remove after api change
  String? checkOutDatetime;
  String? checkInDatetime;

  InOutModel? latestCheckIn;
  InOutModel? latestCheckOut;

  InOutModel();

  factory InOutModel.fromJson(Map<String, dynamic> json) =>
      _$InOutModelFromJson(json);

  Map<String, dynamic> toJson() => _$InOutModelToJson(this);
}
